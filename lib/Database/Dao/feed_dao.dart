import 'dart:async';

import 'package:readar/Database/Dao/base_dao.dart';
import 'package:readar/Database/create_table_sql.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Models/feed.dart';
import 'article_item_dao.dart';

class FeedDao extends BaseDao<Feed> {
  static final String tableName = CreateTableSql.feed.tableName;

  FeedDao._internal();

  static final FeedDao instance = FeedDao._internal();

  @override
  Future<int> insert(
    Feed item, {
    bool checkRssUrl = true,
  }) async {
    if (checkRssUrl) {
      List<Feed> feeds = await queryByServiceId(item.serviceUid);
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
    List<Feed> items, {
    bool checkRssUrl = true,
  }) async {
    if (items.isEmpty) return 0;
    if (checkRssUrl) {
      List<Feed> feeds = await queryByServiceId(items[0].serviceUid);
      items.removeWhere(
          (element) => feeds.any((feed) => feed.url == element.url));
    }
    Database db = await getDataBase();
    Batch batch = db.batch();
    for (Feed feed in items) {
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
  Future<int> delete(Feed item) async {
    Database db = await getDataBase();
    var res = await db.delete(tableName, where: 'id = ?', whereArgs: [item.id]);
    return res;
  }

  Future<int> deleteFeeds(List<String> fids) async {
    Database db = await getDataBase();
    final batch = db.batch();
    for (var fid in fids) {
      batch.delete(
        ArticleItemDao.tableName,
        where: "feedFid = ?",
        whereArgs: [fid],
      );
      batch.delete(
        tableName,
        where: "fid = ?",
        whereArgs: [fid],
      );
    }
    var res = await batch.commit();
    return res.length;
  }

  @override
  Future<int> update(Feed item) async {
    Database db = await getDataBase();
    var res = await db.update(tableName, item.toJson());
    return res;
  }

  @override
  Future<int> updateAll(List<Feed> items) async {
    Database db = await getDataBase();
    Batch batch = db.batch();
    for (Feed feed in items) {
      batch.update(tableName, feed.toJson());
    }
    var res = await batch.commit();
    return res.length;
  }

  Future<List<Feed>> queryByServiceId(int serviceId) async {
    Database db = await getDataBase();
    List<Map<String, Object?>> result = await db
        .query(tableName, where: 'serviceId = ?', whereArgs: [serviceId]);
    List<Feed> feeds = [];
    for (dynamic json in result) {
      feeds.add(Feed.fromJson(json));
    }
    return feeds;
  }

  @override
  Future<Feed> queryById(int id) async {
    Database db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return Feed.fromJson(result[0]);
  }

  Future<Feed> queryByFid(String fid) async {
    Database db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'fid = ?', whereArgs: [fid]);
    return Feed.fromJson(result[0]);
  }

  Future<int> getIdByFid(String fid) async {
    Database db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'fid = ?', whereArgs: [fid]);
    return Feed.fromJson(result[0]).id;
  }

  Future<Feed> queryByUrl(String url) async {
    Database db = await getDataBase();
    List<Map<String, Object?>> result =
        await db.query(tableName, where: 'url = ?', whereArgs: [url]);
    return Feed.fromJson(result[0]);
  }

  @override
  FutureOr<List<Feed>> queryAll() {
    var db = getDataBase();
    return db.then((value) => value
        .query(tableName)
        .then((value) => value.map((e) => Feed.fromJson(e)).toList()));
  }

  @override
  FutureOr<int> deleteAll() {
    var db = getDataBase();
    return db.then((value) => value.delete(tableName));
  }
}
