import 'package:cloudreader/Configs/hive_config.dart';
import 'package:flutter/foundation.dart';

enum ActiveTheme {
  light,
  dark,
}

class ThemeProvider extends ChangeNotifier {
  ActiveTheme _theme;

  ThemeProvider(this._theme);

  static Future<ActiveTheme> getPreferredTheme() async {
    try {
      return HiveConfig.getBool(
              key: HiveConfig.darkThemeKey, defaultValue: false)
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
    HiveConfig.put(
        key: HiveConfig.darkThemeKey, value: _theme == ActiveTheme.dark);
  }
}
