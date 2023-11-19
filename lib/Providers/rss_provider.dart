import 'package:flutter/cupertino.dart';

import '../Handler/rss_service_manager.dart';
import '../Models/rss_item_list.dart';
import '../Models/rss_service.dart';

enum ItemSwipeOption {
  toggleRead,
  toggleStar,
  share,
  openMenu,
  openExternal,
}

///
/// Rss状态管理
///
class RssProvider extends ChangeNotifier {
  /// 所有RSS服务对象
  late List<RssService> rssServices;

  /// 所有RSS服务管理对象
  late List<RssServiceManager> rssServiceManagers;

  /// 当前RSS服务管理对象
  late RssServiceManager currentRssServiceManager;

  /// 当前RSS文章列表
  RssItemList currentRssItemList = RssItemList(fids: {});

  set rssService(List<RssService> value) {
    if (value != rssServices) {
      rssServices = value;
      notifyListeners();
    }
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

  ///
  /// 加载指定订阅源的文章
  ///
  Future<void> loadRssItemListByFid(String fid) async {
    Set<String> sidSet = {fid};
    currentRssItemList = RssItemList(fids: sidSet);
    await currentRssItemList.init();
    notifyListeners();
  }

  ///
  /// 加载指定订阅源列表的文章
  ///
  Future<void> loadRssItemListByFids(Iterable<String> fids) async {
    Set<String> sidSet = Set.from(fids);
    currentRssItemList = RssItemList(fids: sidSet);
    await currentRssItemList.init();
    notifyListeners();
  }

  ///
  /// 根据Rss服务获取服务管理对象
  ///
  RssServiceManager getRssServiceManager(RssService? rssService) {
    if (rssService == null) return currentRssServiceManager;
    for (var manager in rssServiceManagers) {
      if (manager.rssService == rssService) {
        return manager;
      }
    }
    return currentRssServiceManager;
  }

  // void mergeFetchedItems(Iterable<RssItem> items) {
  //   for (var rssItemList in [currentRssItemList]) {
  //     var lastDate = rssItemList.iids.isNotEmpty
  //         ? currentRssServiceManager.getItem(rssItemList.iids.last).date
  //         : null;
  //     for (var item in items) {
  //       if (!rssItemList.testItem(item)) continue;
  //       if (lastDate != null && item.date.isBefore(lastDate)) continue;
  //       var idx = Utils.binarySearch(rssItemList.iids, item.iid, (a, b) {
  //         return currentRssServiceManager
  //             .getItem(b)
  //             .date
  //             .compareTo(currentRssServiceManager.getItem(a).date);
  //       });
  //       rssItemList.iids.insert(idx, item.iid);
  //     }
  //   }
  //   notifyListeners();
  // }

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
          currentRssServiceManager.getFeeds().map<String>((s) => s.fid));
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
