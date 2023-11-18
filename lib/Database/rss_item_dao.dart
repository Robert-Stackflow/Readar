import 'package:cloudreader/Database/feed_dao.dart';
import 'package:cloudreader/Models/feed.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/rss_item.dart';
import '../Providers/provider_manager.dart';
import 'create_table_sql.dart';

class RssItemDao {
  static final String tableName = CreateTableSql.rssItems.tableName;

  static Future<void> insert(RssItem item) async {
    await ProviderManager.db.insert(tableName, item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> insertAll(List<RssItem> items) async {
    Batch batch = ProviderManager.db.batch();
    for (RssItem item in items) {
      batch.insert(tableName, item.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  static Future<void> delete(RssItem item) async {
    await ProviderManager.db
        .delete(tableName, where: 'id = ?', whereArgs: [item.id]);
  }

  static Future<void> update(RssItem item) async {
    await ProviderManager.db.update(tableName, item.toJson());
  }

  static Future<void> updateAll(List<RssItem> items) async {
    Batch batch = ProviderManager.db.batch();
    for (RssItem item in items) {
      batch.update(tableName, item.toJson());
    }
    await batch.commit(noResult: true);
  }

  static Future<dynamic> queryUnReadCountByFeedFid() async {
    return await ProviderManager.db.rawQuery(
        "SELECT feedFid, COUNT(iid) FROM rssItems WHERE hasRead=0 GROUP BY feedFid;");
  }

  static Future<List<RssItem>> queryByFeedFid(String feedFid) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'feedFid = ?', whereArgs: [feedFid]);
    return result.map<RssItem>((e) => RssItem.fromJson(e)).toList();
  }

  static Future<List<RssItem>> queryByFeedid(int feedId) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'feedId = ?', whereArgs: [feedId]);
    return result.map<RssItem>((e) => RssItem.fromJson(e)).toList();
  }

  static Future<List<RssItem>> queryByServiceId(int serviceId) async {
    List<Feed> feeds = await FeedDao.queryByServiceId(serviceId);
    List<RssItem> items = [];
    for (var feed in feeds) {
      List<Map<String, Object?>> result = await ProviderManager.db
          .query(tableName, where: 'feedId = ?', whereArgs: [feed.id]);
      items.addAll(result.map<RssItem>((e) => RssItem.fromJson(e)).toList());
    }
    return items;
  }
}
