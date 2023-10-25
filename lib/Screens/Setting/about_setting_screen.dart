import 'package:cloudreader/Utils/theme.dart';
import 'package:cloudreader/Utils/uri_util.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../Widgets/item_builder.dart';
import '../../generated/l10n.dart';

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
        appBar: ItemBuilder.buildAppBar(leading: Icons.close_rounded),
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
                        title: S.current.contributor,
                        topRadius: true,
                        showIcon: true,
                        onTap: () {},
                        leading: Icons.supervised_user_circle_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: S.current.changeLog,
                        showIcon: true,
                        onTap: () {},
                        leading: Icons.merge_type_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: S.current.participateInTranslation,
                        onTap: () {},
                        showIcon: true,
                        leading: Icons.translate_rounded,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: S.current.bugReport,
                        onTap: () {},
                        showIcon: true,
                        leading: Icons.bug_report_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: S.current.githubRepo,
                        onTap: () {
                          UriUtil.launchUrlUri(
                              "https://github.com/Robert-Stackflow/CloudReader");
                        },
                        showIcon: true,
                        leading: Icons.commit_rounded,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: S.current.license,
                        showIcon: true,
                        onTap: () {},
                        bottomRadius: true,
                        leading: Icons.local_library_outlined,
                      ),
                      const SizedBox(height: 10),
                      ItemBuilder.buildEntryItem(
                        title: S.current.privacyPolicy,
                        showIcon: true,
                        onTap: () {},
                        topRadius: true,
                        leading: Icons.group_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: S.current.rate,
                        showIcon: true,
                        onTap: () {},
                        leading: Icons.rate_review_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: S.current.contact,
                        onTap: () {
                          UriUtil.launchEmailUri("2014027378@qq.com");
                        },
                        showIcon: true,
                        leading: Icons.contact_support_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: S.current.officialWebsite,
                        onTap: () {
                          UriUtil.launchUrlUri(
                              "https://rssreader.cloudchewie.com");
                        },
                        showIcon: true,
                        leading: Icons.language_rounded,
                      ),
                      ItemBuilder.buildEntryItem(
                        title: S.current.telegramGroup,
                        onTap: () {
                          UriUtil.launchUrlUri("https://t.me/CloudReader");
                        },
                        bottomRadius: true,
                        showIcon: true,
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
