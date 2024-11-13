import 'dart:async';

import 'package:readar/Adapters/RssService/base_rss_service_adapter.dart';
import 'package:readar/Database/Dao/rss_service_dao.dart';
import 'package:readar/Models/feed.dart';

import '../../Database/Dao/feed_dao.dart';
import '../../Models/rss_service.dart';

class LocalRssServiceAdapter extends BaseRssServiceAdapter {
  LocalRssServiceAdapter._internal();

  static final LocalRssServiceAdapter _instance =
      LocalRssServiceAdapter._internal();

  static LocalRssServiceAdapter get instance {
    if (_instance._service == null) {
      _instance.init();
    }
    return _instance;
  }

  RssService? _service;

  @override
  RssService get service => _service!;

  @override
  init() async {
    _service = await RssServiceDao.instance.getLocalRssService();
    await _refreshFeeds();
    fetchFavicon();
  }

  _refreshFeeds() async {
    feeds = [];
    feeds.addAll(await FeedDao.instance.queryByServiceUid(_service!.uid));
    notifyListeners();
  }

  @override
  Future addFeed(Feed feed) async {
    feed.serviceUid = service.uid;
    feed.id = null;
    await FeedDao.instance.insert(feed);
    _refreshFeeds();
  }

  @override
  Future addFeeds(List<Feed> feeds) async {
    for (Feed feed in feeds) {
      feed.serviceUid = service.uid;
      feed.id = null;
    }
    var res = await FeedDao.instance.insertAll(feeds);
    _refreshFeeds();
    return res;
  }

  @override
  Future deleteAllFeeds() async {
    var res = await FeedDao.instance.deleteAll();
    _refreshFeeds();
    return res;
  }

  @override
  Future deleteFeed(Feed feed) async {
    var res = await FeedDao.instance.delete(feed);
    _refreshFeeds();
    return res;
  }

  @override
  Future deleteFeeds(List<Feed> feeds) async {
    var res =
        await FeedDao.instance.deleteFeeds(feeds.map((e) => e.uid).toList());
    _refreshFeeds();
    return res;
  }

  @override
  FutureOr queryAllFeeds() {
    return FeedDao.instance.queryAll();
  }

  @override
  FutureOr queryFeedById(int id) {
    return FeedDao.instance.queryById(id);
  }

  @override
  FutureOr queryFeedByFId(String fid) {
    return FeedDao.instance.queryByUid(fid);
  }

  @override
  Future updateFeed(Feed feed) async {
    var res = await FeedDao.instance.update(feed);
    _refreshFeeds();
    return res;
  }

  @override
  Future updateFeeds(List<Feed> feeds) async {
    var res = await FeedDao.instance.updateAll(feeds);
    _refreshFeeds();
    return res;
  }
}
