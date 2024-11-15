import 'dart:async';

import 'package:readar/Database/Dao/feed_dao.dart';
import 'package:readar/Models/feed.dart';
import 'package:sqflite/sqflite.dart';

import '../../Models/article.dart';
import '../create_table_sql.dart';
import 'base_dao.dart';

class ArticleDao extends BaseDao<Article> {
  static final String tableName = CreateTableSql.articleItem.tableName;

  ArticleDao._internal();

  static final ArticleDao instance = ArticleDao._internal();

  @override
  Future<int> insert(Article item) async {
    var db = await getDataBase();
    var res = await db.insert(
      tableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  @override
  Future<int> insertAll(List<Article> items) async {
    var db = await getDataBase();
    Batch batch = db.batch();
    for (Article item in items) {
      batch.insert(tableName, item.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    var result = await batch.commit();
    return result.length;
  }

  Future<List<Article>> query({
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
    return result.map((e) => Article.fromJson(e)).toList();
  }

  @override
  Future<int> delete(Article item) async {
    var db = await getDataBase();
    var res = await db.delete(
      tableName,
      where: 'uid = ?',
      whereArgs: [item.uid],
    );
    return res;
  }

  @override
  Future<int> update(Article item) async {
    var db = await getDataBase();
    var res = await db.update(tableName, item.toJson());
    return res;
  }

  @override
  Future<int> updateAll(List<Article> items) async {
    var db = await getDataBase();
    Batch batch = db.batch();
    for (Article item in items) {
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

  Future<List<Article>> queryByFeedUid(String feedUid) async {
    var db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'feedUid = ?', whereArgs: [feedUid]);
    return result.map<Article>((e) => Article.fromJson(e)).toList();
  }

  Future<List<Article>> queryByServiceUid(String serviceUid) async {
    List<FeedModel> feeds = await FeedDao.instance.queryByServiceUid(serviceUid);
    List<Article> items = [];
    for (var feed in feeds) {
      List<Article> result = await queryByFeedUid(feed.uid);
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
  FutureOr<List<Article>> queryAll() {
    var db = getDataBase();
    return db.then((value) => value
        .query(tableName)
        .then((value) => value.map((e) => Article.fromJson(e)).toList()));
  }

  @override
  FutureOr<Article?> queryById(int id) {
    var db = getDataBase();
    return db.then((value) => value.query(tableName,
        where: 'id = ?',
        whereArgs: [id]).then((value) => Article.fromJson(value.first)));
  }

  FutureOr<Article?> queryByUid(int uid) {
    var db = getDataBase();
    return db.then((value) => value.query(tableName,
        where: 'uid = ?',
        whereArgs: [uid]).then((value) => Article.fromJson(value.first)));
  }
}
