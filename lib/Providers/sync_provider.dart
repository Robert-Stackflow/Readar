// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';

import 'provider_manager.dart';

class SyncProvider with ChangeNotifier {
  bool hasService = ProviderManager.serviceHandler != null;
  bool syncing = false;
  bool _lastSyncSuccess = true;
  DateTime _lastSyncedTime = DateTime.fromMillisecondsSinceEpoch(0);

  void checkHasService() {
    var value = ProviderManager.serviceHandler != null;
    if (value != hasService) {
      hasService = value;
      notifyListeners();
    }
  }

  Future<void> removeService() async {
    if (syncing || ProviderManager.serviceHandler == null) return;
    syncing = true;
    notifyListeners();
    var sids =
        ProviderManager.feedsProvider.getFeeds().map((s) => s.sid).toList();
    await ProviderManager.feedsProvider.removeSources(sids);
    ProviderManager.serviceHandler?.removeService();
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
    if (syncing || ProviderManager.serviceHandler == null) return;
    syncing = true;
    notifyListeners();
    try {
      await ProviderManager.serviceHandler?.authenticate();
      await ProviderManager.feedsProvider.updateSources();
      await ProviderManager.itemsProvider.syncItems();
      await ProviderManager.itemsProvider.fetchItems();
      lastSyncSuccess = true;
    } catch (exp) {
      lastSyncSuccess = false;
    }
    lastSyncedTime = DateTime.now();
    syncing = false;
    notifyListeners();
  }
}
