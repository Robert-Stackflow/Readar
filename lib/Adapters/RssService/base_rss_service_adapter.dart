import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:readar/Models/rss_service.dart';

import '../../Models/feed.dart';
import '../../Utils/utils.dart';

abstract class BaseRssServiceAdapter with ChangeNotifier {
  RssService get service;

  String get serviceId => service.uid;

  List<Feed> _feeds = [];

  List<Feed> get feeds => _feeds;

  set feeds(List<Feed> value) {
    _feeds = value;
    notifyListeners();
  }

  String _selectedFeedUid = "";

  String get selectedFeedUid => _selectedFeedUid;

  set selectedFeedUid(String value) {
    _selectedFeedUid = value;
    notifyListeners();
  }

  fetchFavicon([bool forceFetch = true]) async {
    for (Feed feed in feeds) {
      if (forceFetch || Utils.isEmpty(feed.iconUrl)) {
        compute(Utils.fetchFavicon, feed.url).then((value) {
          feed.iconUrl = value;
          updateFeed(feed);
        });
      }
    }
  }

  FutureOr init();

  FutureOr addFeed(Feed feed);

  FutureOr addFeeds(List<Feed> feeds);

  FutureOr deleteFeed(Feed feed);

  FutureOr deleteFeeds(List<Feed> feeds);

  FutureOr updateFeed(Feed feed);

  FutureOr updateFeeds(List<Feed> feeds);

  FutureOr queryFeedById(int id);

  FutureOr queryFeedByFId(String fid);

  FutureOr queryAllFeeds();

  FutureOr deleteAllFeeds();
}
