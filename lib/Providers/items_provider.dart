import 'package:cloudreader/Database/Dao/item_dao.dart';
import 'package:cloudreader/Database/create_table_sql.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/rss_item.dart';
import 'provider_manager.dart';

class ItemsProvider with ChangeNotifier {
  final Map<String, RSSItem> _idToItemMap = {};

  bool containsItem(String id) => _idToItemMap.containsKey(id);

  RSSItem getItem(String id) => _idToItemMap[id]!;

  Iterable<RSSItem> getItems() => _idToItemMap.values;

  void mappingItems(Iterable<RSSItem> items) {
    for (var item in items) {
      _idToItemMap[item.iid] = item;
    }
  }

  Future<void> updateItem(
    String iid, {
    Batch? batch,
    bool? read,
    bool? starred,
    local = false,
  }) async {
    if (ProviderManager.serviceHandler == null) return;
    Map<String, dynamic> updateMap = {};
    if (_idToItemMap.containsKey(iid)) {
      final item = _idToItemMap[iid]!.clone();
      if (read != null) {
        item.hasRead = read;
        if (!local) {
          if (read) {
            ProviderManager.serviceHandler!.markRead(item);
          } else {
            ProviderManager.serviceHandler!.markUnread(item);
          }
        }
        ProviderManager.feedsProvider
            .updateUnreadCount(item.feedFid, read ? -1 : 1);
      }
      if (starred != null) {
        item.starred = starred;
        if (!local) {
          if (starred) {
            ProviderManager.serviceHandler!.star(item);
          } else {
            ProviderManager.serviceHandler!.unstar(item);
          }
        }
      }
      _idToItemMap[iid] = item;
    }
    if (read != null) updateMap["hasRead"] = read ? 1 : 0;
    if (starred != null) updateMap["starred"] = starred ? 1 : 0;
    if (batch != null) {
      batch.update(CreateTableSql.items.tableName, updateMap,
          where: "iid = ?", whereArgs: [iid]);
    } else {
      notifyListeners();
      await ProviderManager.db.update(CreateTableSql.items.tableName, updateMap,
          where: "iid = ?", whereArgs: [iid]);
    }
  }

  Future<void> markAllRead(
    Set<String> sids, {
    required DateTime date,
    before = true,
  }) async {
    if (ProviderManager.serviceHandler == null) return;

    ProviderManager.serviceHandler!.markAllRead(sids, date, before);
    List<String> predicates = ["hasRead = 0"];
    if (sids.isNotEmpty) {
      predicates
          .add("feedFid IN (${List.filled(sids.length, "?").join(" , ")})");
    }
    predicates
        .add("date ${before ? "<=" : ">="} ${date.millisecondsSinceEpoch}");
    await ProviderManager.db.update(
      CreateTableSql.items.tableName,
      {"hasRead": 1},
      where: predicates.join(" AND "),
      whereArgs: sids.toList(),
    );
    for (var item in _idToItemMap.values.toList()) {
      if (sids.isNotEmpty && !sids.contains(item.feedFid)) continue;
      if ((before
          ? item.date.compareTo(date) > 0
          : item.date.compareTo(date) < 0)) continue;
      item.hasRead = true;
    }
    notifyListeners();
    // ProviderManager.feedsProvider.updateUnreadCounts();
  }

  Future<void> fetchItems() async {
    if (ProviderManager.serviceHandler == null) return;
    final items = await ProviderManager.serviceHandler!.fetchItems();
    List<RSSItem> batchedItems = [];
    for (var item in items) {
      if (!ProviderManager.feedsProvider.containsFeed(item.feedFid)) continue;
      _idToItemMap[item.iid] = item;
      batchedItems.add(item);
    }
    RSSItemDao.insertAll(batchedItems);
    notifyListeners();
    ProviderManager.feedsProvider.mergeFetchedItems(items);
    ProviderManager.feedContentProvider.mergeFetchedItems(items);
  }

  Future<void> syncItems() async {
    if (ProviderManager.serviceHandler == null) return;
    final tuple = await ProviderManager.serviceHandler!.syncItems();
    final unreadIds = tuple.item1;
    final starredIds = tuple.item2;
    final rows = await ProviderManager.db.query(
      CreateTableSql.items.tableName,
      columns: ["iid", "hasRead", "starred"],
      where: "hasRead = 0 OR starred = 1",
    );
    final batch = ProviderManager.db.batch();
    for (var row in rows) {
      final id = row["iid"];
      if (row["hasRead"] == 0 && !unreadIds.remove(id)) {
        await updateItem(id as String, read: true, batch: batch, local: true);
      }
      if (row["starred"] == 1 && !starredIds.remove(id)) {
        await updateItem(id as String,
            starred: false, batch: batch, local: true);
      }
    }
    for (var unread in unreadIds) {
      await updateItem(unread, read: false, batch: batch, local: true);
    }
    for (var starred in starredIds) {
      await updateItem(starred, starred: true, batch: batch, local: true);
    }
    notifyListeners();
    await batch.commit(noResult: true);
    // await ProviderManager.feedsProvider.updateUnreadCounts();
  }
}
