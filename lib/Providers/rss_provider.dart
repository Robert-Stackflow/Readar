import 'package:flutter/cupertino.dart';

import '../Handler/rss_handler.dart';
import '../Models/feed.dart';
import '../Models/rss_item.dart';
import '../Models/rss_item_list.dart';
import '../Models/rss_service.dart';
import '../Utils/utils.dart';

enum ItemSwipeOption {
  toggleRead,
  toggleStar,
  share,
  openMenu,
  openExternal,
}

class RssProvider extends ChangeNotifier {
  late List<RssHandler> rssHandlers;
  late List<RssService> rssServices;
  late RssHandler currentRssHandler;

  RssService? _currentFeedService;

  RssService? get currentFeedService => _currentFeedService;

  set currentFeedService(RssService? value) {
    if (value != _currentFeedService) {
      _currentFeedService = value;
      notifyListeners();
    }
  }

  Feed? _currentFeed;

  Feed? get currentFeed => _currentFeed;

  set currentFeed(Feed? value) {
    if (value != _currentFeed) {
      _currentFeed = value;
      notifyListeners();
    }
  }

  RssItemList all = RssItemList(sids: {});
  RssItemList source = RssItemList(sids: {});

  set rssService(List<RssService> value) {
    if (value != rssServices) {
      rssServices = value;
      notifyListeners();
    }
  }

  bool _showThumb = true;

  bool get showThumb => _showThumb;

  set showThumb(bool value) {
    _showThumb = value;
    notifyListeners();
  }

  bool _showSnippet = true;

  bool get showSnippet => _showSnippet;

  set showSnippet(bool value) {
    _showSnippet = value;
    notifyListeners();
  }

  bool _dimRead = false;

  bool get dimRead => _dimRead;

  set dimRead(bool value) {
    _dimRead = value;
    notifyListeners();
  }

  ItemSwipeOption _swipeR = ItemSwipeOption.values[0];

  ItemSwipeOption get swipeR => _swipeR;

  set swipeR(ItemSwipeOption value) {
    _swipeR = value;
    notifyListeners();
  }

  ItemSwipeOption _swipeL = ItemSwipeOption.values[1];

  ItemSwipeOption get swipeL => _swipeL;

  set swipeL(ItemSwipeOption value) {
    _swipeL = value;
    notifyListeners();
  }

  void broadcast() {
    notifyListeners();
  }

  Future<void> initSourcesFeed(Iterable<String> sids) async {
    Set<String> sidSet = Set.from(sids);
    source = RssItemList(sids: sidSet);
    await source.init();
  }

  void mergeFetchedItems(Iterable<RssItem> items) {
    for (var feed in [all, source]) {
      var lastDate = feed.iids.isNotEmpty
          ? currentRssHandler.getItem(feed.iids.last).date
          : null;
      for (var item in items) {
        if (!feed.testItem(item)) continue;
        if (lastDate != null && item.date.isBefore(lastDate)) continue;
        var idx = Utils.binarySearch(feed.iids, item.iid, (a, b) {
          return currentRssHandler
              .getItem(b)
              .date
              .compareTo(currentRssHandler.getItem(a).date);
        });
        feed.iids.insert(idx, item.iid);
      }
    }
    notifyListeners();
  }

  void initAll() {
    for (var feed in [all, source]) {
      feed.init();
    }
  }

  ///
  ///
  ///
  /// 此处为Group代码
  ///
  ///
  ///
  ///

  Map<String, List<String>> _groups = {};
  List<String>? uncategorized = [];

  Map<String, List<String>> get groups => _groups;

  set groups(Map<String, List<String>> groups) {
    _groups = groups;
    updateUncategorized();
    notifyListeners();
  }

  void updateUncategorized({force = false}) {
    if (uncategorized != null || force) {
      final sids = Set<String>.from(
          currentRssHandler.getFeeds().map<String>((s) => s.fid));
      for (var group in _groups.values) {
        for (var sid in group) {
          sids.remove(sid);
        }
      }
      uncategorized = sids.toList();
    }
  }

  bool get showUncategorized => uncategorized != null;

  set showUncategorized(bool value) {
    if (showUncategorized != value) {
      if (value) {
        updateUncategorized(force: true);
      } else {
        uncategorized = null;
      }
      notifyListeners();
    }
  }
}
