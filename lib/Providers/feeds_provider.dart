import 'package:cloudreader/Database/Dao/feed_dao.dart';
import 'package:cloudreader/Database/create_table_sql.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../Models/feed.dart';
import '../Models/rss_item.dart';
import '../Utils/utils.dart';
import 'provider_manager.dart';

class FeedsProvider with ChangeNotifier {
  final Map<String, Feed> _fidToFeedMap = {};
  final Map<String, Feed> _deletedSidToFeedMap = {};

  bool _showUnreadTip = true;

  bool get showUnreadTip => _showUnreadTip;

  set showUnreadTip(bool value) {
    if (_showUnreadTip != value) {
      _showUnreadTip = value;
    }
  }

  int _serviceId = 0;

  int get serviceId => _serviceId;

  set serviceId(int value) {
    if (value != _serviceId) {
      _serviceId = value;
      notifyListeners();
    }
  }

  bool containsFeed(String id) => _fidToFeedMap.containsKey(id);

  Feed getFeed(String id) => _fidToFeedMap[id] ?? _deletedSidToFeedMap[id]!;

  Iterable<Feed> getFeeds() => _fidToFeedMap.values;

  Future<void> init() async {
    FeedDao.queryByServiceId(serviceId).then(
        (value) => {for (Feed feed in value) _fidToFeedMap[feed.fid] = feed});
    notifyListeners();
    // await updateUnreadCounts();
  }

  Future<void> updateUnreadCounts() async {
    final rows = await ProviderManager.db.rawQuery(
        "SELECT source, COUNT(iid) FROM items WHERE hasRead=0 GROUP BY source;");
    for (var feed in _fidToFeedMap.values) {
      var cloned = feed.clone();
      _fidToFeedMap[feed.fid] = cloned;
      // cloned.unreadCount = 0;
    }
    for (var row in rows) {
      // _sources[row["source"]]!.unreadCount = row["COUNT(iid)"] as int?;
    }
    notifyListeners();
  }

  void updateUnreadCount(String fid, int diff) {
    // _sources[fid]!.unreadCount = _sources[fid]!.unreadCount! + diff;
    notifyListeners();
  }

  ///
  /// 合并拉取的条目
  ///
  Future<void> mergeFetchedItems(Iterable<RSSItem> items) async {
    Set<String> changed = {};
    for (var item in items) {
      var feed = _fidToFeedMap[item.feedFid]!;
      // if (!item.hasRead) feed.unreadCount = feed.unreadCount! + 1;
      if (item.date.compareTo(feed.latestArticleTime!) > 0 ||
          feed.latestArticleTitle!.isEmpty) {
        feed.latestArticleTime = item.date;
        feed.latestArticleTitle = item.title;
        changed.add(feed.fid);
      }
    }
    notifyListeners();
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
  Future<void> insert(Feed feed, {force = false}) async {
    if (_deletedSidToFeedMap.containsKey(feed.fid) && !force) return;
    _fidToFeedMap[feed.fid] = feed;
    notifyListeners();
    await FeedDao.insert(feed);
  }

  ///
  /// 添加一系列订阅源
  ///
  /// [feeds] 待添加订阅源列表
  ///
  /// [force] 是否强制添加
  ///
  Future<void> insertAll(Iterable<Feed> feeds, {force = false}) async {
    List<Feed> batchedFeeds = [];
    for (var feed in feeds) {
      if (_deletedSidToFeedMap.containsKey(feed.fid) && !force) continue;
      _fidToFeedMap[feed.fid] = feed;
      feed.serviceId = serviceId;
      batchedFeeds.add(feed);
    }
    notifyListeners();
    await FeedDao.insertAll(batchedFeeds);
  }

  Future<void> syncFeeds() async {
    if (ProviderManager.serviceHandler == null) return;
    final feedsAndGroupsTuple =
        await ProviderManager.serviceHandler!.fetchFeedsAndGroups();
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
    await insertAll(newFeeds, force: true);
    await removeFeeds(oldSids);
    ProviderManager.groupsProvider.groups = feedsAndGroupsTuple.item2;
    fetchFavicons();
  }

  Future<void> removeFeeds(Iterable<String> fids) async {
    final batch = ProviderManager.db.batch();
    for (var fid in fids) {
      if (!_fidToFeedMap.containsKey(fid)) continue;
      var feed = _fidToFeedMap[fid];
      batch.delete(
        CreateTableSql.items.tableName,
        where: "feedFid = ?",
        whereArgs: [fid],
      );
      batch.delete(
        CreateTableSql.feed.tableName,
        where: "fid = ?",
        whereArgs: [fid],
      );
      _fidToFeedMap.remove(fid);
      _deletedSidToFeedMap[fid] = feed!;
    }
    await batch.commit(noResult: true);
    ProviderManager.feedContentProvider.initAll();
    notifyListeners();
  }

  Future<void> fetchFavicons() async {
    for (var fid in _fidToFeedMap.keys) {
      if (_fidToFeedMap[fid]?.iconUrl == null) {
        _fetchFavicon(_fidToFeedMap[fid]!.url).then((url) {
          if (!_fidToFeedMap.containsKey(fid)) return;
          var feed = _fidToFeedMap[fid]!.clone();
          feed.iconUrl = url;
          insert(feed);
        });
      }
    }
  }

  Future<String?> _fetchFavicon(String url) async {
    try {
      url = url.split("/").getRange(0, 3).join("/");
      var uri = Uri.parse(url);
      var result = await http.get(uri);
      if (result.statusCode == 200) {
        var htmlStr = result.body;
        var dom = parse(htmlStr);
        var links = dom.getElementsByTagName("link");
        for (var link in links) {
          var rel = link.attributes["rel"];
          if ((rel == "icon" || rel == "shortcut icon") &&
              link.attributes.containsKey("href")) {
            var href = link.attributes["href"]!;
            var parsedUrl = Uri.parse(url);
            if (href.startsWith("//")) {
              return "${parsedUrl.scheme}:$href";
            } else if (href.startsWith("/")) {
              return url + href;
            } else {
              return href;
            }
          }
        }
      }
      url = "$url/favicon.ico";
      if (await Utils.validateFavicon(url)) {
        return url;
      } else {
        return null;
      }
    } catch (exp) {
      return null;
    }
  }
}
