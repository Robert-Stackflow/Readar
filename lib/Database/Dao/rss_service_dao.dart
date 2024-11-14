import 'dart:async';

import 'package:readar/Database/create_table_sql.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Models/rss_service.dart';
import 'base_dao.dart';

class RssServiceDao extends BaseDao<RssServiceModel> {
  static final String tableName = CreateTableSql.rssService.tableName;

  RssServiceDao._internal();

  static final RssServiceDao instance = RssServiceDao._internal();

  @override
  Future<int> insert(RssServiceModel item) async {
    var db = await getDataBase();
    var res = await db.insert(
      tableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<void> initLocalRssService() async {
    RssServiceModel? localRssService = await checkLocalRssService();
    if (localRssService == null) {
      await insert(RssServiceModel.local());
    }
  }

  Future<RssServiceModel?> checkLocalRssService() async {
    List<RssServiceModel> rssServices = await queryAll();
    var localServices = rssServices
        .where((element) => element.rssServiceType == RssServiceType.local);
    if (localServices.isNotEmpty) {
      return localServices.first;
    }
    return null;
  }

  Future<RssServiceModel> getLocalRssService() async {
    RssServiceModel? localRssService = await checkLocalRssService();
    if (localRssService == null) {
      await initLocalRssService();
      localRssService = await checkLocalRssService();
    }
    return localRssService!;
  }

  @override
  Future<int> insertAll(List<RssServiceModel> items) async {
    var db = await getDataBase();
    Batch batch = db.batch();
    for (RssServiceModel item in items) {
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
  Future<int> delete(RssServiceModel item) async {
    var db = await getDataBase();
    var res = db.delete(tableName, where: 'uid = ?', whereArgs: [item.uid]);
    return res;
  }

  @override
  Future<int> update(RssServiceModel item) async {
    var db = await getDataBase();
    var res = db.update(tableName, item.toJson());
    return res;
  }

  @override
  Future<RssServiceModel?> queryById(int id) async {
    var db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return RssServiceModel.fromJson(result[0]);
    } else {
      return null;
    }
  }

  Future<RssServiceModel?> queryByUid(int uid) async {
    var db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'uid = ?', whereArgs: [uid]);
    if (result.isNotEmpty) {
      return RssServiceModel.fromJson(result[0]);
    } else {
      return null;
    }
  }

  @override
  Future<List<RssServiceModel>> queryAll() async {
    var db = await getDataBase();
    List<Map<String, Object?>> result = await db.query(tableName);
    return result.map((e) => RssServiceModel.fromJson(e)).toList();
  }

  @override
  Future<int> updateAll(List<RssServiceModel> items) async {
    var db = await getDataBase();
    Batch batch = db.batch();
    for (RssServiceModel item in items) {
      batch.update(tableName, item.toJson());
    }
    var res = await batch.commit();
    return res.length;
  }
}
