import 'dart:async';

import 'package:cloudreader/Models/nav_entry.dart';
import 'package:cloudreader/Utils/iprint.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:provider/provider.dart';

import '../Providers/global_provider.dart';
import '../Providers/provider_manager.dart';
import '../Utils/hive_util.dart';
import '../Utils/uri_util.dart';
import '../Widgets/Custom/salomon_bottom_bar.dart';
import '../Widgets/Item/item_builder.dart';
import '../Widgets/Scaffold/my_scaffold.dart';
import '../generated/l10n.dart';
import 'Lock/pin_verify_screen.dart';
import 'Setting/about_setting_screen.dart';
import 'Setting/backup_setting_screen.dart';
import 'Setting/experiment_setting_screen.dart';
import 'Setting/extension_setting_screen.dart';
import 'Setting/general_setting_screen.dart';
import 'Setting/global_setting_screen.dart';
import 'Setting/operation_setting_screen.dart';
import 'Setting/service_setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = "/";

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  List<Widget> _pageList = [];
  List<SalomonBottomBarItem> _navigationBarItemList = [];
  Timer? _timer;
  int _bottomBarSelectedIndex = 0;
  bool _showNavigationBar = ProviderManager.globalProvider.showNavigationBar;
  late bool isDark;
  IconData? themeModeIcon;
  bool isDrawerOpen = false;
  final _pageController = PageController(keepPage: true);
  late final AnimationController _drawerAnimationController;

  @override
  void initState() {
    super.initState();
    _drawerAnimationController = AnimationController(
      vsync: this,
      value: ProviderManager.globalProvider.isDrawerOpen ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 246),
    );
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
      refreshDarkState();
    });
    ProviderManager.globalProvider.addListener(() {
      initData();
    });
  }

  void initData() {
    _pageList = [];
    _navigationBarItemList = [];
    setState(() {
      _showNavigationBar = ProviderManager.globalProvider.showNavigationBar &&
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
  }

  void onBottomNavigationBarItemTap(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _bottomBarSelectedIndex = index;
    });
  }

  void goPinVerify() {
    if (HiveUtil.shouldAutoLock()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PinVerifyScreen(
            onSuccess: () {},
            isModal: true,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return MyScaffold(
      key: ProviderManager.globalProvider.homeScaffoldKey,
      onDrawerChanged: (isOpened) {
        ProviderManager.globalProvider.isDrawerOpen = isOpened;
      },
      // drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      body: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.98)
            .animate(_drawerAnimationController),
        child: Selector<GlobalProvider, bool>(
          selector: (context, globalProvider) => globalProvider.isDrawerOpen,
          builder: (context, isSidebarOpen, _) => PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _pageList,
          ),
        ),
      ),
      drawer: _drawer(),
      bottomNavigationBar: _showNavigationBar
          ? SalomonBottomBar(
              margin: const EdgeInsets.all(10),
              items: _navigationBarItemList,
              currentIndex: _bottomBarSelectedIndex,
              backgroundColor: Theme.of(context).canvasColor,
              selectedItemColor: Theme.of(context).primaryColor,
              onTap: onBottomNavigationBarItemTap,
            )
          : null,
      customAnimationController: _drawerAnimationController,
    );
  }

  Widget _drawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      elevation: 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ScrollConfiguration(
        behavior: NoShadowScrollBehavior(),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
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
                            context: context, title: S.current.content),
                        ..._contentEntries(),
                        const SizedBox(height: 10),
                        ItemBuilder.buildCaptionItem(
                            context: context, title: S.current.basicSetting),
                        ItemBuilder.buildEntryItem(
                          context: context,
                          title: S.current.generalSetting,
                          padding: 15,
                          showLeading: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const GeneralSettingScreen()));
                          },
                          leading: Icons.settings_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          context: context,
                          showLeading: true,
                          title: S.current.globalSetting,
                          padding: 15,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const GlobalSettingScreen()));
                          },
                          leading: Icons.settings_applications_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          context: context,
                          title: S.current.operationSetting,
                          showLeading: true,
                          bottomRadius: true,
                          padding: 15,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const OperationSettingScreen()));
                          },
                          leading: Icons.touch_app_outlined,
                        ),
                        const SizedBox(height: 10),
                        ItemBuilder.buildCaptionItem(
                            context: context, title: S.current.advancedSetting),
                        ItemBuilder.buildEntryItem(
                          context: context,
                          title: S.current.serviceSetting,
                          showLeading: true,
                          padding: 15,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const ServiceSettingScreen()));
                          },
                          leading: Icons.business_center_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          context: context,
                          title: S.current.backupSetting,
                          showLeading: true,
                          padding: 15,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const BackupSettingScreen()));
                          },
                          leading: Icons.backup_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          context: context,
                          title: S.current.extensionSetting,
                          showLeading: true,
                          padding: 15,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const ExtensionSettingScreen()));
                          },
                          leading: Icons.extension_outlined,
                        ),
                        ItemBuilder.buildEntryItem(
                          context: context,
                          showLeading: true,
                          title: S.current.experimentSetting,
                          padding: 15,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const ExperimentSettingScreen()));
                          },
                          bottomRadius: true,
                          leading: Icons.outlined_flag_rounded,
                        ),
                        const SizedBox(height: 10),
                        ItemBuilder.buildEntryItem(
                          context: context,
                          title: S.current.help,
                          topRadius: true,
                          showLeading: true,
                          padding: 15,
                          onTap: () {
                            UriUtil.launchUrlUri(
                                "https://rssreader.cloudchewie.com/help");
                          },
                          leading: Icons.help_outline_rounded,
                        ),
                        ItemBuilder.buildEntryItem(
                          context: context,
                          title: S.current.about,
                          bottomRadius: true,
                          showLeading: true,
                          padding: 15,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const AboutSettingScreen()));
                          },
                          leading: Icons.info_outline_rounded,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).canvasColor,
            //     boxShadow: <BoxShadow>[
            //       BoxShadow(
            //         color: Theme.of(context).shadowColor.withAlpha(70),
            //         offset: const Offset(-16, 14),
            //         blurRadius: 18,
            //         spreadRadius: 0,
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       IconButton(
            //         splashColor: Colors.transparent,
            //         highlightColor: Colors.transparent,
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               CupertinoPageRoute(
            //                   builder: (context) => const SettingScreen()));
            //         },
            //         icon: const Icon(Icons.settings_outlined, size: 23),
            //       ),
            //       IconButton(
            //         splashColor: Colors.transparent,
            //         highlightColor: Colors.transparent,
            //         onPressed: () {
            //           ProviderManager.globalProvider.themeMode =
            //               isDark ? ActiveThemeMode.light : ActiveThemeMode.dark;
            //           refreshDarkState();
            //         },
            //         icon: Icon(themeModeIcon, size: 23),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  List<Widget> _contentEntries() {
    List<NavEntry> sideBarEntries =
        ProviderManager.globalProvider.showNavigationBar
            ? NavEntry.getSidebarEntries()
            : NavEntry.getNavs();
    List<Widget> widgets = [];
    for (NavEntry entry in sideBarEntries) {
      widgets.add(
        ItemBuilder.buildEntryItem(
          context: context,
          title: NavEntry.getLabel(entry.id),
          showLeading: true,
          padding: 15,
          bottomRadius: sideBarEntries.last == entry,
          onTap: () {
            if (_showNavigationBar) {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => NavEntry.getPage(entry.id),
                  settings: RouteSettings(
                      name: "isNavigationBarEntry", arguments: entry.visible),
                ),
              );
            } else {
              setState(() {
                if (mounted) {
                  _pageController.jumpToPage(sideBarEntries.indexOf(entry));
                }
              });
              Navigator.of(context).pop();
            }
          },
          leading: NavEntry.getIcon(entry.id),
        ),
      );
    }
    return widgets;
  }

  refreshDarkState() {
    setState(() {
      isDark = (ProviderManager.globalProvider.themeMode ==
                  ActiveThemeMode.system &&
              MediaQuery.of(context).platformBrightness == Brightness.dark) ||
          ProviderManager.globalProvider.themeMode == ActiveThemeMode.dark;
      if (!isDark) {
        themeModeIcon = Icons.dark_mode_outlined;
      } else {
        themeModeIcon = Icons.light_mode_outlined;
      }
    });
  }

  void cancleTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void setTimer() {
    _timer = Timer(
        Duration(minutes: ProviderManager.globalProvider.autoLockTime),
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
}
