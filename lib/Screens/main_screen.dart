import 'dart:async';

import 'package:readar/Models/nav_entry.dart';
import 'package:readar/Screens/Navigation/article_screen.dart';
import 'package:readar/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:provider/provider.dart';

import '../Providers/global_provider.dart';
import '../Providers/provider_manager.dart';
import '../Utils/hive_util.dart';
import '../Widgets/Item/item_builder.dart';
import '../Widgets/Scaffold/my_scaffold.dart';
import '../generated/l10n.dart';
import 'Lock/pin_verify_screen.dart';
import 'Setting/about_setting_screen.dart';
import 'Setting/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = "/";

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  List<Widget> _pageList = [];
  List<NavEntry> _sideBarEntries = [];
  Timer? _timer;
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
    _pageList = [const ArticleScreen()];
    _sideBarEntries = NavEntry.getShownEntries();
    if (NavEntry.getHiddenEntries().isNotEmpty) {
      _sideBarEntries.add(NavEntry.libraryEntry);
    }
    _sideBarEntries.addAll(NavEntry.defaultEntries);
    for (NavEntry item in _sideBarEntries) {
      _pageList.add(NavEntry.getPage(item.id));
    }
    setState(() {});
  }

  void onBottomNavigationBarItemTap(int index) {
    _pageController.jumpToPage(index);
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
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
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
                            context: context, title: S.current.article),
                        ..._feedEntries(),
                        const SizedBox(height: 10),
                        ItemBuilder.buildCaptionItem(
                            context: context, title: S.current.content),
                        ..._contentEntries(),
                        const SizedBox(height: 10),
                        ItemBuilder.buildEntryItem(
                          context: context,
                          title: S.current.setting,
                          padding: 15,
                          topRadius: true,
                          showLeading: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const SettingScreen()));
                          },
                          leading: Icons.settings_outlined,
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
          ],
        ),
      ),
    );
  }

  List<Widget> _contentEntries() {
    List<Widget> widgets = [];
    for (NavEntry entry in _sideBarEntries) {
      widgets.add(
        ItemBuilder.buildEntryItem(
          context: context,
          title: NavEntry.getLabel(entry.id),
          showLeading: true,
          padding: 15,
          bottomRadius: _sideBarEntries.last == entry,
          onTap: () {
            setState(() {
              if (mounted) {
                _pageController.jumpToPage(_sideBarEntries.indexOf(entry) + 1);
              }
            });
            Navigator.of(context).pop();
          },
          leading: NavEntry.getIcon(entry.id),
        ),
      );
    }
    return widgets;
  }

  List<Widget> _feedEntries() {
    List<Widget> widgets = [];
    widgets.add(
      ItemBuilder.buildEntryItem(
        context: context,
        title: S.current.allArticle,
        showLeading: true,
        padding: 15,
        bottomRadius: true,
        onTap: () {
          setState(() {
            if (mounted) {
              _pageController.jumpToPage(0);
            }
          });
          Navigator.of(context).pop();
        },
        leading: Icons.feed_outlined,
      ),
    );
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
