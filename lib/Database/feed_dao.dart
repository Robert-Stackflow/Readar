import 'package:afar/Database/create_table_sql.dart';
import 'package:sqflite/sqflite.dart';

import '../../Models/feed.dart';
import '../../Providers/provider_manager.dart';

class FeedDao {
  static final String tableName = CreateTableSql.feed.tableName;

  static Future<int> insert(Feed feed) async {
    return await ProviderManager.db.insert(tableName, feed.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Object?>> insertAll(List<Feed> feeds) async {
    Batch batch = ProviderManager.db.batch();
    for (Feed feed in feeds) {
      batch.insert(tableName, feed.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return await batch.commit();
  }

  static Future<void> delete(Feed feed) async {
    await ProviderManager.db
        .delete(tableName, where: 'id = ?', whereArgs: [feed.id]);
  }

  static Future<void> deleteAll(List<String> fids) async {
    final batch = ProviderManager.db.batch();
    for (var fid in fids) {
      batch.delete(
        CreateTableSql.rssItems.tableName,
        where: "feedFid = ?",
        whereArgs: [fid],
      );
      batch.delete(
        CreateTableSql.feed.tableName,
        where: "fid = ?",
        whereArgs: [fid],
      );
    }
    await batch.commit(noResult: true);
  }

  static Future<void> update(Feed feed) async {
    await ProviderManager.db.update(tableName, feed.toJson());
  }

  static Future<void> updateAll(List<Feed> feeds) async {
    Batch batch = ProviderManager.db.batch();
    for (Feed feed in feeds) {
      batch.update(tableName, feed.toJson());
    }
    await batch.commit(noResult: true);
  }

  static Future<List<Feed>> queryByServiceId(int serviceId) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'serviceId = ?', whereArgs: [serviceId]);
    List<Feed> feeds = [];
    for (dynamic json in result) {
      feeds.add(Feed.fromJson(json));
    }
    return feeds;
  }

  static Future<Feed> queryById(int id) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'id = ?', whereArgs: [id]);
    return Feed.fromJson(result[0]);
  }

  static Future<Feed> queryByFid(String fid) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'fid = ?', whereArgs: [fid]);
    return Feed.fromJson(result[0]);
  }

  static Future<int> getIdByFid(String fid) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'fid = ?', whereArgs: [fid]);
    return Feed.fromJson(result[0]).id ?? 0;
  }

  static Future<Feed> queryByUrl(String url) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'url = ?', whereArgs: [url]);
    return Feed.fromJson(result[0]);
  }
}
