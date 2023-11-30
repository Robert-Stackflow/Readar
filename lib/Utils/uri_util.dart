import 'package:readar/Utils/itoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UriUtil {
  static Future<bool> launchEmailUri(BuildContext context, String email,
      {String subject = "", String body = ""}) async {
    try {
      if (!await launchUrl(
        Uri.parse("mailto:$email?subject=$subject&body=$body"),
        mode: LaunchMode.externalApplication,
      )) {
        Clipboard.setData(ClipboardData(text: email));
      }
    } on PlatformException catch (_) {
      IToast.showTop(context, text: "尚未安装邮箱程序，已复制Email地址到剪贴板");
    }
    return true;
  }

  static void launchUrlUri(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      Clipboard.setData(ClipboardData(text: url));
    }
  }
}
