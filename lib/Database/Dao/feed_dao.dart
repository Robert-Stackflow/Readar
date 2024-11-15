import 'dart:async';

import 'package:readar/Database/Dao/base_dao.dart';
import 'package:readar/Database/create_table_sql.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Models/feed.dart';
import 'article_dao.dart';

class FeedDao extends BaseDao<FeedModel> {
  static final String tableName = CreateTableSql.feed.tableName;

  FeedDao._internal();

  static final FeedDao instance = FeedDao._internal();

  @override
  Future<int> insert(
    FeedModel item, {
    bool checkRssUrl = true,
  }) async {
    if (checkRssUrl) {
      List<FeedModel> feeds = await queryByServiceUid(item.serviceUid);
      if (feeds.any((feed) => feed.url == item.url)) {
        return 0;
      }
    }
    Database db = await getDataBase();
    return await db.insert(
      tableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> insertAll(
    List<FeedModel> items, {
    bool checkRssUrl = true,
  }) async {
    if (items.isEmpty) return 0;
    if (checkRssUrl) {
      List<FeedModel> feeds = await queryByServiceUid(items[0].serviceUid);
      items.removeWhere(
          (element) => feeds.any((feed) => feed.url == element.url));
    }
    Database db = await getDataBase();
    Batch batch = db.batch();
    for (FeedModel feed in items) {
      batch.insert(
        tableName,
        feed.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    var res = await batch.commit();
    return res.length;
  }

  @override
  Future<int> delete(FeedModel item) async {
    Database db = await getDataBase();
    var res =
        await db.delete(tableName, where: 'uid = ?', whereArgs: [item.uid]);
    return res;
  }

  Future<int> deleteFeeds(List<String> uids) async {
    Database db = await getDataBase();
    final batch = db.batch();
    for (var uid in uids) {
      batch.delete(
        ArticleDao.tableName,
        where: "feedUid = ?",
        whereArgs: [uid],
      );
      batch.delete(
        tableName,
        where: "uid = ?",
        whereArgs: [uid],
      );
    }
    var res = await batch.commit();
    return res.length;
  }

  @override
  Future<int> update(FeedModel item) async {
    Database db = await getDataBase();
    var tmp = item.toJson();
    tmp.remove('id');
    var res = await db
        .update(tableName, tmp, where: 'uid = ?', whereArgs: [tmp['uid']]);
    return res;
  }

  @override
  Future<int> updateAll(List<FeedModel> items) async {
    Database db = await getDataBase();
    Batch batch = db.batch();
    for (FeedModel feed in items) {
      var tmp = feed.toJson();
      tmp.remove('id');
      batch.update(tableName, tmp, where: 'uid = ?', whereArgs: [tmp['uid']]);
    }
    var res = await batch.commit();
    return res.length;
  }

  Future<List<FeedModel>> queryByServiceUid(String serviceUid) async {
    Database db = await getDataBase();
    List<Map<String, Object?>> result = await db
        .query(tableName, where: 'serviceUid = ?', whereArgs: [serviceUid]);
    List<FeedModel> feeds = [];
    for (dynamic json in result) {
      feeds.add(FeedModel.fromJson(json));
    }
    return feeds;
  }

  @override
  Future<FeedModel> queryById(int id) async {
    Database db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return FeedModel.fromJson(result[0]);
  }

  Future<FeedModel> queryByUid(String uid) async {
    Database db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'uid = ?', whereArgs: [uid]);
    return FeedModel.fromJson(result[0]);
  }

  Future<FeedModel> queryByUrl(String url) async {
    Database db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'url = ?', whereArgs: [url]);
    return FeedModel.fromJson(result[0]);
  }

  @override
  FutureOr<List<FeedModel>> queryAll() {
    var db = getDataBase();
    return db.then((value) => value
        .query(tableName)
        .then((value) => value.map((e) => FeedModel.fromJson(e)).toList()));
  }

  @override
  FutureOr<int> deleteAll() {
    var db = getDataBase();
    return db.then((value) => value.delete(tableName));
  }
}
