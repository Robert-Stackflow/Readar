import 'dart:async';

import 'package:cloudreader/Models/auto_lock.dart';
import 'package:cloudreader/Screens/Setting/about_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/appearance_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/backup_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/experiment_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/extension_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/general_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/privacy_setting_screen.dart';
import 'package:cloudreader/Utils/theme.dart';
import 'package:cloudreader/Utils/uri_util.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Providers/global.dart';
import '../Utils/hive_util.dart';
import '../Widgets/Item/item_builder.dart';
import '../generated/l10n.dart';
import 'Lock/pin_verify_screen.dart';
import 'Navigation/article_screen.dart';
import 'Navigation/read_later_screen.dart';
import 'Navigation/star_screen.dart';
import 'Navigation/subscription_screen.dart';
import 'Setting/operation_setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = "/";

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  List<Widget> _pageList = [];
  List<SalomonBottomBarItem> _navigationBarItemList = [];
  Timer? _timer;
  int selectedIndex = 0;
  bool _isInVerify = false;
  final _pageController = PageController();
  final _homeScreen = const ArticleScreen();
  final _feedScreen = const FeedScreen();
  final _starScreen = const StarScreen();
  final _readLaterScreen = const ReadLaterScreen();

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
      initData();
    });
    Global.globalProvider.addListener(() {
      initData();
    });
  }

  void initData() {
    setState(() {
      _navigationBarItemList = [
        SalomonBottomBarItem(
          icon: const Icon(Icons.feed_outlined),
          title: Text(S.current.article),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.rss_feed_rounded),
          title: Text(S.current.feed),
        ),
      ];
      _pageList = [
        _homeScreen,
        _feedScreen,
      ];
      if (HiveUtil.starNavigationVisible()) {
        _navigationBarItemList.add(
          SalomonBottomBarItem(
            icon: const Icon(Icons.star_outline_rounded, size: 25),
            title: Text(S.current.star),
          ),
        );
        _pageList.add(_starScreen);
      }
      if (HiveUtil.readLaterNavigationVisible()) {
        _navigationBarItemList.add(
          SalomonBottomBarItem(
            icon: const Icon(Icons.checklist_rounded),
            title: Text(S.current.readLater),
          ),
        );
        _pageList.add(_readLaterScreen);
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
    initData();
    return Container(
      color: AppTheme.background,
      child: HiveUtil.showNavigationBar()
          ? Scaffold(
              backgroundColor: Colors.transparent,
              bottomNavigationBar: SalomonBottomBar(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                items: _navigationBarItemList,
                currentIndex: selectedIndex,
                backgroundColor: AppTheme.white,
                selectedItemColor: AppTheme.themeColor,
                onTap: onBottomNavigationBarItemTap,
              ),
              body: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: _pageList,
              ),
              drawer: _drawer(),
            )
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: _homeScreen,
              drawer: _drawer(),
            ),
    );
  }

  void cancleTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void setTimer() {
    _timer = Timer(
        Duration(
            minutes: AutoLock
                .autoLockOptions[HiveUtil.getInt(key: HiveUtil.autoLockTimeKey)]
                .minutes), () {
      if (HiveUtil.shouldAutoLock() && !_isInVerify) {
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
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        cancleTimer();
        break;
      case AppLifecycleState.paused:
        setTimer();
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
                        ItemBuilder.buildCaptionItem(
                          title: "内容中心",
                          topRadius: true,
                        ),
                        Visibility(
                          visible: !HiveUtil.showNavigationBar(),
                          child: ItemBuilder.buildEntryItem(
                            title: S.current.article,
                            onTap: () {},
                            showLeading: true,
                            leading: Icons.feed_outlined,
                          ),
                        ),
                        Visibility(
                          visible: !HiveUtil.showNavigationBar(),
                          child: ItemBuilder.buildEntryItem(
                            title: S.current.feed,
                            showLeading: true,
                            onTap: () {},
                            leading: Icons.rss_feed_rounded,
                          ),
                        ),
                        Visibility(
                          visible: !HiveUtil.starNavigationVisible(),
                          child: ItemBuilder.buildEntryItem(
                            title: S.current.star,
                            showLeading: true,
                            onTap: () {},
                            leading: Icons.star_border_rounded,
                          ),
                        ),
                        Visibility(
                          visible: !HiveUtil.readLaterNavigationVisible(),
                          child: ItemBuilder.buildEntryItem(
                            title: S.current.readLater,
                            showLeading: true,
                            onTap: () {},
                            leading: Icons.checklist_rounded,
                          ),
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.highlights,
                          onTap: () {},
                          showLeading: true,
                          leading: Icons.bookmark_border_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "探索",
                          showLeading: true,
                          onTap: () {},
                          leading: Icons.explore_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          showLeading: true,
                          title: S.current.statistics,
                          bottomRadius: true,
                          onTap: () {},
                          leading: Icons.show_chart_rounded,
                        ),
                        const SizedBox(height: 10),
                        ItemBuilder.buildCaptionItem(
                          title: S.current.setting,
                          topRadius: true,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.generalSetting,
                          showLeading: true,
                          onTap: () {
                            Navigator.pushNamed(
                                context, GeneralSettingScreen.routeName);
                          },
                          leading: Icons.settings_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          showLeading: true,
                          title: S.current.apprearanceSetting,
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppearanceSettingScreen.routeName);
                          },
                          leading: Icons.color_lens_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.extensionSetting,
                          showLeading: true,
                          onTap: () {
                            Navigator.pushNamed(
                                context, ExtensionSettingScreen.routeName);
                          },
                          leading: Icons.extension_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.backupSetting,
                          showLeading: true,
                          onTap: () {
                            Navigator.pushNamed(
                                context, BackupSettingScreen.routeName);
                          },
                          leading: Icons.backup_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.operationSetting,
                          showLeading: true,
                          onTap: () {
                            Navigator.pushNamed(
                                context, OperationSettingScreen.routeName);
                          },
                          leading: Icons.layers_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          showLeading: true,
                          title: S.current.privacySetting,
                          onTap: () {
                            Navigator.pushNamed(
                                context, PrivacySettingScreen.routeName);
                          },
                          leading: Icons.privacy_tip_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          showLeading: true,
                          title: S.current.experimentSetting,
                          onTap: () {
                            Navigator.pushNamed(
                                context, ExperimentSettingScreen.routeName);
                          },
                          bottomRadius: true,
                          leading: Icons.outlined_flag_rounded,
                        ),
                        const SizedBox(height: 10),
                        ItemBuilder.buildEntryItem(
                          title: S.current.help,
                          topRadius: true,
                          showLeading: true,
                          onTap: () {
                            UriUtil.launchUrlUri(
                                "https://rssreader.cloudchewie.com/help");
                          },
                          leading: Icons.help_outline_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: S.current.about,
                          bottomRadius: true,
                          showLeading: true,
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
