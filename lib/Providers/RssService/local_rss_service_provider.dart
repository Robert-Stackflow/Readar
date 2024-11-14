import 'dart:async';

import 'package:readar/Models/feed.dart';

import '../../Database/Dao/feed_dao.dart';
import '../Feed/feed_provider.dart';
import 'base_rss_service_provider.dart';

class LocalRssServiceAdapter extends BaseRssServiceProvider {
  LocalRssServiceAdapter(super.serviceModel) {
    init();
  }

  @override
  init() async {
    await _refreshFeeds();
    fetchFavicon();
  }

  _refreshFeeds() async {
    feedProviders = [];
    feedProviders.addAll((await FeedDao.instance.queryByServiceUid(serviceUid))
        .map((e) => FeedProvider(e))
        .toList());
    notifyListeners();
  }

  @override
  Future addFeed(FeedModel feed) async {
    feed.serviceUid = service.uid;
    feed.id = null;
    await FeedDao.instance.insert(feed);
    _refreshFeeds();
  }

  @override
  Future addFeeds(List<FeedModel> feeds) async {
    for (FeedModel feed in feeds) {
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
  Future deleteFeed(FeedModel feed) async {
    var res = await FeedDao.instance.delete(feed);
    _refreshFeeds();
    return res;
  }

  @override
  Future deleteFeeds(List<FeedModel> feeds) async {
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
  Future updateFeed(FeedModel feed) async {
    var res = await FeedDao.instance.update(feed);
    return res;
  }

  @override
  Future updateFeeds(List<FeedModel> feeds) async {
    var res = await FeedDao.instance.updateAll(feeds);
    for (FeedModel feed in feeds) {
      var feedProvider = feedProviders
          .firstWhere((element) => element.feedModel.uid == feed.uid);
      feedProvider.update(feed);
    }
    return res;
  }
}
