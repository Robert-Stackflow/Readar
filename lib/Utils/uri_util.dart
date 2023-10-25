import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UriUtil {
  static Uri emailUri(String email, {String subject = ""}) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    return Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': subject,
      }),
    );
  }

  static void launchEmailUri(String email, {String subject = ""}) {
    launchUrl(emailUri(email, subject: subject));
  }

  static void launchUrlUri(String url) async {
    if (!await launchUrl(Uri(path: url))) {
      Clipboard.setData(ClipboardData(text: url));
    }
  }
}
