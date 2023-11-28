import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../Models/nav_entry.dart';
import '../Utils/hive_util.dart';
import '../Widgets/Scaffold/my_scaffold.dart';
import '../generated/l10n.dart';

enum ActiveThemeMode {
  system,
  light,
  dark,
}

class GlobalProvider with ChangeNotifier {
  GlobalKey<MyScaffoldState> homeScaffoldKey = GlobalKey();

  ThemeData _lightTheme = HiveUtil.getLightTheme().toThemeData();

  ThemeData get lightTheme => _lightTheme;

  setLightTheme(int index) {
    HiveUtil.setLightTheme(index);
    _lightTheme = HiveUtil.getLightTheme().toThemeData();
    notifyListeners();
  }

  ThemeData _darkTheme = HiveUtil.getDarkTheme().toThemeData();

  ThemeData get darkTheme => _darkTheme;

  setDarkTheme(int index) {
    HiveUtil.setDarkTheme(index);
    _darkTheme = HiveUtil.getDarkTheme().toThemeData();
    notifyListeners();
  }

  bool _isDrawerOpen = false;

  bool get isDrawerOpen => _isDrawerOpen;

  set isDrawerOpen(bool value) {
    if (value != _isDrawerOpen) {
      _isDrawerOpen = value;
      notifyListeners();
    }
  }

  List<NavEntry> _navEntries = HiveUtil.getNavEntries();

  List<NavEntry> get navEntries => _navEntries;

  set navEntries(List<NavEntry> value) {
    if (value != _navEntries) {
      _navEntries = value;
      notifyListeners();
      HiveUtil.setNavEntries(value);
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

  ActiveThemeMode _themeMode = HiveUtil.getThemeMode();

  ActiveThemeMode get themeMode => _themeMode;

  set themeMode(ActiveThemeMode value) {
    if (value != _themeMode) {
      _themeMode = value;
      notifyListeners();
      HiveUtil.setThemeMode(value);
    }
  }

  static String getThemeModeLabel(ActiveThemeMode themeMode) {
    switch (themeMode) {
      case ActiveThemeMode.system:
        return S.current.followSystem;
      case ActiveThemeMode.light:
        return S.current.lightTheme;
      case ActiveThemeMode.dark:
        return S.current.darkTheme;
    }
  }

  static List<Tuple2<String, ActiveThemeMode>> getSupportedThemeMode() {
    return [
      Tuple2(S.current.followSystem, ActiveThemeMode.system),
      Tuple2(S.current.lightTheme, ActiveThemeMode.light),
      Tuple2(S.current.darkTheme, ActiveThemeMode.dark),
    ];
  }

  int _autoLockTime = HiveUtil.getInt(key: HiveUtil.autoLockTimeKey);

  int get autoLockTime => _autoLockTime;

  set autoLockTime(int value) {
    if (value != _autoLockTime) {
      _autoLockTime = value;
      notifyListeners();
      HiveUtil.put(key: HiveUtil.autoLockTimeKey, value: value);
    }
  }

  static String getAutoLockOptionLabel(int time) {
    if (time == 0)
      return "立即锁定";
    else
      return "处于后台$time分钟后锁定";
  }

  static List<Tuple2<String, int>> getAutoLockOptions() {
    return [
      Tuple2("立即锁定", 0),
      Tuple2("处于后台1分钟后锁定", 1),
      Tuple2("处于后台5分钟后锁定", 5),
      Tuple2("处于后台10分钟后锁定", 10),
    ];
  }

  Brightness? getBrightness() {
    if (_themeMode == ActiveThemeMode.system) {
      return null;
    } else {
      return _themeMode == ActiveThemeMode.light
          ? Brightness.light
          : Brightness.dark;
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
