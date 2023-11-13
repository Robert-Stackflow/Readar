import 'package:flutter/cupertino.dart';

import 'global.dart';

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
          Global.feedsProvider.getSources().map<String>((s) => s.sid));
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
