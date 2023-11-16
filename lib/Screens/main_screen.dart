import 'dart:async';

import 'package:cloudreader/Models/nav_entry.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import '../Providers/global_provider.dart';
import '../Providers/provider_manager.dart';
import '../Utils/hive_util.dart';
import '../Widgets/Custom/salomon_bottom_bar.dart';
import '../Widgets/Item/item_builder.dart';
import '../generated/l10n.dart';
import 'Lock/pin_verify_screen.dart';
import 'Setting/setting_screen.dart';

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
  bool _showNavigationBar = ProviderManager.globalProvider.showNavigationBar;
  final _pageController = PageController();
  late bool isDark;
  IconData? themeModeIcon;

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

  List<Widget> _contentEntries() {
    List<NavEntry> sideBarEntries =
        ProviderManager.globalProvider.showNavigationBar
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
      ));
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

  Widget _toolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(70),
            offset: const Offset(-16, 14),
            blurRadius: 18,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const SettingScreen()));
            },
            icon: const Icon(Icons.settings_outlined, size: 23),
          ),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              ProviderManager.globalProvider.themeMode =
                  isDark ? ActiveThemeMode.light : ActiveThemeMode.dark;
              refreshDarkState();
            },
            icon: Icon(themeModeIcon, size: 23),
          ),
        ],
      ),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
