import 'package:cloudreader/Utils/iprint.dart';
import 'package:flutter/services.dart';

class AndroidBackDesktop {
  static const String channel = "android/back/desktop";
  static const String eventBackDesktop = "backDesktop";

  static Future<bool> backToDesktop() async {
    const platform = MethodChannel(channel);
    try {
      await platform.invokeMethod(eventBackDesktop);
    } on PlatformException catch (e) {
      IPrint.debug("通信失败，设置回退到安卓手机桌面失败");
      IPrint.debug(e.toString());
    }
    return Future.value(false);
  }
}
