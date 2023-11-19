import 'package:cloudreader/Database/create_table_sql.dart';
import 'package:sqflite/sqflite.dart';

import '../../Models/rss_service.dart';
import '../../Providers/provider_manager.dart';

class RssServiceDao {
  static final String tableName = CreateTableSql.rssService.tableName;

  static Future<int> insert(RssService rssService) async {
    return await ProviderManager.db.insert(tableName, rssService.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Object?>> insertAll(List<RssService> rssServices) async {
    Batch batch = ProviderManager.db.batch();
    for (RssService item in rssServices) {
      batch.insert(tableName, item.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return await batch.commit();
  }

  static Future<void> deleteAll() async {
    ProviderManager.db.rawDelete("delete from $tableName where 1 = 1");
  }

  static Future<void> delete(RssService rssService) async {
    ProviderManager.db
        .delete(tableName, where: 'id = ?', whereArgs: [rssService.id]);
  }

  static Future<void> update(RssService rssService) async {
    ProviderManager.db.update(tableName, rssService.toJson());
  }

  static Future<RssService?> queryById(int id) async {
    List<Map<String, Object?>> result = await ProviderManager.db
        .query(tableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return RssService.fromJson(result[0]);
    } else {
      return null;
    }
  }

  static Future<List<RssService>> queryAll() async {
    List<Map<String, Object?>> result =
        await ProviderManager.db.query(tableName);
    return result.map((e) => RssService.fromJson(e)).toList();
  }
}
