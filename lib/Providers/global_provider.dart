import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

import '../Models/nav_entry.dart';
import '../Utils/hive_util.dart';
import '../generated/l10n.dart';

enum ActiveThemeMode {
  system,
  light,
  dark,
}

class GlobalProvider with ChangeNotifier {
  Widget? _singlePage;

  Widget? get singlePage => _singlePage;

  set singlePage(Widget? value) {
    if (value != _singlePage) {
      _singlePage = value;
      notifyListeners();
    }
  }

  bool _showNavigationBar = HiveUtil.showNavigationBar();

  bool get showNavigationBar => _showNavigationBar;

  set showNavigationBar(bool value) {
    if (value != _showNavigationBar) {
      _showNavigationBar = value;
      notifyListeners();
      HiveUtil.setShowNavigationBar(value);
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
      case ActiveThemeMode.dark:
        return S.current.darkTheme;
      case ActiveThemeMode.light:
        return S.current.lightTheme;
    }
  }

  static List<Tuple2<String, ActiveThemeMode>> getSupportedThemeMode() {
    return [
      Tuple2(S.current.followSystem, ActiveThemeMode.system),
      Tuple2(S.current.lightTheme, ActiveThemeMode.light),
      Tuple2(S.current.darkTheme, ActiveThemeMode.dark),
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
