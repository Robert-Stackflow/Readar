import 'dart:async';

import 'package:cloudreader/Models/auto_lock.dart';
import 'package:cloudreader/Screens/Setting/about_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/appearance_setting_scrren.dart';
import 'package:cloudreader/Screens/Setting/backup_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/experiment_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/extension_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/general_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/privacy_setting_screen.dart';
import 'package:cloudreader/Utils/theme.dart';
import 'package:cloudreader/Utils/uri_util.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

import '../Utils/hive_util.dart';
import '../Widgets/item_builder.dart';
import '../generated/l10n.dart';
import 'Lock/pin_verify_screen.dart';
import 'Navigation/home_screen.dart';
import 'Navigation/read_later_screen.dart';
import 'Navigation/star_screen.dart';
import 'Navigation/subscription_screen.dart';

GlobalKey<MainScreenState> drawerKey = GlobalKey();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = "/";

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  List<Widget> _pageList = [];
  List<BottomNavigationBarItem> _navigationBarItemList = [];
  Timer? _timer;
  int selectedIndex = 0;
  bool _isInVerify = false;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (HiveUtil.getBool(key: HiveUtil.safeModeKey, defaultValue: false)) {
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } else {
      FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (HiveUtil.getBool(key: HiveUtil.lockEnableKey) &&
          HiveUtil.getString(key: HiveUtil.lockPinKey)!.isNotEmpty &&
          HiveUtil.getBool(key: HiveUtil.autoLockKey) &&
          !_isInVerify) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinVerifyScreen(
              onSuccess: () {
                _isInVerify = false;
              },
              isModal: true,
            ),
          ),
        );
        _isInVerify = true;
      }
      S.load(Locale(HiveUtil.getString(key: HiveUtil.languageKey) ?? "en"));
      initData();
    });
    initData();
  }

  void initData() {
    setState(() {
      _navigationBarItemList = [
        BottomNavigationBarItem(
          icon: const Icon(Icons.feed_outlined),
          label: S.current.article,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.rss_feed_rounded),
          label: S.current.feed,
        ),
      ];
      _pageList = [
        const HomeScreen(),
        const FeedScreen(),
      ];
      if (HiveUtil.getBool(
          key: HiveUtil.starNavigationKey, defaultValue: true)) {
        _navigationBarItemList.add(
          BottomNavigationBarItem(
            icon: const Icon(Icons.star_outline_rounded),
            label: S.current.star,
          ),
        );
        _pageList.add(const StarScreen());
      }
      if (HiveUtil.getBool(
          key: HiveUtil.readLaterNavigationKey, defaultValue: true)) {
        _navigationBarItemList.add(
          BottomNavigationBarItem(
            icon: const Icon(Icons.checklist_rounded),
            label: S.current.readLater,
          ),
        );
        _pageList.add(const ReadLaterScreen());
      }
    });
  }

  void onBottomNavigationBarItemTap(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
          items: _navigationBarItemList,
          currentIndex: selectedIndex,
          fixedColor: AppTheme.themeColor,
          type: BottomNavigationBarType.fixed,
          onTap: onBottomNavigationBarItemTap, //
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pageList,
        ),
        drawer: _drawer(),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        if (_timer != null) {
          _timer!.cancel();
        }
        break;
      case AppLifecycleState.paused:
        _timer = Timer(
            Duration(
                minutes: AutoLock
                    .autoLockOptions[
                        HiveUtil.getInt(key: HiveUtil.autoLockTimeKey)]
                    .minutes), () {
          if (HiveUtil.getBool(key: HiveUtil.lockEnableKey) &&
              HiveUtil.getString(key: HiveUtil.lockPinKey)!.isNotEmpty &&
              HiveUtil.getBool(key: HiveUtil.autoLockKey) &&
              !_isInVerify) {
            _isInVerify = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PinVerifyScreen(
                  onSuccess: () {
                    _isInVerify = false;
                  },
                  isModal: true,
                ),
              ),
            );
          }
        });
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _drawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      elevation: 0.0,
      backgroundColor: AppTheme.background,
      child: ScrollConfiguration(
        behavior: NoShadowScrollBehavior(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 500, minWidth: 50),
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ScrollConfiguration(
                    behavior: NoShadowScrollBehavior(),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        ItemBuilder.buildEntryItem(
                          title: S.current.highlights,
                          topRadius: true,
                          onTap: () {},
                          showIcon: true,
                          leading: Icons.bookmark_border_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.tags,
                          showIcon: true,
                          onTap: () {},
                          leading: Icons.tag_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          showIcon: true,
                          title: S.current.statistics,
                          onTap: () {},
                          leading: Icons.show_chart_rounded,
                        ),
                        Visibility(
                          visible: !HiveUtil.getBool(
                              key: HiveUtil.starNavigationKey,
                              defaultValue: true),
                          child: ItemBuilder.buildEntryItem(
                            title: S.current.star,
                            showIcon: true,
                            onTap: () {},
                            leading: Icons.star_border_rounded,
                          ),
                        ),
                        Visibility(
                          visible: !HiveUtil.getBool(
                              key: HiveUtil.readLaterNavigationKey,
                              defaultValue: true),
                          child: ItemBuilder.buildEntryItem(
                            title: S.current.readLater,
                            showIcon: true,
                            onTap: () {},
                            leading: Icons.checklist_rounded,
                          ),
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.feedHub,
                          onTap: () {},
                          bottomRadius: true,
                          showIcon: true,
                          leading: Icons.add_chart_rounded,
                        ),
                        const SizedBox(height: 10),
                        ItemBuilder.buildEntryItem(
                          title: S.current.generalSetting,
                          topRadius: true,
                          showIcon: true,
                          onTap: () {
                            Get.toNamed(GeneralSettingScreen.routeName);
                          },
                          leading: Icons.settings_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          showIcon: true,
                          title: S.current.apprearanceSetting,
                          onTap: () {
                            Get.toNamed(AppearanceSettingScreen.routeName);
                          },
                          leading: Icons.color_lens_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.extensionSetting,
                          showIcon: true,
                          onTap: () {
                            Get.toNamed(ExtensionSettingScreen.routeName);
                          },
                          leading: Icons.extension_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.backupSetting,
                          showIcon: true,
                          onTap: () {
                            Get.toNamed(BackupSettingScreen.routeName);
                          },
                          leading: Icons.backup_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          showIcon: true,
                          title: S.current.privacySetting,
                          onTap: () {
                            Get.toNamed(PrivacySettingScreen.routeName);
                          },
                          leading: Icons.privacy_tip_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          showIcon: true,
                          title: S.current.experimentSetting,
                          onTap: () {
                            Get.toNamed(ExperimentSettingScreen.routeName);
                          },
                          bottomRadius: true,
                          leading: Icons.outlined_flag_rounded,
                        ),
                        const SizedBox(height: 10),
                        ItemBuilder.buildEntryItem(
                          title: S.current.help,
                          topRadius: true,
                          showIcon: true,
                          onTap: () {
                            UriUtil.launchUrlUri(
                                "https://rssreader.cloudchewie.com/help");
                          },
                          leading: Icons.help_outline_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.about,
                          bottomRadius: true,
                          showIcon: true,
                          onTap: () {
                            Navigator.pushNamed(
                                context, AboutSettingScreen.routeName);
                          },
                          leading: Icons.info_outline_rounded,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
