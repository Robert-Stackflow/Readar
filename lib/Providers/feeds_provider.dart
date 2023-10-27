import 'package:cloudreader/Utils/iprint.dart';
import 'package:flutter/cupertino.dart';

import '../Models/feed_content.dart';
import '../Models/rss_item.dart';
import '../Utils/utils.dart';
import 'global.dart';

enum ItemSwipeOption {
  toggleRead,
  toggleStar,
  share,
  openMenu,
  openExternal,
}

class FeedsProvider with ChangeNotifier {
  FeedContent all = FeedContent(sids: {});
  FeedContent source = FeedContent(sids: {});

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
    source = FeedContent(sids: sidSet);
    await source.init();
  }

  void addFetchedItems(Iterable<RSSItem> items) {
    for (var feed in [all, source]) {
      var lastDate = feed.iids.isNotEmpty
          ? Global.itemsProvider.getItem(feed.iids.last).date
          : null;
      for (var item in items) {
        IPrint.debug(item.title);
        if (!feed.testItem(item)) continue;
        if (lastDate != null && item.date.isBefore(lastDate)) continue;
        var idx = Utils.binarySearch(feed.iids, item.id, (a, b) {
          return Global.itemsProvider
              .getItem(b)
              .date
              .compareTo(Global.itemsProvider.getItem(a).date);
        });
        feed.iids.insert(idx, item.id);
      }
    }
    notifyListeners();
  }

  void initAll() {
    for (var feed in [all, source]) {
      feed.init();
    }
  }
}
