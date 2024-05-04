import 'package:afar/Database/rss_item_dao.dart';
import 'package:afar/Models/rss_item.dart';
import 'package:tuple/tuple.dart';

import '../Providers/provider_manager.dart';

///
/// 过滤类型：全部、未读、已读、已标星标、未标星标、已保存
///
enum FilterType { all, unread, read, starred, unstarred, saved }

/// 一次加载文章条数
const loadLimit = 50;

///
/// 文章列表类，当加载某个订阅源时使用
///
class RssItemList {
  /// 是否已经初始化
  bool initialized = false;

  /// 是否正在加载数据
  bool loading = false;

  /// 是否已经加载完毕
  bool allLoaded = false;

  /// 需要加载的订阅源Fid列表
  Set<String> fids;

  /// 文章条目列表
  List<String> iids = [];

  /// 过滤类型
  FilterType filterType;

  /// 查询关键字
  String query = "";

  RssItemList({
    required this.fids,
    this.filterType = FilterType.all,
  }) {
    //TODO 修改为存储类型
    filterType = FilterType.values[0];
  }

  ///
  /// 初始化列表
  ///
  Future<void> init() async {
    if (loading) return;
    loading = true;
    var conditions = _getConditions();
    var items = (await RssItemDao.query(
        loadLimit: loadLimit,
        where: conditions.item1,
        whereArgs: conditions.item2));
    allLoaded = items.length < loadLimit;
    ProviderManager.rssProvider.currentRssServiceManager.mappingItems(items);
    iids = items.map((i) => i.iid).toList();
    loading = false;
    initialized = true;
  }

  ///
  /// 加载更多条目
  ///
  Future<void> loadMore() async {
    if (loading || allLoaded) return;
    loading = true;
    var conditions = _getConditions();
    var offset = iids
        .map((iid) =>
            ProviderManager.rssProvider.currentRssServiceManager.getItem(iid))
        .fold(0, (c, i) => c + (testItem(i) ? 1 : 0));
    var items = (await RssItemDao.query(
        loadLimit: loadLimit,
        where: conditions.item1,
        offset: offset,
        whereArgs: conditions.item2));
    if (items.length < loadLimit) {
      allLoaded = true;
    }
    ProviderManager.rssProvider.currentRssServiceManager.mappingItems(items);
    iids.addAll(items.map((i) => i.iid));
    loading = false;
  }

  ///
  /// 获取查询条件
  ///
  Tuple2<String, List<String>> _getConditions() {
    List<String> where = ["1 = 1"];
    List<String> whereArgs = [];
    if (fids.isNotEmpty) {
      var placeholders = List.filled(fids.length, "?").join(" , ");
      where.add("feedFid IN ($placeholders)");
      whereArgs.addAll(fids);
    }
    if (filterType == FilterType.unread) {
      where.add("hasRead = 0");
    } else if (filterType == FilterType.starred) {
      where.add("starred = 1");
    }
    if (query != "") {
      where.add("(UPPER(title) LIKE ? OR UPPER(snippet) LIKE ?)");
      var keyword = "%$query%".toUpperCase();
      whereArgs.add(keyword);
      whereArgs.add(keyword);
    }
    return Tuple2(where.join(" AND "), whereArgs);
  }

  ///
  /// 测试某个文章条目是否符合过滤要求
  ///
  bool testItem(RssItem item) {
    if (fids.isNotEmpty && !fids.contains(item.feedFid)) return false;
    if (filterType == FilterType.unread && item.hasRead) return false;
    if (filterType == FilterType.starred && !item.starred) return false;
    if (query != "") {
      var keyword = query.toUpperCase();
      if (item.title.toUpperCase().contains(keyword)) return true;
      if (item.snippet.toUpperCase().contains(keyword)) return true;
      return false;
    }
    return true;
  }

  ///
  /// 设置过滤条件
  ///
  Future<void> setFilter(FilterType filter) async {
    if (filterType == filter && filter == FilterType.all) return;
    filterType = filter;
    await init();
  }

  ///
  /// 设置搜索关键词
  ///
  Future<void> performSearch(String keyword) async {
    if (query == keyword) return;
    query = keyword;
    await init();
  }
}
