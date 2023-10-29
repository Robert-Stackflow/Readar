import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/rss_item.dart';
import 'global.dart';

class ItemsProvider with ChangeNotifier {
  final Map<String, RSSItem> _items = {};

  bool has(String id) => _items.containsKey(id);

  RSSItem getItem(String id) => _items[id]!;

  Iterable<RSSItem> getItems() => _items.values;

  void loadItems(Iterable<RSSItem> items) {
    for (var item in items) {
      _items[item.id] = item;
    }
  }

  Future<void> updateItem(
    String iid, {
    Batch? batch,
    bool? read,
    bool? starred,
    local = false,
  }) async {
    if (Global.serviceHandler == null) return;
    Map<String, dynamic> updateMap = {};
    if (_items.containsKey(iid)) {
      final item = _items[iid]!.clone();
      if (read != null) {
        item.hasRead = read;
        if (!local) {
          if (read) {
            Global.serviceHandler!.markRead(item);
          } else {
            Global.serviceHandler!.markUnread(item);
          }
        }
        Global.feedsProvider.updateUnreadCount(item.source, read ? -1 : 1);
      }
      if (starred != null) {
        item.starred = starred;
        if (!local) {
          if (starred) {
            Global.serviceHandler!.star(item);
          } else {
            Global.serviceHandler!.unstar(item);
          }
        }
      }
      _items[iid] = item;
    }
    if (read != null) updateMap["hasRead"] = read ? 1 : 0;
    if (starred != null) updateMap["starred"] = starred ? 1 : 0;
    if (batch != null) {
      batch.update("items", updateMap, where: "iid = ?", whereArgs: [iid]);
    } else {
      notifyListeners();
      await Global.db
          .update("items", updateMap, where: "iid = ?", whereArgs: [iid]);
    }
  }

  Future<void> markAllRead(
    Set<String> sids, {
    required DateTime date,
    before = true,
  }) async {
    if (Global.serviceHandler == null) return;

    Global.serviceHandler!.markAllRead(sids, date, before);
    List<String> predicates = ["hasRead = 0"];
    if (sids.isNotEmpty) {
      predicates
          .add("source IN (${List.filled(sids.length, "?").join(" , ")})");
    }
    predicates
        .add("date ${before ? "<=" : ">="} ${date.millisecondsSinceEpoch}");
    await Global.db.update(
      "items",
      {"hasRead": 1},
      where: predicates.join(" AND "),
      whereArgs: sids.toList(),
    );
    for (var item in _items.values.toList()) {
      if (sids.isNotEmpty && !sids.contains(item.source)) continue;
      if ((before
          ? item.date.compareTo(date) > 0
          : item.date.compareTo(date) < 0)) continue;
      item.hasRead = true;
    }
    notifyListeners();
    Global.feedsProvider.updateUnreadCounts();
  }

  Future<void> fetchItems() async {
    if (Global.serviceHandler == null) return;
    final items = await Global.serviceHandler!.fetchItems();
    final batch = Global.db.batch();
    for (var item in items) {
      if (!Global.feedsProvider.has(item.source)) continue;
      _items[item.id] = item;
      batch.insert(
        "items",
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
    // notifyListeners();
    Global.feedsProvider.updateWithFetchedItems(items);
    Global.feedContentProvider.addFetchedItems(items);
  }

  Future<void> syncItems() async {
    if (Global.serviceHandler == null) return;
    final tuple = await Global.serviceHandler!.syncItems();
    final unreadIds = tuple.item1;
    final starredIds = tuple.item2;
    final rows = await Global.db.query(
      "items",
      columns: ["iid", "hasRead", "starred"],
      where: "hasRead = 0 OR starred = 1",
    );
    final batch = Global.db.batch();
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
    await Global.feedsProvider.updateUnreadCounts();
  }
}
