import 'package:flutter/foundation.dart';

import '../Utils/hive_util.dart';

enum ActiveTheme {
  light,
  dark,
}

class ThemeProvider extends ChangeNotifier {
  ActiveTheme _theme;

  ThemeProvider(this._theme);

  static Future<ActiveTheme> getPreferredTheme() async {
    try {
      return HiveUtil.getBool(key: HiveUtil.darkThemeKey, defaultValue: false)
          ? ActiveTheme.dark
          : ActiveTheme.light;
    } catch (_) {
      return ActiveTheme.light;
    }
  }

  ActiveTheme get theme => _theme;

  set theme(ActiveTheme theme) {
    _theme = theme;
    notifyListeners();
    HiveUtil.put(key: HiveUtil.darkThemeKey, value: _theme == ActiveTheme.dark);
  }
}
