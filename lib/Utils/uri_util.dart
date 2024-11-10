import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:readar/Screens/Navigation/webview_screen.dart';
import 'package:readar/Utils/hive_util.dart';
import 'package:readar/Utils/itoast.dart';
import 'package:readar/Utils/request_util.dart';
import 'package:readar/Utils/responsive_util.dart';
import 'package:readar/Utils/route_util.dart';
import 'package:readar/Utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/Dialog/custom_dialog.dart';
import '../generated/l10n.dart';
import 'ilogger.dart';

class UriUtil {
  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<bool> launchEmailUri(BuildContext context, String email,
      {String subject = "", String body = ""}) async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        query: encodeQueryParameters(<String, String>{
          'subject': subject,
          'body': body,
        }),
      );
      if (!await launchUrl(
        emailLaunchUri,
        mode: LaunchMode.externalApplication,
      )) {
        if (ResponsiveUtil.isIOS()) {
          IToast.showTop(S.current.noEmailClient);
        }
        Clipboard.setData(ClipboardData(text: email));
      }
    } catch (e, t) {
      ILogger.error("Failed to launch email app", e, t);
      IToast.showTop(S.current.noEmailClient);
    }
    return true;
  }

  static share(BuildContext context, String str) {
    Share.share(str).then((shareResult) {
      if (shareResult.status == ShareResultStatus.success) {
        IToast.showTop(S.current.shareSuccess);
      } else if (shareResult.status == ShareResultStatus.dismissed) {
        IToast.showTop(S.current.cancelShare);
      } else {
        IToast.showTop(S.current.shareFailed);
      }
    });
  }

  static void launchUrlUri(BuildContext context, String url) async {
    if (HiveUtil.getBool(HiveUtil.inappWebviewKey)) {
      openInternal(context, url);
    } else {
      openExternal(url);
    }
    // if (!await launchUrl(Uri.parse(url),
    //     mode: LaunchMode.externalApplication)) {
    //   Clipboard.setData(ClipboardData(text: url));
    // }
  }

  static Future<bool> canLaunchUri(Uri uri) async {
    return await canLaunchUrl(uri);
  }

  static void launchUri(Uri uri) async {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<dynamic> getRedirectUrl(String url) async {
    Response? res = await RequestUtil.get(
      url,
      options: Options(
        headers: {
          "Connection": "keep-alive",
          "Referer": url,
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36 Edg/130.0.0.0",
        },
      ),
    );
    if(res!=null){
      ILogger.info("Get Redirects: ${res.redirects}");
      if (res.redirects.isNotEmpty) {
        List<String> redirects =
        res.redirects.map((e) => e.location.toString()).toList();
        redirects = redirects.where((e) => !e.contains("front/login")).toList();
        if (redirects.isNotEmpty) url = redirects.last;
      } else {
        url = res.realUri.toString();
      }
    }
    return url;
  }

  static Future<bool> processUrl(
    BuildContext context,
    String url, {
    bool pass = true,
    bool quiet = false,
  }) async {
    try {
      if (!quiet) CustomLoadingDialog.showLoading(title: S.current.loading);
      url = Uri.decodeComponent(url);
      if (url=="canparse") {
        if (!quiet) await CustomLoadingDialog.dismissLoading();
        return false;
      } else {
        if (!quiet) await CustomLoadingDialog.dismissLoading();
        if (!quiet) {
          if (pass) {
            if (HiveUtil.getBool(HiveUtil.inappWebviewKey,
                defaultValue: true)) {
              UriUtil.openInternal(context, url);
            } else {
              UriUtil.openExternal(url);
            }
          } else {
            IToast.showTop("不支持的URI：$url");
            ILogger.info("不支持的URI：$url");
          }
        }
        return false;
      }
    } catch (e, t) {
      ILogger.error("Failed to resolve url $url", e, t);
      if (!quiet) await CustomLoadingDialog.dismissLoading();
      if (!quiet) Share.share(url);
      return false;
    }
  }

  static void openInternal(
    BuildContext context,
    String url, {
    bool processUri = true,
  }) {
    if (ResponsiveUtil.isMobile()) {
      RouteUtil.pushPanelCupertinoRoute(
          context, WebviewScreen(url: url, processUri: processUri));
    } else {
      openExternal(url);
    }
  }

  static Future<void> openExternal(String url) async {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
    );
  }

  static Future<void> openExternalUri(WebUri uri) async {
    await launchUrl(
      uri,
      mode: LaunchMode.externalNonBrowserApplication,
    );
  }

  static String getPostUrlByPermalink(String blogName, String permalink) {
    return "https://$blogName.lofter.com/post/$permalink";
  }

  static String getPostUrlById(String blogName, int postId, int blogId) {
    return "https://$blogName.lofter.com/post/${Utils.intToHex(blogId)}_${Utils.intToHex(postId)}";
  }

  static String getTagUrlByTagName(String tagName, {bool isNew = true}) {
    return "https://www.lofter.com/${isNew ? "front/blog/" : ""}tag/$tagName";
  }

  static String getCollectionUrlByCollectionInfo(
      String blogName, int collectionId) {
    return "https://www.lofter.com/collection/$blogName?op=collectionDetail&collectionId=$collectionId";
  }
}
