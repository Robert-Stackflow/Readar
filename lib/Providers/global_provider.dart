import 'package:flutter/cupertino.dart';

import '../Utils/hive_util.dart';

enum ActiveTheme {
  system,
  light,
  dark,
}

class GlobalProvider with ChangeNotifier {
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
}
