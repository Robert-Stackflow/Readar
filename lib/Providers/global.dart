import 'package:cloudreader/Api/service_handler.dart';
import 'package:cloudreader/Providers/feeds_provider.dart';
import 'package:cloudreader/Providers/sync_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:jaguar/serve/server.dart';
import 'package:jaguar_flutter_asset/jaguar_flutter_asset.dart';
import 'package:sqflite/sqflite.dart';

import '../Api/google_reader_request.dart';
import '../Utils/db.dart';
import '../Utils/store.dart';
import 'feed_content_provider.dart';
import 'global_provider.dart';
import 'groups_provider.dart';
import 'items_provider.dart';

abstract class Global {
  static bool _initialized = false;
  static GlobalProvider globalProvider = GlobalProvider();
  static FeedsProvider sourcesProvider = FeedsProvider();
  static ItemsProvider itemsProvider = ItemsProvider();
  static FeedContentProvider feedsProvider = FeedContentProvider();
  static GroupsProvider groupsProvider = GroupsProvider();
  static SyncProvider syncProvider = SyncProvider();
  static ServiceHandler? serviceHandler;
  static late Database db;
  static late Jaguar server;

  static void init() {
    assert(!_initialized);
    _initialized = true;
    var serviceType =
        SyncService.values[Store.sp.getInt(StoreKeys.SYNC_SERVICE) ?? 0];
    switch (serviceType) {
      case SyncService.none:
        break;
      case SyncService.fever:
        serviceHandler = GReaderServiceHandler();
        break;
      case SyncService.feedbin:
        serviceHandler = GReaderServiceHandler();
        break;
      case SyncService.googleReader:
      case SyncService.inoreader:
        serviceHandler = GReaderServiceHandler();
        break;
    }
    initDatabase();
  }

  static Future<void> initDatabase() async {
    db = (await DatabaseHelper.getDatabase())!;
    await db.delete(
      "items",
      where: "date < ? AND starred = 0",
      whereArgs: [
        DateTime.now()
            .subtract(Duration(days: globalProvider.keepItemsDays))
            .millisecondsSinceEpoch,
      ],
    );
    server = Jaguar(address: "127.0.0.1", port: 4567);
    server.addRoute(serveFlutterAssets());
    await server.serve();
    await sourcesProvider.init();
    await feedsProvider.all.init();
    if (globalProvider.syncOnStart) await syncProvider.syncWithService();
  }

  static Brightness currentBrightness(BuildContext context) {
    return globalProvider.getBrightness() ??
        MediaQuery.of(context).platformBrightness;
  }
}
