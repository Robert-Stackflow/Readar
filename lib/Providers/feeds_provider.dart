import 'package:cloudreader/Database/Dao/feed_dao.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../Models/feed.dart';
import '../Models/rss_item.dart';
import '../Utils/utils.dart';
import 'provider_manager.dart';

class FeedsProvider with ChangeNotifier {
  final Map<String, Feed> _feeds = {};
  final Map<String, Feed> _deleted = {};

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

  bool containsFeed(String id) => _feeds.containsKey(id);

  Feed getFeed(String id) => _feeds[id] ?? _deleted[id]!;

  Iterable<Feed> getFeeds() => _feeds.values;

  Future<void> init() async {
    FeedDao.queryByServiceId(serviceId)
        .then((value) => {for (Feed feed in value) _feeds[feed.sid] = feed});
    notifyListeners();
    await updateUnreadCounts();
  }

  Future<void> updateUnreadCounts() async {
    final rows = await ProviderManager.db.rawQuery(
        "SELECT source, COUNT(iid) FROM items WHERE hasRead=0 GROUP BY source;");
    for (var source in _feeds.values) {
      var cloned = source.clone();
      _feeds[source.sid] = cloned;
      // cloned.unreadCount = 0;
    }
    for (var row in rows) {
      // _sources[row["source"]]!.unreadCount = row["COUNT(iid)"] as int?;
    }
    notifyListeners();
  }

  void updateUnreadCount(String sid, int diff) {
    // _sources[sid]!.unreadCount = _sources[sid]!.unreadCount! + diff;
    notifyListeners();
  }

  Future<void> updateWithFetchedItems(Iterable<RSSItem> items) async {
    Set<String> changed = {};
    for (var item in items) {
      var source = _feeds[item.feedSid]!;
      // if (!item.hasRead) source.unreadCount = source.unreadCount! + 1;
      if (item.date.compareTo(source.latestArticleTime!) > 0 ||
          source.latestArticleTitle!.isEmpty) {
        source.latestArticleTime = item.date;
        source.latestArticleTitle = item.title;
        changed.add(source.sid);
      }
    }
    notifyListeners();
    if (changed.isNotEmpty) {
      var batch = ProviderManager.db.batch();
      for (var sid in changed) {
        var source = _feeds[sid]!;
        batch.update(
          "sources",
          {
            "latest": source.latestArticleTime!.millisecondsSinceEpoch,
            "lastTitle": source.latestArticleTitle!,
          },
          where: "sid = ?",
          whereArgs: [source.sid],
        );
      }
      await batch.commit();
    }
  }

  Future<void> put(Feed source, {force = false}) async {
    if (_deleted.containsKey(source.sid) && !force) return;
    _feeds[source.sid] = source;
    notifyListeners();
    await ProviderManager.db.insert(
      "sources",
      source.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> putAll(Iterable<Feed> sources, {force = false}) async {
    Batch batch = ProviderManager.db.batch();
    for (var source in sources) {
      if (_deleted.containsKey(source.sid) && !force) continue;
      _feeds[source.sid] = source;
      batch.insert(
        "sources",
        source.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    notifyListeners();
    await batch.commit(noResult: true);
  }

  Future<void> updateSources() async {
    if (ProviderManager.serviceHandler == null) return;
    final tuple = await ProviderManager.serviceHandler!.fetchFeeds();
    final sources = tuple.item1;
    var curr = Set<String>.from(_feeds.keys);
    List<Feed> newSources = [];
    for (var source in sources) {
      if (curr.contains(source.sid)) {
        curr.remove(source.sid);
      } else {
        newSources.add(source);
      }
    }
    await putAll(newSources, force: true);
    await removeSources(curr);
    ProviderManager.groupsProvider.groups = tuple.item2;
    fetchFavicons();
  }

  Future<void> removeSources(Iterable<String> ids) async {
    final batch = ProviderManager.db.batch();
    for (var id in ids) {
      if (!_feeds.containsKey(id)) continue;
      var source = _feeds[id];
      batch.delete(
        "items",
        where: "source = ?",
        whereArgs: [id],
      );
      batch.delete(
        "sources",
        where: "sid = ?",
        whereArgs: [id],
      );
      _feeds.remove(id);
      _deleted[id] = source!;
    }
    await batch.commit(noResult: true);
    ProviderManager.feedContentProvider.initAll();
    notifyListeners();
  }

  Future<void> fetchFavicons() async {
    for (var key in _feeds.keys) {
      if (_feeds[key]?.iconUrl == null) {
        _fetchFavicon(_feeds[key]!.url).then((url) {
          if (!_feeds.containsKey(key)) return;
          var source = _feeds[key]!.clone();
          source.iconUrl = url;
          put(source);
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
