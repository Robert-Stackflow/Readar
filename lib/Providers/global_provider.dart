import 'package:flutter/cupertino.dart';

import '../Utils/hive_util.dart';

enum ActiveTheme {
  system,
  light,
  dark,
}

class GlobalProvider with ChangeNotifier {
  bool _showNavigationBar = HiveUtil.showNavigationBar();

  bool get showNavigationBar => _showNavigationBar;

  set showNavigationBar(bool value) {
    if (value != _showNavigationBar) {
      _showNavigationBar = value;
      notifyListeners();
      HiveUtil.setShowNavigationBar(value);
    }
  }

  bool _starNavigationVisible = HiveUtil.starNavigationVisible();

  bool get starNavigationVisible => _starNavigationVisible;

  set starNavigationVisible(bool value) {
    if (value != _starNavigationVisible) {
      _starNavigationVisible = value;
      notifyListeners();
      HiveUtil.setStarNavigationVisible(value);
    }
  }

  bool _readLaterNavigationVisible = HiveUtil.readLaterNavigationVisible();

  bool get readLaterNavigationVisible => _readLaterNavigationVisible;

  set readLaterNavigationVisible(bool value) {
    if (value != _readLaterNavigationVisible) {
      _readLaterNavigationVisible = value;
      notifyListeners();
      HiveUtil.setReadLaterNavigationVisible(value);
    }
  }

  Locale? _locale = HiveUtil.getLocale();

  Locale? get locale => _locale;

  set locale(Locale? value) {
    if (value != _locale) {
      _locale = value;
      notifyListeners();
      HiveUtil.setLocale(value);
    }
  }

  String? _homeRoute;

  String? get homeRoute => _homeRoute;

  set homeRoute(String? value) {
    if (value != _homeRoute) {
      _homeRoute = value;
      notifyListeners();
    }
  }

  ActiveTheme _theme = HiveUtil.getTheme();

  ActiveTheme get theme => _theme;

  set theme(ActiveTheme newTheme) {
    if (newTheme != _theme) {
      _theme = newTheme;
      notifyListeners();
      HiveUtil.setTheme(theme);
    }
  }

  Brightness? getBrightness() {
    if (_theme == ActiveTheme.system) {
      return null;
    } else {
      return _theme == ActiveTheme.light ? Brightness.light : Brightness.dark;
    }
  }

  int _keepItemsDays = 21;

  int get keepItemsDays => _keepItemsDays;

  set keepItemsDays(int value) {
    _keepItemsDays = value;
  }

  bool _syncOnStart = true;

  bool get syncOnStart => _syncOnStart;

  set syncOnStart(bool value) {
    _syncOnStart = value;
  }
}
