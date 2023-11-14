import 'package:cloudreader/Database/create_table_sql.dart';
import 'package:cloudreader/Database/database_manager.dart';

import '../../Models/feed.dart';
import '../../Providers/provider_manager.dart';

class FeedDao {
  static final String tableName = CreateTableSql.feed.tableName;

  static void insert(Feed feed) {
    DatabaseManager.getDataBase().then(
      (value) => value.insert(tableName, feed.toJson()),
    );
  }

  static void insertAll(List<Feed> feeds) {
    for (Feed feed in feeds) {
      insert(feed);
    }
  }

  static void delete(Feed feed) {
    DatabaseManager.getDataBase().then(
      (value) => value.delete(tableName, where: 'id = ?', whereArgs: [feed.id]),
    );
  }

  static void update(Feed feed) {
    DatabaseManager.getDataBase().then(
      (value) => value.update(tableName, feed.toJson()),
    );
  }

  static void updateAll(List<Feed> feeds) {
    for (Feed feed in feeds) {
      update(feed);
    }
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

  static Future<Feed> queryBySId(String sid) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'sid = ?', whereArgs: [sid]);
    return Feed.fromJson(result[0]);
  }

  static Future<Feed> queryByUrl(String url) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'url = ?', whereArgs: [url]);
    return Feed.fromJson(result[0]);
  }
}
