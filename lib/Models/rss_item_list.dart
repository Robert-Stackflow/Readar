import 'package:cloudreader/Database/create_table_sql.dart';
import 'package:cloudreader/Models/rss_item.dart';
import 'package:tuple/tuple.dart';

import '../Providers/provider_manager.dart';

///
/// 过滤类型：全部、未读、已读、已标星标、未标星标、已保存
///
enum FilterType { all, unread, read, starred, unstarred, saved }

const loadLimit = 50;

///
/// 订阅源内容，当真正加载某个订阅源时使用
///
class RssItemList {
  bool initialized = false;
  bool loading = false;
  bool allLoaded = false;
  Set<String> sids;
  List<String> iids = [];
  FilterType filterType;
  String search = "";

  RssItemList({
    required this.sids,
    this.filterType = FilterType.all,
  }) {
    //TODO 修改为存储类型
    filterType = FilterType.values[0];
  }

  Tuple2<String, List<String>> _getPredicates() {
    List<String> where = ["1 = 1"];
    List<String> whereArgs = [];
    if (sids.isNotEmpty) {
      var placeholders = List.filled(sids.length, "?").join(" , ");
      where.add("source IN ($placeholders)");
      whereArgs.addAll(sids);
    }
    if (filterType == FilterType.unread) {
      where.add("hasRead = 0");
    } else if (filterType == FilterType.starred) {
      where.add("starred = 1");
    }
    if (search != "") {
      where.add("(UPPER(title) LIKE ? OR UPPER(snippet) LIKE ?)");
      var keyword = "%$search%".toUpperCase();
      whereArgs.add(keyword);
      whereArgs.add(keyword);
    }
    return Tuple2(where.join(" AND "), whereArgs);
  }

  bool testItem(RssItem item) {
    if (sids.isNotEmpty && !sids.contains(item.feedFid)) return false;
    if (filterType == FilterType.unread && item.hasRead) return false;
    if (filterType == FilterType.starred && !item.starred) return false;
    if (search != "") {
      var keyword = search.toUpperCase();
      if (item.title.toUpperCase().contains(keyword)) return true;
      if (item.snippet.toUpperCase().contains(keyword)) return true;
      return false;
    }
    return true;
  }

  Future<void> init() async {
    if (loading) return;
    loading = true;
    var predicates = _getPredicates();
    var items = (await ProviderManager.db.query(
      CreateTableSql.rssItems.tableName,
      orderBy: "date DESC",
      limit: loadLimit,
      where: predicates.item1,
      whereArgs: predicates.item2,
    ))
        .map((m) => RssItem.fromJson(m))
        .toList();
    allLoaded = items.length < loadLimit;
    ProviderManager.rssProvider.currentRssHandler.mappingItems(items);
    iids = items.map((i) => i.iid).toList();
    loading = false;
    initialized = true;
    ProviderManager.rssProvider.broadcast();
  }

  Future<void> loadMore() async {
    if (loading || allLoaded) return;
    loading = true;
    var predicates = _getPredicates();
    var offset = iids
        .map(
            (iid) => ProviderManager.rssProvider.currentRssHandler.getItem(iid))
        .fold(0, (c, i) => c + (testItem(i) ? 1 : 0));
    var items = (await ProviderManager.db.query(
      CreateTableSql.rssItems.tableName,
      orderBy: "date DESC",
      limit: loadLimit,
      offset: offset,
      where: predicates.item1,
      whereArgs: predicates.item2,
    ))
        .map((m) => RssItem.fromJson(m))
        .toList();
    if (items.length < loadLimit) {
      allLoaded = true;
    }
    ProviderManager.rssProvider.currentRssHandler.mappingItems(items);
    iids.addAll(items.map((i) => i.iid));
    loading = false;
    ProviderManager.rssProvider.broadcast();
  }

  Future<void> setFilter(FilterType filter) async {
    if (filterType == filter && filter == FilterType.all) return;
    filterType = filter;
    await init();
  }

  Future<void> performSearch(String keyword) async {
    if (search == keyword) return;
    search = keyword;
    await init();
  }
}