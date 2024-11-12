import 'dart:async';

import 'package:readar/Models/rss_service.dart';

import '../../Models/feed.dart';

abstract class BaseRssServiceAdapter {
  RssService get service;

  String get serviceId => service.uid;

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
