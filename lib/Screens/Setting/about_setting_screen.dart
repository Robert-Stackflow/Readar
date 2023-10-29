import 'package:cloudreader/Utils/uri_util.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../Widgets/Item/item_builder.dart';
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
        appBar: ItemBuilder.buildAppBar(
            leading: Icons.close_rounded, context: context),
        body: ScrollConfiguration(
          behavior: NoShadowScrollBehavior(),
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/logo.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 8),
                alignment: Alignment.center,
                child: Text(
                  appName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
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
                        context: context,
                        title: S.current.contributor,
                        topRadius: true,
                        showLeading: true,
                        onTap: () {},
                        leading: Icons.supervised_user_circle_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        context: context,
                        title: S.current.changeLog,
                        showLeading: true,
                        onTap: () {},
                        leading: Icons.merge_type_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        context: context,
                        title: S.current.participateInTranslation,
                        onTap: () {},
                        showLeading: true,
                        leading: Icons.translate_rounded,
                      ),
                      ItemBuilder.buildEntryItem(
                        context: context,
                        title: S.current.bugReport,
                        onTap: () {},
                        showLeading: true,
                        leading: Icons.bug_report_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        context: context,
                        title: S.current.license,
                        showLeading: true,
                        onTap: () {},
                        leading: Icons.local_library_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        context: context,
                        title: S.current.githubRepo,
                        onTap: () {
                          UriUtil.launchUrlUri(
                              "https://github.com/Robert-Stackflow/CloudReader");
                        },
                        showLeading: true,
                        bottomRadius: true,
                        leading: Icons.commit_rounded,
                      ),
                      const SizedBox(height: 10),
                      ItemBuilder.buildEntryItem(
                        context: context,
                        title: S.current.privacyPolicy,
                        showLeading: true,
                        onTap: () {},
                        topRadius: true,
                        leading: Icons.group_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        context: context,
                        title: S.current.rate,
                        showLeading: true,
                        onTap: () {},
                        leading: Icons.rate_review_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        context: context,
                        title: S.current.contact,
                        onTap: () {
                          UriUtil.launchEmailUri("2014027378@qq.com");
                        },
                        showLeading: true,
                        leading: Icons.contact_support_outlined,
                      ),
                      ItemBuilder.buildEntryItem(
                        context: context,
                        title: S.current.officialWebsite,
                        onTap: () {
                          UriUtil.launchUrlUri(
                              "https://rssreader.cloudchewie.com");
                        },
                        showLeading: true,
                        leading: Icons.language_rounded,
                      ),
                      ItemBuilder.buildEntryItem(
                        context: context,
                        title: S.current.telegramGroup,
                        onTap: () {
                          UriUtil.launchUrlUri("https://t.me/CloudReader");
                        },
                        bottomRadius: true,
                        showLeading: true,
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
