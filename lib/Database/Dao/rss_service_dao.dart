import 'dart:async';

import 'package:readar/Database/create_table_sql.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Models/rss_service.dart';
import 'base_dao.dart';

class RssServiceDao extends BaseDao<RssService> {
  static final String tableName = CreateTableSql.rssService.tableName;

  RssServiceDao._internal();

  static final RssServiceDao instance = RssServiceDao._internal();

  @override
  Future<int> insert(RssService item) async {
    var db = await getDataBase();
    var res = await db.insert(
      tableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<void> initLocalRssService() async {
    RssService? localRssService = await checkLocalRssService();
    if (localRssService == null) {
      await insert(RssService.local());
    }
  }

  Future<RssService?> checkLocalRssService() async {
    List<RssService> rssServices = await queryAll();
    var localServices = rssServices
        .where((element) => element.rssServiceType == RssServiceType.local);
    if (localServices.isNotEmpty) {
      return localServices.first;
    }
    return null;
  }

  Future<RssService> getLocalRssService() async {
    RssService? localRssService = await checkLocalRssService();
    if (localRssService == null) {
      await initLocalRssService();
      localRssService = await checkLocalRssService();
    }
    return localRssService!;
  }

  @override
  Future<int> insertAll(List<RssService> items) async {
    var db = await getDataBase();
    Batch batch = db.batch();
    for (RssService item in items) {
      batch.insert(
        tableName,
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    var res = await batch.commit();
    return res.length;
  }

  @override
  Future<int> deleteAll() async {
    var db = await getDataBase();
    var res = db.rawDelete("delete from $tableName where 1 = 1");
    return res;
  }

  @override
  Future<int> delete(RssService item) async {
    var db = await getDataBase();
    var res = db.delete(tableName, where: 'id = ?', whereArgs: [item.id]);
    return res;
  }

  @override
  Future<int> update(RssService item) async {
    var db = await getDataBase();
    var res = db.update(tableName, item.toJson());
    return res;
  }

  @override
  Future<RssService?> queryById(int id) async {
    var db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return RssService.fromJson(result[0]);
    } else {
      return null;
    }
  }

  @override
  Future<List<RssService>> queryAll() async {
    var db = await getDataBase();
    List<Map<String, Object?>> result = await db.query(tableName);
    return result.map((e) => RssService.fromJson(e)).toList();
  }

  @override
  Future<int> updateAll(List<RssService> items) async {
    var db = await getDataBase();
    Batch batch = db.batch();
    for (RssService item in items) {
      batch.update(tableName, item.toJson());
    }
    var res = await batch.commit();
    return res.length;
  }
}
