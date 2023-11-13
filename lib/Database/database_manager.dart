import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const _dbName = "cloudreader.db";
  static const _dbVersion = 1;
  static DatabaseManager? _instance;
  static Database? _database;

  static Future<DatabaseManager> getInstance() async {
    _instance ??= await _initDataBase();
    return _instance!;
  }

  static Future<Database> getDataBase() async {
    if (_database == null) {
      await getInstance();
    }
    return _database!;
  }

  static Future<DatabaseManager> _initDataBase() async {
    DatabaseManager databaseHelper = DatabaseManager();
    if (_database == null) {
      String path = join(await getDatabasesPath(), _dbName);
      _database =
          await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
    }

    return databaseHelper;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sources (
        sid TEXT PRIMARY KEY,
        url TEXT NOT NULL,
        iconUrl TEXT,
        name TEXT NOT NULL,
        openTarget INTEGER NOT NULL,
        latest INTEGER NOT NULL,
        lastTitle INTEGER NOT NULL
      );
    ''');
    await db.execute('''
    CREATE TABLE items (
        iid TEXT PRIMARY KEY,
        source TEXT NOT NULL,
        title TEXT NOT NULL,
        link TEXT NOT NULL,
        date INTEGER NOT NULL,
        content TEXT NOT NULL,
        snippet TEXT NOT NULL,
        hasRead INTEGER NOT NULL,
        starred INTEGER NOT NULL,
        creator TEXT,
        thumb TEXT
      );
    ''');
    await db.execute("CREATE INDEX itemsDate ON items (date DESC);");
  }

  static Future<void> createTable({
    required String tableName,
    required String sql,
  }) async {
    if (await isTableExit(tableName) == false) {
      await (await getDataBase()).execute(sql);
    }
  }

  static Future<bool> isTableExit(String tableName) async {
    var result = await (await getDataBase()).rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return result.isNotEmpty;
  }
}
