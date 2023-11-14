import 'package:cloudreader/Database/Dao/feed_dao.dart';
import 'package:cloudreader/Models/feed.dart';
import 'package:sqflite/sqflite.dart';

import '../../Models/rss_item.dart';
import '../../Providers/provider_manager.dart';
import '../create_table_sql.dart';

class RSSItemDao {
  static final String tableName = CreateTableSql.items.tableName;

  static Future<void> insert(RSSItem item) async {
    await ProviderManager.db.insert(tableName, item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> insertAll(List<RSSItem> items) async {
    Batch batch = ProviderManager.db.batch();
    for (RSSItem item in items) {
      batch.insert(tableName, item.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  static Future<void> delete(RSSItem item) async {
    await ProviderManager.db
        .delete(tableName, where: 'id = ?', whereArgs: [item.id]);
  }

  static Future<void> update(RSSItem item) async {
    await ProviderManager.db.update(tableName, item.toJson());
  }

  static Future<void> updateAll(List<RSSItem> items) async {
    Batch batch = ProviderManager.db.batch();
    for (RSSItem item in items) {
      batch.update(tableName, item.toJson());
    }
    await batch.commit(noResult: true);
  }

  static Future<List<RSSItem>> queryByFeedFid(String feedFid) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'feedFid = ?', whereArgs: [feedFid]);
    return result.map<RSSItem>((e) => RSSItem.fromJson(e)).toList();
  }

  static Future<List<RSSItem>> queryByFeedid(int feedId) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'feedId = ?', whereArgs: [feedId]);
    return result.map<RSSItem>((e) => RSSItem.fromJson(e)).toList();
  }

  static Future<List<RSSItem>> queryByServiceId(int serviceId) async {
    List<Feed> feeds = await FeedDao.queryByServiceId(serviceId);
    List<RSSItem> items = [];
    for (var feed in feeds) {
      List<Map<String, Object?>> result = await ProviderManager.db
          .query(tableName, where: 'feedId = ?', whereArgs: [feed.id]);
      items.addAll(result.map<RSSItem>((e) => RSSItem.fromJson(e)).toList());
    }
    return items;
  }
}
