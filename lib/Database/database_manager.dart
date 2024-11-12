import 'dart:async';

import 'package:path/path.dart';
import 'package:readar/Database/Dao/rss_service_dao.dart';
import 'package:readar/Database/create_table_sql.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../Utils/file_util.dart';
import '../Utils/responsive_util.dart';

class DatabaseManager {
  static const _dbName = "readar.db";
  static const _dbVersion = 1;
  static Database? _database;

  static Future<Database> getDataBase() async {
    if (_database == null) {
      await _initDataBase();
    }
    return _database!;
  }

  static Future<void> _initDataBase() async {
    if (ResponsiveUtil.isDesktop()) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    if (_database == null) {
      String path = join(await FileUtil.getDatabaseDir(), "$_dbName");
      _database = await openDatabase(
        path,
        version: _dbVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
      await RssServiceDao.instance.initLocalRssService();
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(CreateTableSql.rssService.sql);
    await db.execute(CreateTableSql.feed.sql);
    await db.execute(CreateTableSql.articleItem.sql);
    await db.execute(CreateTableSql.backupService.sql);
    await db.execute(CreateTableSql.extensionService.sql);
  }

  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {}

  static Future<void> createTable({
    required String tableName,
    required String sql,
  }) async {
    if (await isTableExist(tableName) == false) {
      await (await getDataBase()).execute(sql);
    }
  }

  static Future<bool> isTableExist(
    String tableName, {
    Database? overrideDb,
  }) async {
    var result = await (overrideDb ?? await getDataBase()).rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return result.isNotEmpty;
  }

  static Future<bool> isColumnExist(
    String tableName,
    String columnName, {
    Database? overrideDb,
  }) async {
    var result = await (overrideDb ?? await getDataBase())
        .rawQuery("PRAGMA table_info($tableName)");
    return result.any((element) => element['name'] == columnName);
  }
}
