import 'package:flutter/cupertino.dart';

import 'provider_manager.dart';

class GroupsProvider with ChangeNotifier {
  Map<String, List<String>> _groups = {};
  List<String>? uncategorized = [];

  Map<String, List<String>> get groups => _groups;

  set groups(Map<String, List<String>> groups) {
    _groups = groups;
    updateUncategorized();
    notifyListeners();
  }

  void updateUncategorized({force = false}) {
    if (uncategorized != null || force) {
      final sids = Set<String>.from(
          ProviderManager.feedsProvider.getFeeds().map<String>((s) => s.fid));
      for (var group in _groups.values) {
        for (var sid in group) {
          sids.remove(sid);
        }
      }
      uncategorized = sids.toList();
    }
  }

  bool get showUncategorized => uncategorized != null;

  set showUncategorized(bool value) {
    if (showUncategorized != value) {
      if (value) {
        updateUncategorized(force: true);
      } else {
        uncategorized = null;
      }
      notifyListeners();
    }
  }
}
