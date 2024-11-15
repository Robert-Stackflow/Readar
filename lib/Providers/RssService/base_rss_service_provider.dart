import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:readar/Models/rss_service.dart';
import 'package:readar/Providers/RssService/local_rss_service_provider.dart';

import '../../Models/feed.dart';
import '../../Utils/utils.dart';
import '../Feed/feed_provider.dart';

class BaseRssServiceProvider with ChangeNotifier {
  static BaseRssServiceProvider impl(RssServiceModel serviceModel) {
    switch (serviceModel.rssServiceType) {
      case RssServiceType.local:
        return LocalRssServiceAdapter(serviceModel);
      default:
        return BaseRssServiceProvider(serviceModel);
    }
  }

  BaseRssServiceProvider(this.serviceModel);

  final RssServiceModel serviceModel;

  RssServiceModel get service => serviceModel;

  String get serviceUid => service.uid;

  List<FeedProvider> _feedProviders = [];

  List<FeedProvider> get feedProviders => _feedProviders;

  set feedProviders(List<FeedProvider> value) {
    _feedProviders = value;
    notifyListeners();
  }

  FeedProvider? _selectedFeedProvider;

  FeedProvider? get selectedFeedProvider => _selectedFeedProvider;

  String? get selectedFeedProviderUid => _selectedFeedProvider?.feedModel.uid;

  set selectedFeedProvider(FeedProvider? value) {
    _selectedFeedProvider = value;
    notifyListeners();
  }

  fetchFavicon([bool forceFetch = true]) async {
    for (FeedProvider feedManager in feedProviders) {
      var feed = feedManager.feedModel;
      if (forceFetch || Utils.isEmpty(feed.iconUrl)) {
        compute(Utils.fetchFavicon, feed.url).then((value) {
          feed.iconUrl = value;
          updateFeed(feed);
        });
      }
    }
  }

  FutureOr init() {}

  FutureOr addFeed(FeedModel feed) {}

  FutureOr addFeeds(List<FeedModel> feeds) {}

  FutureOr deleteFeed(FeedModel feed) {}

  FutureOr deleteFeeds(List<FeedModel> feeds) {}

  FutureOr updateFeed(FeedModel feed) {}

  FutureOr updateFeeds(List<FeedModel> feeds) {}

  FutureOr queryFeedById(int id) {}

  FutureOr queryFeedByFId(String fid) {}

  FutureOr queryAllFeeds() {}

  FutureOr deleteAllFeeds() {}
}
