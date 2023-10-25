import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:cloudreader/Utils/uri_util.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Widgets/item_builder.dart';

class AboutSettingScreen extends StatefulWidget {
  const AboutSettingScreen({super.key});

  static const String routeName = "/setting/about";

  @override
  State<AboutSettingScreen> createState() => _AboutSettingScreenState();
}

class _AboutSettingScreenState extends State<AboutSettingScreen>
    with TickerProviderStateMixin {
  int count = 0;
  late String appName = "";

  _launchUrl(String url) async {
    IToast.showTop(context, text: "缺少跳转权限,链接已复制至剪切板");
    if (!await launchUrl(Uri(path: url))) {
      Clipboard.setData(ClipboardData(text: url));
    }
  }

  @override
  void initState() {
    super.initState();
    getAppInfo();
  }

  void getAppInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appName = packageInfo.appName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.close_rounded,
              color: AppTheme.darkerText,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppTheme.background,
        ),
        body: ScrollConfiguration(
          behavior: NoShadowScrollBehavior(),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/screenshots/dog.png',
                  fit: BoxFit.fitHeight,
                  width: MediaQuery.of(context).size.width / 4,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  appName,
                  style: const TextStyle(
                    fontSize: 17,
                    color: AppTheme.darkerText,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(10),
                child: ScrollConfiguration(
                  behavior: NoShadowScrollBehavior(),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      ItemBuilder.buildEntryItem(
                        title: "贡献者",
                        topRadius: true,
                        showIcon: true,
                        onTap: () {},
                        leading: Icons.supervised_user_circle_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: "更新日志",
                        showIcon: true,
                        onTap: () {},
                        leading: Icons.merge_type_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: "参与翻译",
                        onTap: () {},
                        showIcon: true,
                        leading: Icons.translate_rounded,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: "Github仓库",
                        onTap: () {
                          _launchUrl(
                              "https://github.com/Robert-Stackflow/CloudReader");
                        },
                        showIcon: true,
                        leading: Icons.commit_rounded,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: "开源许可证",
                        showIcon: true,
                        onTap: () {},
                        bottomRadius: true,
                        leading: Icons.local_library_outlined,
                      ),
                      const SizedBox(height: 10),
                      ItemBuilder.buildEntryItem(
                        title: "隐私政策",
                        showIcon: true,
                        onTap: () {},
                        topRadius: true,
                        leading: Icons.group_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: "评个分吧",
                        showIcon: true,
                        onTap: () {},
                        leading: Icons.rate_review_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: "联系我们",
                        onTap: () {
                          UriUtil.launchEmailUri("2014027378@qq.com");
                        },
                        showIcon: true,
                        tip: "2014027378@qq.com",
                        leading: Icons.contact_support_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: "官方网站",
                        onTap: () {
                          _launchUrl("https://rssreader.cloudchewie.com");
                        },
                        showIcon: true,
                        tip: "https://rssreader.cloudchewie.com",
                        leading: Icons.language_rounded,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: "Telegram频道",
                        onTap: () {
                          _launchUrl("https://t.me/CloudReader");
                        },
                        bottomRadius: true,
                        showIcon: true,
                        tip: "https://t.me/CloudReader",
                        leading: Icons.telegram_outlined,
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
