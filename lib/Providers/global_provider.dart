import 'package:flutter/cupertino.dart';

import '../Models/nav_data.dart';
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

  List<NavData> _navData = HiveUtil.getNavData();

  List<NavData> get navData => _navData;

  set navData(List<NavData> value) {
    if (value != _navData) {
      _navData = value;
      notifyListeners();
      HiveUtil.setNavData(value);
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
