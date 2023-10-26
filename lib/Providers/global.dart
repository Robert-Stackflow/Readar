import 'package:flutter/cupertino.dart';

import 'global_provider.dart';

abstract class Global {
  static bool _initialized = false;
  static GlobalProvider? globalProvider;

  static void init() {
    assert(!_initialized);
    _initialized = true;
    globalProvider = GlobalProvider();
  }

  static Brightness currentBrightness(BuildContext context) {
    return globalProvider?.getBrightness() ??
        MediaQuery.of(context).platformBrightness;
  }
}
