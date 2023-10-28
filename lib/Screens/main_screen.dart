import 'dart:async';

import 'package:cloudreader/Models/auto_lock.dart';
import 'package:cloudreader/Models/nav_data.dart';
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
  int _selectedIndex = 0;
  bool _isInVerify = false;
  bool _showNavs = Global.globalProvider.showNavigationBar;
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
      jumpToPin();
      initData();
    });
    Global.globalProvider.addListener(() {
      initData();
    });
  }

  void initData() {
    _pageList = [];
    _navigationBarItemList = [];
    List<NavData> showNavs = NavData.getShownNavs();
    setState(() {
      for (NavData item in showNavs) {
        _navigationBarItemList.add(SalomonBottomBarItem(
            icon: Icon(NavData.getIcon(item.id)),
            title: Text(NavData.getLabel(item.id))));
        _pageList.add(NavData.getPage(item.id));
      }
    });
    setState(() {
      _showNavs = Global.globalProvider.showNavigationBar &&
          NavData.getShownNavs().isNotEmpty;
    });
  }

  void onBottomNavigationBarItemTap(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  void jumpToPin() {
    if (HiveUtil.shouldAutoLock() && !_isInVerify) {
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
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Container(
      color: AppTheme.background,
      child: _showNavs
          ? Scaffold(
              backgroundColor: Colors.transparent,
              bottomNavigationBar: SalomonBottomBar(
                margin: const EdgeInsets.all(10),
                items: _navigationBarItemList,
                currentIndex: _selectedIndex,
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
              body: ArticleScreen(ScrollTopNotifier()),
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
                .minutes),
        jumpToPin);
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

  List<Widget> _contentCenter() {
    List<NavData> hiddenNavs = Global.globalProvider.showNavigationBar
        ? NavData.getHiddenNavs()
        : NavData.getNavs();
    List<Widget> widgets = [];
    for (NavData item in hiddenNavs) {
      widgets.add(ItemBuilder.buildEntryItem(
        title: NavData.getLabel(item.id),
        showLeading: true,
        bottomRadius: hiddenNavs.last == item,
        onTap: () {},
        leading: NavData.getIcon(item.id),
      ));
    }
    return widgets;
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
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                    children: [
                      ItemBuilder.buildCaptionItem(
                        title: S.current.contentCenter,
                        topRadius: true,
                      ),
                      ..._contentCenter(),
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
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
