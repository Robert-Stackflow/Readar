// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:math';

import 'package:cloudreader/Database/create_table_sql.dart';
import 'package:cloudreader/Database/feed_dao.dart';
import 'package:cloudreader/Database/rss_service_dao.dart';
import 'package:cloudreader/Models/rss_service.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../../Handler/rss_service_handler.dart';
import '../../Models/feed.dart';
import '../../Models/rss_item.dart';
import '../../Providers/provider_manager.dart';
import '../../Utils/iprint.dart';

class GoogleReaderRssServiceHandler extends RssServiceHandler {
  static const _tagAll = "user/-/state/com.google/reading-list";
  static const _tagHasRead = "user/-/state/com.google/read";
  static const _tagStarred = "user/-/state/com.google/starred";
  static final _authRegex = RegExp(r"Auth=(\S+)");

  RssService feedService;

  GoogleReaderRssServiceHandler(this.feedService);

  @override
  void removeService() {
    RssServiceDao.delete(feedService);
  }

  @override
  Future<http.Response> fetchResponse(String path, {dynamic body}) async {
    final headers = <String, String>{};
    if (feedService.authorization != null) {
      headers["Authorization"] = feedService.authorization!;
    }
    if (feedService.appId != null && feedService.appKey != null) {
      headers["AppId"] = feedService.appId!;
      headers["AppKey"] = feedService.appKey!;
    }
    var uri = Uri.parse(feedService.endpoint + path);
    if (body == null) {
      return await http.get(uri, headers: headers);
    } else {
      headers["Content-Type"] = "application/x-www-form-urlencoded";
      return await http.post(uri, headers: headers, body: body);
    }
  }

  @override
  Future<bool> validate() async {
    try {
      final result = await fetchResponse("/reader/api/0/user-info");
      return result.statusCode == 200;
    } catch (exp) {
      return false;
    }
  }

  @override
  Future<bool> authenticate() async {
    if (!await validate()) {
      final body = {
        "Email": feedService.username,
        "Passwd": feedService.password,
      };
      final result = await fetchResponse("/accounts/ClientLogin", body: body);
      if (result.statusCode != 200) {
        return false;
      } else {
        final match = _authRegex.firstMatch(result.body);
        if (match != null && match.groupCount > 0) {
          feedService.authorization = "GoogleLogin auth=${match.group(1)}";
          return true;
        } else {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Future<Tuple2<List<Feed>, Map<String, List<String>>>>
      fetchFeedsAndGroups() async {
    final response =
        await fetchResponse("/reader/api/0/subscription/list?output=json");
    if (response.statusCode != 200) {
      return const Tuple2([], {});
    }
    var rawFeeds = jsonDecode(response.body)["subscriptions"];
    final groupsMap = <String, List<String>>{};
    for (var s in rawFeeds) {
      final categories = s["categories"];
      if (categories != null) {
        for (var c in categories) {
          groupsMap.putIfAbsent(c["label"], () => []);
          groupsMap[c["label"]]!.add(s["id"]);
        }
      }
    }
    final sources = rawFeeds.map<Feed>((s) {
      return Feed(s["id"], s["url"] ?? s["htmlUrl"], s["title"],
          serviceId: feedService.id!);
    }).toList();
    return Tuple2(sources, groupsMap);
  }

  @override
  Future<List<RssItem>> fetchItems() async {
    List rawItems = [];
    List fetchedItems;
    String? continuation;
    do {
      try {
        //构造请求串
        final limit = min(feedService.fetchLimit - rawItems.length, 1000);
        var params = "/reader/api/0/stream/contents?output=json&n=$limit";
        if (feedService.latestFetchedTime != null) {
          params += "&ot=${feedService.latestFetchedTime}";
        }
        if (continuation != null) params += "&c=$continuation";
        final response = await fetchResponse(params);
        if (response.statusCode != 200) {
          break;
        }
        //如果不超过fetchLimit则添加到items
        final responseBody = jsonDecode(response.body);
        fetchedItems = responseBody["items"];
        for (var i in fetchedItems) {
          i["id"] = _compactId(i["id"]);
          if (i["id"] == feedService.lastedFetchedId ||
              rawItems.length >= feedService.fetchLimit) {
            break;
          } else {
            rawItems.add(i);
          }
        }
        // continuation = responseBody["continuation"];
        continuation = "";
      } catch (exp) {
        IPrint.debug(exp);
        break;
      }
    } while (continuation != null && rawItems.length < feedService.fetchLimit);
    //更新最新拉取信息
    if (rawItems.isNotEmpty) {
      feedService.lastedFetchedId = rawItems[0]["id"];
      feedService.latestFetchedTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(rawItems[0]["crawlTimeMsec"]));
    }
    //解析到RSSItem对象
    List<RssItem> parsedItems = [];
    for (var i in rawItems) {
      final dom = parse(i["summary"]["content"]);
      if (feedService.params != null &&
          feedService.params!['removeInoreaderAd'] != null &&
          feedService.params!['removeInoreaderAd'] is bool &&
          feedService.params!['removeInoreaderAd'] as bool) {
        if (dom.documentElement!.text.trim().startsWith("Ads from Inoreader")) {
          dom.body!.firstChild!.remove();
        }
      }
      final item = RssItem(
        iid: i["id"],
        feedFid: i["origin"]["streamId"],
        title: i["title"],
        url: i["canonical"][0]["href"],
        date: DateTime.fromMillisecondsSinceEpoch(i["published"] * 1000),
        content: dom.body!.innerHtml,
        snippet: dom.documentElement!.text.trim(),
        creator: i["author"],
        hasRead: false,
        starred: false,
        feedId: await FeedDao.getIdByFid(i["origin"]["streamId"]),
      );
      if (feedService.appId != null) {
        item.title = parse(item.title).documentElement!.text;
      }
      var img = dom.querySelector("img");
      if (img != null && img.attributes["src"] != null) {
        var thumb = img.attributes["src"];
        if (thumb!.startsWith("http")) {
          item.thumb = thumb;
        }
      }
      for (var c in i["categories"]) {
        if (!item.hasRead && c.endsWith("/state/com.google/read")) {
          item.hasRead = true;
        } else if (!item.starred && c.endsWith("/state/com.google/starred")) {
          item.starred = true;
        }
      }
      parsedItems.add(item);
    }
    return parsedItems;
  }

  @override
  Future<Tuple2<Set<String>, Set<String>>> syncItems() async {
    List<Set<String>> results;
    if (feedService.appId != null) {
      results = await Future.wait([
        _fetchAll(
            "/reader/api/0/stream/items/ids?output=json&xt=$_tagHasRead&n=1000"),
        _fetchAll(
            "/reader/api/0/stream/items/ids?output=json&it=$_tagStarred&n=1000"),
      ]);
    } else {
      results = await Future.wait([
        _fetchAll(
            "/reader/api/0/stream/items/ids?output=json&s=$_tagAll&xt=$_tagHasRead&n=1000"),
        _fetchAll(
            "/reader/api/0/stream/items/ids?output=json&s=$_tagStarred&n=1000"),
      ]);
    }
    return Tuple2.fromList(results);
  }

  @override
  Future<void> markAllRead(
      Set<String> sids, DateTime? date, bool before) async {
    if (date != null) {
      List<String> predicates = ["hasRead = 0"];
      if (sids.isNotEmpty) {
        predicates
            .add("source IN (${List.filled(sids.length, "?").join(" , ")})");
      }
      predicates
          .add("date ${before ? "<=" : ">="} ${date.millisecondsSinceEpoch}");
      final rows = await ProviderManager.db.query(
        CreateTableSql.rssItems.tableName,
        columns: ["iid"],
        where: predicates.join(" AND "),
        whereArgs: sids.toList(),
      );
      final iids = rows.map((r) => r["iid"]).iterator;
      List<String> refs = [];
      while (iids.moveNext()) {
        refs.add(iids.current as String);
        if (refs.length >= 1000) {
          _editTag(refs.join("&i="), _tagHasRead);
          refs = [];
        }
      }
      if (refs.isNotEmpty) _editTag(refs.join("&i="), _tagHasRead);
    } else {
      if (sids.isEmpty) {
        sids = Set.from(ProviderManager.rssProvider.currentRssServiceManager
            .getFeeds()
            .map((s) => s.fid));
      }
      for (var sid in sids) {
        final body = {"s": sid};
        fetchResponse("/reader/api/0/mark-all-as-read", body: body);
      }
    }
  }

  @override
  Future<void> markRead(RssItem item) async {
    await _editTag(item.iid, _tagHasRead);
  }

  @override
  Future<void> markUnread(RssItem item) async {
    await _editTag(item.iid, _tagHasRead, add: false);
  }

  @override
  Future<void> star(RssItem item) async {
    await _editTag(item.iid, _tagStarred);
  }

  @override
  Future<void> unstar(RssItem item) async {
    await _editTag(item.iid, _tagStarred, add: false);
  }

  Future<Set<String>> _fetchAll(String params) async {
    final results = List<String>.empty(growable: true);
    List fetched;
    String? continuation;
    do {
      var p = params;
      p += "&c=$continuation";
      final response = await fetchResponse(p);
      assert(response.statusCode == 200);
      final parsed = jsonDecode(response.body);
      fetched = parsed["itemRefs"];
      if (fetched.isNotEmpty) {
        for (var i in fetched) {
          results.add(i["id"]);
        }
      }
      continuation = parsed["continuation"];
    } while (continuation != null && fetched.length >= 1000);
    return Set.from(results);
  }

  Future<http.Response> _editTag(String ref, String tag, {add = true}) async {
    final body = "i=$ref&${add ? "a" : "r"}=$tag";
    return await fetchResponse("/reader/api/0/edit-tag", body: body);
  }

  String _compactId(String longId) {
    final last = longId.split("/").last;
    if (feedService.params == null ||
        feedService.params!['useInt64'] == null ||
        feedService.params!['useInt64'] is! bool ||
        !(feedService.params!['useInt64'] as bool)) return last;
    return int.parse(last, radix: 16).toString();
  }
}
