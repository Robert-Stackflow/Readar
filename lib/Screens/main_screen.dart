import 'dart:async';

import 'package:cloudreader/Configs/hive_config.dart';
import 'package:cloudreader/Models/auto_lock.dart';
import 'package:cloudreader/Models/bottom_navigation_icon_data.dart';
import 'package:cloudreader/Screens/Navigation/read_later_screen.dart';
import 'package:cloudreader/Screens/Setting/about_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/appearance_setting_scrren.dart';
import 'package:cloudreader/Screens/Setting/backup_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/general_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/lab_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/privacy_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/service_setting_screen.dart';
import 'package:cloudreader/Screens/navigation/home_screen.dart';
import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/itoast.dart';
import '../Widgets/item_builder.dart';
import 'Lock/pin_verify_screen.dart';
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
  List<BottomNavigationIconData> tabIconsList =
      BottomNavigationIconData.tabIconsList;
  int selectedIndex = 0;
  final List<Widget> _pageList = [
    const HomeScreen(),
    const SubscriptionScreen(),
    const StarScreen(),
    const ReadLaterScreen()
  ];
  final _pageController = PageController();
  Timer? _timer;
  bool _isInVerify = false;

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (HiveConfig.getBool(key: HiveConfig.safeModeKey, defaultValue: false)) {
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } else {
      FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (HiveConfig.getBool(key: HiveConfig.lockEnableKey) &&
          HiveConfig.getString(key: HiveConfig.lockPinKey)!.isNotEmpty &&
          HiveConfig.getBool(key: HiveConfig.autoLockKey) &&
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
    });
  }

  _launchUrl(String url) async {
    IToast.showTop(context, text: "缺少跳转权限,链接已复制至剪切板");
    if (!await launchUrl(Uri(path: url))) {
      Clipboard.setData(ClipboardData(text: url));
    }
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
          items: List.generate(
            tabIconsList.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(tabIconsList[index].icon),
              label: (tabIconsList[index].label),
            ),
          ),
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
                        HiveConfig.getInt(key: HiveConfig.autoLockTimeKey)]
                    .minutes), () {
          if (HiveConfig.getBool(key: HiveConfig.lockEnableKey) &&
              HiveConfig.getString(key: HiveConfig.lockPinKey)!.isNotEmpty &&
              HiveConfig.getBool(key: HiveConfig.autoLockKey) &&
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
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10),
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
                          title: "集锦",
                          topRadius: true,
                          onTap: () {},
                          showIcon: true,
                          leading: Icons.bookmark_border_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "TTS",
                          showIcon: true,
                          onTap: () {},
                          leading: Icons.headset_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "星标文章",
                          showIcon: true,
                          onTap: () {},
                          leading: Icons.star_border_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "稍后阅读",
                          showIcon: true,
                          onTap: () {},
                          leading: Icons.checklist_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "文章标签",
                          showIcon: true,
                          onTap: () {},
                          leading: Icons.tag_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "订阅源社区",
                          onTap: () {},
                          showIcon: true,
                          bottomRadius: true,
                          leading: Icons.add_link_rounded,
                        ),
                        const SizedBox(height: 10),
                        ItemBuilder.buildEntryItem(
                          showIcon: true,
                          title: "统计",
                          topRadius: true,
                          onTap: () {},
                          leading: Icons.show_chart_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "阅读历史",
                          showIcon: true,
                          bottomRadius: true,
                          onTap: () {},
                          leading: Icons.history_outlined,
                        ),
                        const SizedBox(height: 10),
                        ItemBuilder.buildEntryItem(
                          title: "通用",
                          topRadius: true,
                          showIcon: true,
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, GeneralSettingScreen.routeName);
                          },
                          leading: Icons.settings_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          showIcon: true,
                          title: "外观",
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, AppearanceSettingScreen.routeName);
                          },
                          leading: Icons.color_lens_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "服务",
                          showIcon: true,
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, ServiceSettingScreen.routeName);
                          },
                          leading: Icons.extension_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "备份",
                          showIcon: true,
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, BackupSettingScreen.routeName);
                          },
                          leading: Icons.backup_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          showIcon: true,
                          title: "隐私",
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, PrivacySettingScreen.routeName);
                          },
                          leading: Icons.privacy_tip_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          showIcon: true,
                          title: "实验室",
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, LabSettingScreen.routeName);
                          },
                          bottomRadius: true,
                          leading: Icons.outlined_flag_rounded,
                        ),
                        const SizedBox(height: 10),
                        ItemBuilder.buildEntryItem(
                          title: "使用指南",
                          topRadius: true,
                          showIcon: true,
                          onTap: () {
                            _launchUrl(
                                "https://rssreader.cloudchewie.com/help");
                          },
                          leading: Icons.help_outline_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "意见反馈",
                          showIcon: true,
                          onTap: () {
                            _launchUrl("mailto:2014027378@qq.com");
                          },
                          leading: Icons.feedback_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          title: "关于噬云",
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
