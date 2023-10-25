import 'package:cloudreader/api/openai_request.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Configs/db_config.dart';

class MessageData {
  String content;
  int sender; //0我，1对方,2系统
  DateTime time;
  int? id;
  Moderation moderation = Moderation.none;

  MessageData({
    required this.time,
    required this.content,
    required this.sender,
    this.moderation = Moderation.none,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'time': time.toIso8601String(),
      'sender': sender,
      'moderation': moderation.index,
    };
  }

  static Future<int> insertMessage(MessageData data) async {
    final database = openDatabase(
      join(await getDatabasesPath(), DBConfig.dbname),
      version: 1,
    );
    final db = await database;
    return await db.insert(
      DBConfig.subscriptionTableName,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<MessageData>> messages() async {
    final database = openDatabase(
      join(await getDatabasesPath(), DBConfig.dbname),
      version: 1,
    );
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(DBConfig.subscriptionTableName);
    return List.generate(maps.length, (i) {
      return MessageData(
        id: maps[i]['id'],
        content: maps[i]['content'],
        time: DateTime.parse(maps[i]['time']),
        sender: maps[i]['sender'],
        moderation: Moderation.values[maps[i]['moderation']],
      );
    });
  }

  static Future<void> deleteAll() async {
    final database = openDatabase(
      join(await getDatabasesPath(), DBConfig.dbname),
      version: 1,
    );
    final db = await database;
    await db.delete(DBConfig.subscriptionTableName);
  }

  static Future<int> maxId() async {
    final database = openDatabase(
      join(await getDatabasesPath(), DBConfig.dbname),
      version: 1,
    );
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(DBConfig.subscriptionTableName, columns: ['max(id)']);
    return maps[0]['max(id)'] ?? 0;
  }
}
