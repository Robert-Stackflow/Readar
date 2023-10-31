import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UriUtil {
  static Future<void> launchEmailUri(String email,
      {String subject = "", String body = ""}) async {
    if (!await launchUrl(
      Uri.parse("mailto:$email?subject=$subject&body=$body"),
      mode: LaunchMode.externalApplication,
    )) {
      Clipboard.setData(ClipboardData(text: email));
    }
  }

  static void launchUrlUri(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      Clipboard.setData(ClipboardData(text: url));
    }
  }
}
