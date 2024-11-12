import 'dart:async';

import 'package:readar/Adapters/RssService/base_rss_service_adapter.dart';
import 'package:readar/Database/Dao/rss_service_dao.dart';
import 'package:readar/Models/feed.dart';

import '../../Database/Dao/feed_dao.dart';
import '../../Models/rss_service.dart';

class LocalRssServiceAdapter extends BaseRssServiceAdapter {
  RssService? _service;

  @override
  RssService get service => _service!;

  LocalRssServiceAdapter._internal();

  static final LocalRssServiceAdapter _instance =
      LocalRssServiceAdapter._internal();

  static LocalRssServiceAdapter get instance {
    if (_instance._service == null) {
      _instance.init();
    }
    return _instance;
  }

  @override
  init() async {
    _service = await RssServiceDao.instance.getLocalRssService();
  }

  @override
  Future addFeed(Feed feed) async {
    feed.serviceUid = service.id;
    feed.id = 0;
    await FeedDao.instance.insert(feed);
  }

  @override
  FutureOr addFeeds(List<Feed> feeds) {
    for (Feed feed in feeds) {
      feed.serviceUid = service.id;
      feed.id = 0;
    }
    return FeedDao.instance.insertAll(feeds);
  }

  @override
  FutureOr deleteAllFeeds() {
    return FeedDao.instance.deleteAll();
  }

  @override
  FutureOr deleteFeed(Feed feed) {
    return FeedDao.instance.delete(feed);
  }

  @override
  FutureOr deleteFeeds(List<Feed> feeds) {
    return FeedDao.instance.deleteFeeds(feeds.map((e) => e.uid).toList());
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
    return FeedDao.instance.queryByFid(fid);
  }

  @override
  FutureOr updateFeed(Feed feed) {
    return FeedDao.instance.update(feed);
  }

  @override
  FutureOr updateFeeds(List<Feed> feeds) {
    return FeedDao.instance.updateAll(feeds);
  }
}
