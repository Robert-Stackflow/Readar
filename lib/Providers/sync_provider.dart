// ignore_for_file: unnecessary_getters_setters

import 'package:cloudreader/Utils/iprint.dart';
import 'package:flutter/cupertino.dart';

import 'global.dart';

class SyncProvider with ChangeNotifier {
  bool hasService = Global.serviceHandler != null;
  bool syncing = false;
  bool _lastSyncSuccess = true;
  DateTime _lastSyncedTime = DateTime.fromMillisecondsSinceEpoch(0);

  void checkHasService() {
    var value = Global.serviceHandler != null;
    if (value != hasService) {
      hasService = value;
      notifyListeners();
    }
  }

  Future<void> removeService() async {
    if (syncing || Global.serviceHandler == null) return;
    syncing = true;
    notifyListeners();
    var sids = Global.feedsProvider.getSources().map((s) => s.id).toList();
    await Global.feedsProvider.removeSources(sids);
    Global.serviceHandler?.remove();
    hasService = false;
    syncing = false;
    notifyListeners();
  }

  bool get lastSyncSuccess => _lastSyncSuccess;

  set lastSyncSuccess(bool value) {
    _lastSyncSuccess = value;
  }

  DateTime get lastSyncedTime => _lastSyncedTime;

  set lastSyncedTime(DateTime value) {
    _lastSyncedTime = value;
  }

  Future<void> syncWithService() async {
    if (syncing || Global.serviceHandler == null) return;
    syncing = true;
    notifyListeners();
    try {
      await Global.serviceHandler?.reauthenticate();
      IPrint.debug("authed");
      await Global.feedsProvider.updateSources();
      IPrint.debug("updated");
      await Global.itemsProvider.syncItems();
      IPrint.debug("synced");
      await Global.itemsProvider.fetchItems();
      IPrint.debug("fetched");
      lastSyncSuccess = true;
    } catch (exp) {
      lastSyncSuccess = false;
    }
    lastSyncedTime = DateTime.now();
    syncing = false;
    notifyListeners();
  }
}
