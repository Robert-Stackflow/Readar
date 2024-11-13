import 'dart:async';

import 'package:readar/Database/Dao/feed_dao.dart';
import 'package:readar/Models/feed.dart';
import 'package:sqflite/sqflite.dart';

import '../../Models/article_item.dart';
import '../create_table_sql.dart';
import 'base_dao.dart';

class ArticleItemDao extends BaseDao<ArticleItem> {
  static final String tableName = CreateTableSql.articleItem.tableName;

  ArticleItemDao._internal();

  static final ArticleItemDao instance = ArticleItemDao._internal();

  @override
  Future<int> insert(ArticleItem item) async {
    var db = await getDataBase();
    var res = await db.insert(
      tableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  @override
  Future<int> insertAll(List<ArticleItem> items) async {
    var db = await getDataBase();
    Batch batch = db.batch();
    for (ArticleItem item in items) {
      batch.insert(tableName, item.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    var result = await batch.commit();
    return result.length;
  }

  Future<List<ArticleItem>> query({
    required int? loadLimit,
    required String where,
    int offset = 0,
    required List whereArgs,
  }) async {
    var db = await getDataBase();
    List<Map<String, Object?>> result = await db.query(
      tableName,
      orderBy: "publishTime DESC",
      limit: loadLimit,
      offset: offset,
      where: where,
      whereArgs: whereArgs,
    );
    return result.map((e) => ArticleItem.fromJson(e)).toList();
  }

  @override
  Future<int> delete(ArticleItem item) async {
    var db = await getDataBase();
    var res = await db.delete(
      tableName,
      where: 'uid = ?',
      whereArgs: [item.uid],
    );
    return res;
  }

  @override
  Future<int> update(ArticleItem item) async {
    var db = await getDataBase();
    var res = await db.update(tableName, item.toJson());
    return res;
  }

  @override
  Future<int> updateAll(List<ArticleItem> items) async {
    var db = await getDataBase();
    Batch batch = db.batch();
    for (ArticleItem item in items) {
      batch.update(tableName, item.toJson());
    }
    var res = await batch.commit();
    return res.length;
  }

  Future<List<Map<String, Object?>>> queryUnReadCountByFeedFid() async {
    var db = await getDataBase();
    var res = await db.rawQuery(
        "SELECT feedUid, COUNT(iid) FROM rssItems WHERE hasRead=0 GROUP BY feedUid;");
    return res;
  }

  Future<List<ArticleItem>> queryByFeedUid(String feedUid) async {
    var db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'feedUid = ?', whereArgs: [feedUid]);
    return result.map<ArticleItem>((e) => ArticleItem.fromJson(e)).toList();
  }

  Future<List<ArticleItem>> queryByServiceUid(String serviceUid) async {
    List<Feed> feeds = await FeedDao.instance.queryByServiceUid(serviceUid);
    List<ArticleItem> items = [];
    for (var feed in feeds) {
      List<ArticleItem> result = await queryByFeedUid(feed.uid);
      items.addAll(result);
    }
    return items;
  }

  @override
  FutureOr<int> deleteAll() {
    var db = getDataBase();
    return db.then((value) => value.delete(tableName));
  }

  @override
  FutureOr<List<ArticleItem>> queryAll() {
    var db = getDataBase();
    return db.then((value) => value
        .query(tableName)
        .then((value) => value.map((e) => ArticleItem.fromJson(e)).toList()));
  }

  @override
  FutureOr<ArticleItem?> queryById(int id) {
    var db = getDataBase();
    return db.then((value) => value.query(tableName,
        where: 'id = ?',
        whereArgs: [id]).then((value) => ArticleItem.fromJson(value.first)));
  }

  FutureOr<ArticleItem?> queryByUid(int uid) {
    var db = getDataBase();
    return db.then((value) => value.query(tableName,
        where: 'uid = ?',
        whereArgs: [uid]).then((value) => ArticleItem.fromJson(value.first)));
  }
}
