import 'package:cloudreader/Database/create_table_sql.dart';
import 'package:cloudreader/Database/database_manager.dart';

import '../../Models/feed_service.dart';
import '../../Providers/provider_manager.dart';

class FeedServiceDao {
  static final String tableName = CreateTableSql.feedService.tableName;

  static void insert(FeedService feedService) {
    DatabaseManager.getDataBase().then(
      (value) => value.insert(tableName, feedService.toJson()),
    );
  }

  static void deleteAll() {
    DatabaseManager.getDataBase().then(
      (value) => value.rawDelete("delete from $tableName where 1 = 1"),
    );
  }

  static void delete(FeedService feedService) {
    DatabaseManager.getDataBase().then(
      (value) =>
          value.delete(tableName, where: 'id = ?', whereArgs: [feedService.id]),
    );
  }

  static void update(FeedService feedService) {
    DatabaseManager.getDataBase().then(
      (value) => value.update(tableName, feedService.toJson()),
    );
  }

  static Future<FeedService?> queryById(int id) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return FeedService.fromJson(result[0]);
    } else {
      return null;
    }
  }

  static Future<List<FeedService>> queryAll() async {
    List<Map<String, Object?>> result =
        await ProviderManager.db.query(tableName);
    return result.map((e) => FeedService.fromJson(e)).toList();
  }
}
