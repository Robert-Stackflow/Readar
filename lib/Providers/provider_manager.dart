import 'dart:io';

import 'package:cloudreader/Database/database_manager.dart';
import 'package:cloudreader/Providers/rss_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jaguar/serve/server.dart';
import 'package:jaguar_flutter_asset/jaguar_flutter_asset.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../Database/rss_service_dao.dart';
import '../Handler/rss_service_manager.dart';
import '../Models/rss_service.dart';
import '../Utils/hive_util.dart';
import '../Utils/store.dart';
import 'global_provider.dart';

abstract class ProviderManager {
  static bool _initialized = false;
  static GlobalProvider globalProvider = GlobalProvider();
  static RssProvider rssProvider = RssProvider();
  static late Database db;
  static late Jaguar server;
  static const String address = "127.0.0.1";
  static const int port = 4567;

  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    db = await DatabaseManager.getDataBase();
    Store.sp = await SharedPreferences.getInstance();
    await initHive();
    await initData();
  }

  static Future<void> initHive() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      await Hive.initFlutter(HiveUtil.database);
    } else {
      await Hive.initFlutter();
    }
    await HiveUtil.openHiveBox(HiveUtil.settingsBox);
    await HiveUtil.openHiveBox(HiveUtil.servicesBox);
  }

  static Future<void> initData() async {
    await insertData();
    await RssServiceDao.queryAll().then((value) async {
      rssProvider.rssServices = value;
      List<RssServiceManager> tmpHandlers = [];
      for (var rssService in value) {
        var rssHandler = RssServiceManager(rssService);
        rssHandler.init();
        tmpHandlers.add(rssHandler);
      }
      rssProvider.rssServiceManagers = tmpHandlers;
      rssProvider.currentRssServiceManager = rssProvider.rssServiceManagers[0];
    });
    server =
        Jaguar(address: ProviderManager.address, port: ProviderManager.port);
    server.addRoute(serveFlutterAssets());
    await server.serve();
  }

  static Future<void> insertData() async {
    await RssServiceDao.queryAll().then((value) async {
      List<RssService> rssServices = [
        RssService(
          "https://theoldreader.com",
          "Old Reader",
          RssServiceType.theOldReader,
          id: 1,
          username: "yutuan.victory@gmail.com",
          password: "6Jv#f9g@cXNPs9z",
          fetchLimit: 500,
          params: {"useInt64": false},
        ),
        // RssService(
        //   "https://theoldreader.com",
        //   "Old Reader",
        //   RssServiceType.theOldReader,
        //   id: 2,
        //   username: "yutuan.victory@gmail.com",
        //   password: "6Jv#f9g@cXNPs9z",
        //   fetchLimit: 500,
        //   params: {"useInt64": false},
        // ),
        // RssService(
        //   "https://theoldreader.com",
        //   "Old Reader",
        //   RssServiceType.theOldReader,
        //   id: 3,
        //   username: "yutuan.victory@gmail.com",
        //   password: "6Jv#f9g@cXNPs9z",
        //   fetchLimit: 500,
        //   params: {"useInt64": false},
        // ),
      ];
      await RssServiceDao.insertAll(rssServices);
    });
  }

  static Brightness currentBrightness(BuildContext context) {
    return globalProvider.getBrightness() ??
        MediaQuery.of(context).platformBrightness;
  }
}
