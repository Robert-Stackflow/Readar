import 'package:flutter/foundation.dart';

class IPrint {
  static void debug(String? text) {
    if (kDebugMode) {
      print(text);
    }
  }
}
