import 'dart:async';

import 'package:cloudreader/Models/auto_lock.dart';
import 'package:cloudreader/Models/nav_entry.dart';
import 'package:cloudreader/Screens/Setting/about_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/appearance_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/backup_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/experiment_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/extension_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/general_setting_screen.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:cloudreader/Utils/uri_util.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import '../Providers/global.dart';
import '../Utils/hive_util.dart';
import '../Widgets/Custom/salomon_bottom_bar.dart';
import '../Widgets/Item/item_builder.dart';
import '../generated/l10n.dart';
import 'Lock/pin_verify_screen.dart';
import 'Setting/operation_setting_screen.dart';
import 'Setting/service_setting_screen.dart';

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
  bool _showNavigationBar = Global.globalProvider.showNavigationBar;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (HiveUtil.getBool(
        key: HiveUtil.enableSafeModeKey, defaultValue: false)) {
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } else {
      FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      goPinVerify();
      initData();
    });
    Global.globalProvider.addListener(() {
      initData();
    });
  }

  void initData() {
    _pageList = [];
    _navigationBarItemList = [];
    setState(() {
      _showNavigationBar = Global.globalProvider.showNavigationBar &&
          NavEntry.getNavigationBarEntries().isNotEmpty;
      if (_showNavigationBar) {
        for (NavEntry item in NavEntry.getNavigationBarEntries()) {
          _navigationBarItemList.add(SalomonBottomBarItem(
              icon: Icon(NavEntry.getIcon(item.id)),
              title: Text(NavEntry.getLabel(item.id))));
          _pageList.add(NavEntry.getPage(item.id));
        }
      } else {
        for (NavEntry item in NavEntry.getNavs()) {
          _pageList.add(NavEntry.getPage(item.id));
        }
      }
    });
    // setState(() {
    //
    //
    //   if (!Global.globalProvider.showNavigationBar && mounted) {
    //     singlePage = NavEntry.getPage(Global.globalProvider.navEntries[0].id);
    //   }
    // });
  }

  void onBottomNavigationBarItemTap(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  void goPinVerify() {
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
    return _showNavigationBar
        ? Scaffold(
            bottomNavigationBar: SalomonBottomBar(
              margin: const EdgeInsets.all(10),
              items: _navigationBarItemList,
              currentIndex: _selectedIndex,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).shadowColor.withAlpha(70),
                  offset: const Offset(0, 14),
                  blurRadius: 24,
                  spreadRadius: 0,
                ),
              ],
              backgroundColor: Theme.of(context).canvasColor,
              selectedItemColor: Theme.of(context).primaryColor,
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
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pageList,
            ),
            drawer: _drawer(),
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
        goPinVerify);
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

  List<Widget> _contentEntries() {
    List<NavEntry> sideBarEntries = Global.globalProvider.showNavigationBar
        ? NavEntry.getSidebarEntries()
        : NavEntry.getNavs();
    List<Widget> widgets = [];
    for (NavEntry entry in sideBarEntries) {
      widgets.add(ItemBuilder.buildEntryItem(
        context: context,
        title: NavEntry.getLabel(entry.id),
        showLeading: true,
        padding: 15,
        bottomRadius: sideBarEntries.last == entry,
        onTap: () {
          if (_showNavigationBar) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NavEntry.getPage(entry.id),
                settings: RouteSettings(
                    name: "isNavigationBarEntry", arguments: entry.visible),
              ),
            );
          } else {
            setState(() {
              if (mounted) {
                IToast.showTop(context, text: entry.id);
                _pageController.jumpToPage(sideBarEntries.indexOf(entry));
              }
            });
            Navigator.of(context).pop();
          }
        },
        leading: NavEntry.getIcon(entry.id),
      ));
    }
    return widgets;
  }

  List<Widget> _settingEntries() {
    return <Widget>[
      ItemBuilder.buildCaptionItem(context: context, title: S.current.setting),
      ItemBuilder.buildEntryItem(
        context: context,
        title: S.current.generalSetting,
        showLeading: true,
        onTap: () {
          Navigator.pushNamed(context, GeneralSettingScreen.routeName);
        },
        padding: 15,
        leading: Icons.settings_outlined,
      ),
      ItemBuilder.buildEntryItem(
        context: context,
        showLeading: true,
        title: S.current.apprearanceSetting,
        onTap: () {
          Navigator.pushNamed(context, AppearanceSettingScreen.routeName);
        },
        padding: 15,
        leading: Icons.color_lens_outlined,
      ),
      ItemBuilder.buildEntryItem(
        context: context,
        title: S.current.serviceSetting,
        showLeading: true,
        onTap: () {
          Navigator.pushNamed(context, ServiceSettingScreen.routeName);
        },
        padding: 15,
        leading: Icons.business_center_outlined,
      ),
      ItemBuilder.buildEntryItem(
        context: context,
        title: S.current.backupSetting,
        showLeading: true,
        onTap: () {
          Navigator.pushNamed(context, BackupSettingScreen.routeName);
        },
        padding: 15,
        leading: Icons.backup_outlined,
      ),
      ItemBuilder.buildEntryItem(
        context: context,
        title: S.current.operationSetting,
        showLeading: true,
        onTap: () {
          Navigator.pushNamed(context, OperationSettingScreen.routeName);
        },
        padding: 15,
        leading: Icons.touch_app_outlined,
      ),
      ItemBuilder.buildEntryItem(
        context: context,
        title: S.current.extensionSetting,
        showLeading: true,
        onTap: () {
          Navigator.pushNamed(context, ExtensionSettingScreen.routeName);
        },
        padding: 15,
        leading: Icons.extension_outlined,
      ),
      ItemBuilder.buildEntryItem(
        context: context,
        showLeading: true,
        title: S.current.experimentSetting,
        onTap: () {
          Navigator.pushNamed(context, ExperimentSettingScreen.routeName);
        },
        padding: 15,
        bottomRadius: true,
        leading: Icons.outlined_flag_rounded,
      ),
    ];
  }

  Widget _drawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      elevation: 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ScrollConfiguration(
        behavior: NoShadowScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: [
                    ItemBuilder.buildCaptionItem(
                        context: context, title: S.current.content),
                    ..._contentEntries(),
                    const SizedBox(height: 10),
                    ..._settingEntries(),
                    const SizedBox(height: 10),
                    ItemBuilder.buildEntryItem(
                      context: context,
                      title: S.current.help,
                      topRadius: true,
                      showLeading: true,
                      onTap: () {
                        UriUtil.launchUrlUri(
                            "https://rssreader.cloudchewie.com/help");
                      },
                      padding: 15,
                      leading: Icons.help_outline_rounded,
                    ),
                    ItemBuilder.buildEntryItem(
                      context: context,
                      title: S.current.about,
                      bottomRadius: true,
                      showLeading: true,
                      onTap: () {
                        Navigator.pushNamed(
                            context, AboutSettingScreen.routeName);
                      },
                      padding: 15,
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
    );
  }
}
