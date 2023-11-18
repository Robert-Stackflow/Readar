import 'package:cloudreader/Api/Rss/google_reader_service_handler.dart';
import 'package:cloudreader/Handler/rss_service_handler.dart';
import 'package:cloudreader/Models/feed_setting.dart';
import 'package:cloudreader/Models/rss_service.dart';
import 'package:sqflite/sqflite.dart';

import '../Database/create_table_sql.dart';
import '../Database/feed_dao.dart';
import '../Database/rss_item_dao.dart';
import '../Models/feed.dart';
import '../Models/rss_item.dart';
import '../Providers/provider_manager.dart';
import '../Utils/iprint.dart';
import '../Utils/utils.dart';

class RssHandler {
  RssService rssService;
  late RssServiceHandler rssServiceHandler;

  bool syncing = false;

  RssHandler(this.rssService) {
    rssServiceHandler = GoogleReaderRssServiceHandler(rssService);
  }

  Future<void> init({bool forceSync = false}) async {
    FeedDao.queryByServiceId(rssService.id!).then((value) async {
      for (Feed feed in value) {
        _fidToFeedMap[feed.fid] = feed;
      }
      await updateAllUnreadCount();
    });
    if (forceSync || rssService.pullOnStartUp) {
      await syncWithService();
    }
  }

  Future<void> removeService() async {
    if (syncing) return;
    syncing = true;
    var sids = getFeeds().map((s) => s.fid).toList();
    await deleteFeeds(sids);
    rssServiceHandler.removeService();
    syncing = false;
  }

  Future<void> syncWithService() async {
    if (syncing) return;
    syncing = true;
    try {
      await rssServiceHandler.authenticate();
      IPrint.debug("authed");
      await syncFeeds();
      IPrint.debug("synced Feeds");
      await syncItems();
      IPrint.debug("synced Items");
      await fetchItems();
      IPrint.debug("fetched Items");
      rssService.lastSyncStatus = SyncStatus.success;
    } catch (exp) {
      rssService.lastSyncStatus = SyncStatus.fail;
    }
    rssService.lastSyncTime = DateTime.now();
    syncing = false;
  }

  //订阅源相关变量
  final Map<String, Feed> _fidToFeedMap = {};
  final Map<String, Feed> _deletedSidToFeedMap = {};

  //文章条目相关变量
  final Map<String, RssItem> _idToItemMap = {};

  bool containsFeed(String id) => _fidToFeedMap.containsKey(id);

  Feed getFeed(String id) => _fidToFeedMap[id] ?? _deletedSidToFeedMap[id]!;

  Iterable<Feed> getFeeds() => _fidToFeedMap.values;

  bool containsItem(String id) => _idToItemMap.containsKey(id);

  RssItem getItem(String id) => _idToItemMap[id]!;

  Iterable<RssItem> getItems() => _idToItemMap.values;

  ///
  /// 更新所有订阅源的未读条数
  ///
  Future<void> updateAllUnreadCount() async {
    final rows = await RssItemDao.queryUnReadCountByFeedFid();
    for (var feed in _fidToFeedMap.values) {
      var cloned = feed.clone();
      _fidToFeedMap[feed.fid] = cloned;
      cloned.unReadCount = 0;
    }
    IPrint.debug(rows);
    for (var row in rows) {
      _fidToFeedMap[row["feedFid"]]!.unReadCount = row["COUNT(iid)"]!;
    }
  }

  ///
  /// 更新某订阅源的未读条数
  ///
  void updateUnreadCount(String fid, int diff) {
    _fidToFeedMap[fid]!.unReadCount = _fidToFeedMap[fid]!.unReadCount + diff;
  }

  ///
  /// 合并拉取的条目
  ///
  Future<void> mergeFetchedItems(Iterable<RssItem> items) async {
    Set<String> changed = {};
    for (var item in items) {
      var feed = _fidToFeedMap[item.feedFid]!;
      if (!item.hasRead) feed.unReadCount = feed.unReadCount + 1;
      if (item.date.compareTo(feed.latestArticleTime!) > 0 ||
          feed.latestArticleTitle!.isEmpty) {
        feed.latestArticleTime = item.date;
        feed.latestArticleTitle = item.title;
        changed.add(feed.fid);
      }
    }
    if (changed.isNotEmpty) {
      var batch = ProviderManager.db.batch();
      for (var fid in changed) {
        var feed = _fidToFeedMap[fid]!;
        batch.update(
          CreateTableSql.feed.tableName,
          {
            "latestArticleTime": feed.latestArticleTime!.millisecondsSinceEpoch,
            "latestArticleTitle": feed.latestArticleTitle!,
          },
          where: "fid = ?",
          whereArgs: [feed.fid],
        );
      }
      await batch.commit();
    }
  }

  ///
  /// 添加订阅源
  ///
  /// [feed] 待添加订阅源
  ///
  /// [force] 是否强制添加
  ///
  Future<void> insertFeed(Feed feed, {force = false}) async {
    if (_deletedSidToFeedMap.containsKey(feed.fid) && !force) return;
    _fidToFeedMap[feed.fid] = feed;
    await FeedDao.insert(feed);
  }

  ///
  /// 添加一系列订阅源
  ///
  /// [feeds] 待添加订阅源列表
  ///
  /// [force] 是否强制添加
  ///
  Future<void> insertFeeds(Iterable<Feed> feeds, {force = false}) async {
    List<Feed> batchedFeeds = [];
    for (var feed in feeds) {
      if (_deletedSidToFeedMap.containsKey(feed.fid) && !force) continue;
      _fidToFeedMap[feed.fid] = feed;
      feed.serviceId = rssService.id!;
      batchedFeeds.add(feed);
    }
    await FeedDao.insertAll(batchedFeeds);
  }

  Future<void> syncFeeds() async {
    final feedsAndGroupsTuple = await rssServiceHandler.fetchFeedsAndGroups();
    final feeds = feedsAndGroupsTuple.item1;
    var oldSids = Set<String>.from(_fidToFeedMap.keys);
    List<Feed> newFeeds = [];
    for (var feed in feeds) {
      if (oldSids.contains(feed.fid)) {
        oldSids.remove(feed.fid);
      } else {
        newFeeds.add(feed);
      }
    }
    await insertFeeds(newFeeds, force: true);
    await deleteFeeds(oldSids);
    // ProviderManager.groupsProvider.groups = feedsAndGroupsTuple.item2;
    fetchFeedFavicons();
  }

  ///
  /// 删除订阅源
  ///
  /// [fids] 待删除订阅源的FID列表
  ///
  Future<void> deleteFeeds(Iterable<String> fids) async {
    List<String> batchedFids = [];
    for (var fid in fids) {
      if (!_fidToFeedMap.containsKey(fid)) continue;
      batchedFids.add(fid);
      _deletedSidToFeedMap[fid] = _fidToFeedMap[fid]!;
      _fidToFeedMap.remove(fid);
    }
    await FeedDao.deleteAll(batchedFids);
    // ProviderManager.feedContentProvider.initAll();
  }

  ///
  /// 获取图标
  ///
  Future<void> fetchFeedFavicons() async {
    for (var fid in _fidToFeedMap.keys) {
      if (_fidToFeedMap[fid]?.iconUrl == null) {
        Utils.fetchFeedFavicon(_fidToFeedMap[fid]!.url).then((url) {
          if (!_fidToFeedMap.containsKey(fid)) return;
          var feed = _fidToFeedMap[fid]!.clone();
          feed.iconUrl = url;
          insertFeed(feed);
        });
      }
    }
  }

  void mappingItems(Iterable<RssItem> items) {
    for (var item in items) {
      _idToItemMap[item.iid] = item;
    }
  }

  ///
  /// 更新某个文章条目
  ///
  Future<void> updateItem(
    String iid, {
    Batch? batch,
    bool? read,
    bool? starred,
    local = false,
  }) async {
    Map<String, dynamic> updateMap = {};
    if (_idToItemMap.containsKey(iid)) {
      final item = _idToItemMap[iid]!.clone();
      if (read != null) {
        item.hasRead = read;
        if (!local) {
          if (read) {
            rssServiceHandler.markRead(item);
          } else {
            rssServiceHandler.markUnread(item);
          }
        }
        updateUnreadCount(item.feedFid, read ? -1 : 1);
      }
      if (starred != null) {
        item.starred = starred;
        if (!local) {
          if (starred) {
            rssServiceHandler.star(item);
          } else {
            rssServiceHandler.unstar(item);
          }
        }
      }
      _idToItemMap[iid] = item;
    }
    if (read != null) updateMap["hasRead"] = read ? 1 : 0;
    if (starred != null) updateMap["starred"] = starred ? 1 : 0;
    if (batch != null) {
      batch.update(CreateTableSql.rssItems.tableName, updateMap,
          where: "iid = ?", whereArgs: [iid]);
    } else {
      await ProviderManager.db.update(
          CreateTableSql.rssItems.tableName, updateMap,
          where: "iid = ?", whereArgs: [iid]);
    }
  }

  ///
  /// 全部标为已读
  ///
  Future<void> markAllRead(
    Set<String> sids, {
    required DateTime date,
    before = true,
  }) async {
    rssServiceHandler.markAllRead(sids, date, before);
    List<String> predicates = ["hasRead = 0"];
    if (sids.isNotEmpty) {
      predicates
          .add("feedFid IN (${List.filled(sids.length, "?").join(" , ")})");
    }
    predicates
        .add("date ${before ? "<=" : ">="} ${date.millisecondsSinceEpoch}");
    await ProviderManager.db.update(
      CreateTableSql.rssItems.tableName,
      {"hasRead": 1},
      where: predicates.join(" AND "),
      whereArgs: sids.toList(),
    );
    for (var item in _idToItemMap.values.toList()) {
      if (sids.isNotEmpty && !sids.contains(item.feedFid)) continue;
      if ((before
          ? item.date.compareTo(date) > 0
          : item.date.compareTo(date) < 0)) continue;
      item.hasRead = true;
    }
    updateAllUnreadCount();
  }

  Future<void> fetchItems() async {
    final items = await rssServiceHandler.fetchItems();
    List<RssItem> batchedItems = [];
    for (var item in items) {
      if (!containsFeed(item.feedFid)) continue;
      _idToItemMap[item.iid] = item;
      batchedItems.add(item);
    }
    RssItemDao.insertAll(batchedItems);

    mergeFetchedItems(items);
    // ProviderManager.feedContentProvider.mergeFetchedItems(items);
  }

  Future<void> syncItems() async {
    final tuple = await rssServiceHandler.syncItems();
    final unreadIds = tuple.item1;
    final starredIds = tuple.item2;
    final rows = await ProviderManager.db.query(
      CreateTableSql.rssItems.tableName,
      columns: ["iid", "hasRead", "starred"],
      where: "hasRead = 0 OR starred = 1",
    );
    final batch = ProviderManager.db.batch();
    for (var row in rows) {
      final id = row["iid"];
      if (row["hasRead"] == 0 && !unreadIds.remove(id)) {
        await updateItem(id as String, read: true, batch: batch, local: true);
      }
      if (row["starred"] == 1 && !starredIds.remove(id)) {
        await updateItem(id as String,
            starred: false, batch: batch, local: true);
      }
    }
    for (var unread in unreadIds) {
      await updateItem(unread, read: false, batch: batch, local: true);
    }
    for (var starred in starredIds) {
      await updateItem(starred, starred: true, batch: batch, local: true);
    }

    await batch.commit(noResult: true);
    updateAllUnreadCount();
  }
}
