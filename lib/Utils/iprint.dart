import 'package:flutter/foundation.dart';

class IPrint {
  static void debug(Object? text) {
    if (kDebugMode) {
      print(text);
    }
  }
}
