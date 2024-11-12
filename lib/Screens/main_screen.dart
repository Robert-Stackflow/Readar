import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:context_menus/context_menus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:opml/opml.dart';
import 'package:provider/provider.dart';
import 'package:readar/Adapters/RssService/local_rss_service_adapter.dart';
import 'package:readar/Api/server_api.dart';
import 'package:readar/Screens/panel_screen.dart';
import 'package:readar/Utils/asset_util.dart';
import 'package:readar/Utils/cloud_control_provider.dart';
import 'package:readar/Utils/constant.dart';
import 'package:readar/Utils/file_util.dart';
import 'package:readar/Utils/responsive_util.dart';
import 'package:readar/Utils/uri_util.dart';
import 'package:readar/Widgets/BottomSheet/bottom_sheet_builder.dart';
import 'package:readar/Widgets/Item/item_builder.dart';
import 'package:readar/Widgets/Window/window_caption.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../../generated/l10n.dart';
import '../Models/feed.dart';
import '../Resources/fonts.dart';
import '../Resources/theme.dart';
import '../Utils/app_provider.dart';
import '../Utils/enums.dart';
import '../Utils/hive_util.dart';
import '../Utils/ilogger.dart';
import '../Utils/lottie_util.dart';
import '../Utils/route_util.dart';
import '../Utils/utils.dart';
import '../Widgets/Dialog/dialog_builder.dart';
import '../Widgets/General/EasyRefresh/easy_refresh.dart';
import '../Widgets/General/LottieCupertinoRefresh/lottie_cupertino_refresh.dart';
import '../Widgets/Window/window_button.dart';
import 'Lock/pin_verify_screen.dart';
import 'Setting/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = "/";

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
    with
        WidgetsBindingObserver,
        TickerProviderStateMixin,
        TrayListener,
        WindowListener,
        AutomaticKeepAliveClientMixin {
  Timer? _timer;
  late AnimationController darkModeController;
  Widget? darkModeWidget;
  bool _isMaximized = false;
  bool _isStayOnTop = false;
  bool _hasJumpedToPinVerify = false;
  Orientation? _oldOrientation;

  @override
  void onWindowMinimize() {
    setTimer();
    super.onWindowMinimize();
  }

  @override
  void onWindowRestore() {
    super.onWindowRestore();
    cancleTimer();
  }

  @override
  void onWindowFocus() {
    cancleTimer();
    super.onWindowFocus();
  }

  @override
  Future<void> onWindowResized() async {
    super.onWindowResized();
    appProvider.windowSize = await windowManager.getSize();
    HiveUtil.setWindowSize(await windowManager.getSize());
  }

  @override
  Future<void> onWindowMoved() async {
    super.onWindowMoved();
    HiveUtil.setWindowPosition(await windowManager.getPosition());
  }

  @override
  void onWindowEvent(String eventName) {
    super.onWindowEvent(eventName);
    if (eventName == "hide") {
      setTimer();
    }
  }

  @override
  void onWindowMaximize() {
    setState(() {
      _isMaximized = true;
    });
  }

  @override
  void onWindowUnmaximize() {
    setState(() {
      _isMaximized = false;
    });
  }

  Future<void> initDeepLinks() async {
    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        UriUtil.processUrl(context, uri.toString(), pass: false);
      }
    }, onError: (Object err) {
      ILogger.error('Failed to get URI: $err');
    });
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    WidgetsBinding.instance.addObserver(this);
    darkModeController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showQQGroupDialog();
      darkModeWidget = LottieUtil.load(
        LottieUtil.sunLight,
        size: 25,
        autoForward: !Utils.isDark(context),
        controller: darkModeController,
      );
      ResponsiveUtil.doInDesktop(desktop: () async {
        await Utils.initTray();
        trayManager.addListener(this);
        keyboardHandlerState?.focus();
      });
    });
    initConfig();
    fetchBasicData();
  }

  void fetchBasicData() {
    ServerApi.getCloudControl();
    CustomFont.downloadFont(showToast: false);
    if (HiveUtil.getBool(HiveUtil.autoCheckUpdateKey)) {
      Utils.getReleases(
        context: context,
        showLoading: false,
        showUpdateDialog: true,
        showFailedToast: false,
        showLatestToast: false,
      );
    }
  }

  initConfig() {
    ResponsiveUtil.checkSizeCondition();
    ResponsiveUtil.doInDesktop(
      desktop: () {
        initHotKey();
        windowManager
            .isAlwaysOnTop()
            .then((value) => setState(() => _isStayOnTop = value));
        windowManager
            .isMaximized()
            .then((value) => setState(() => _isMaximized = value));
      },
      mobile: () {
        Utils.setSafeMode(
            HiveUtil.getBool(HiveUtil.enableSafeModeKey, defaultValue: false));
      },
    );
    initDeepLinks();
    initEasyRefresh();
  }

  initHotKey() async {
    HotKey hotKey = HotKey(
      key: PhysicalKeyboardKey.keyC,
      modifiers: [HotKeyModifier.alt],
      scope: HotKeyScope.inapp,
    );
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        RouteUtil.pushPanelCupertinoRoute(rootContext, const SettingScreen());
      },
    );
  }

  initEasyRefresh() {
    // EasyRefresh.defaultHeaderBuilder = () => LottieCupertinoHeader(
    //       backgroundColor: Theme.of(context).canvasColor,
    //       indicator: LottieUtil.load(LottieUtil.getLoadingPath(context)),
    //       hapticFeedback: true,
    //       triggerOffset: 40,
    //     );
    EasyRefresh.defaultHeaderBuilder = () => MaterialHeader(
          backgroundColor: Theme.of(context).canvasColor,
          color: Theme.of(context).primaryColor,
        );
    EasyRefresh.defaultFooterBuilder = () => LottieCupertinoFooter(
          indicator: LottieUtil.load(LottieUtil.getLoadingPath(context)),
        );
  }

  showQQGroupDialog() {
    bool haveShownQQGroupDialog = HiveUtil.getBool(
        HiveUtil.haveShownQQGroupDialogKey,
        defaultValue: false);
    if (!haveShownQQGroupDialog) {
      HiveUtil.put(HiveUtil.haveShownQQGroupDialogKey, true);
      DialogBuilder.showConfirmDialog(
        context,
        title: S.current.feedbackWelcome,
        message: S.current.feedbackWelcomeMessage,
        messageTextAlign: TextAlign.center,
        confirmButtonText: S.current.goToQQ,
        cancelButtonText: S.current.joinLater,
        onTapConfirm: () {
          UriUtil.openExternal(controlProvider.globalControl.qqGroupUrl);
        },
      );
    }
  }

  void jumpToLock({bool autoAuth = false}) {
    if (HiveUtil.shouldAutoLock()) {
      _hasJumpedToPinVerify = true;
      RouteUtil.pushCupertinoRoute(
          context,
          PinVerifyScreen(
            isModal: true,
            autoAuth: autoAuth,
            showWindowTitle: true,
          ), onThen: (_) {
        _hasJumpedToPinVerify = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return OrientationBuilder(builder: (context, orientation) {
      if (_oldOrientation != null && orientation != _oldOrientation) {
        // ResponsiveUtil.returnToMainScreen(context);
      }
      _oldOrientation = orientation;
      return ResponsiveUtil.buildGeneralWidget(
        landscape: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyTheme.canvasColor,
          body: SafeArea(child: _buildDesktopBody()),
        ),
        desktop: _buildDesktopBody(),
        portrait: PanelScreen(key: panelScreenKey),
      );
    });
  }

  _buildDesktopBody() {
    return Row(
      children: [
        _sideBar(leftPadding: 8, rightPadding: 8),
        Expanded(
          child: Stack(
            children: [
              PanelScreen(key: panelScreenKey),
              Positioned(
                right: 0,
                child: _titleBar(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _titleBar() {
    return ResponsiveUtil.buildDesktopWidget(
      desktop: ItemBuilder.buildWindowTitle(
        context,
        backgroundColor: Colors.transparent,
        isStayOnTop: _isStayOnTop,
        isMaximized: _isMaximized,
        onStayOnTopTap: () {
          setState(() {
            _isStayOnTop = !_isStayOnTop;
            windowManager.setAlwaysOnTop(_isStayOnTop);
          });
        },
        rightButtons: [],
      ),
    );
  }

  changeMode() {
    if (Utils.isDark(context)) {
      appProvider.themeMode = ActiveThemeMode.light;
      darkModeController.forward();
    } else {
      appProvider.themeMode = ActiveThemeMode.dark;
      darkModeController.reverse();
    }
  }

  _sideBar({
    double leftPadding = 0,
    double rightPadding = 0,
  }) {
    return Container(
      width: 42 + leftPadding + rightPadding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: MyTheme.rightBorder,
      ),
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: Stack(
        children: [
          ResponsiveUtil.buildDesktopWidget(desktop: const WindowMoveHandle()),
          Consumer<ReadarControlProvider>(
            builder: (_, cloudControlProvider, __) =>
                Selector<AppProvider, SideBarChoice>(
              selector: (context, appProvider) => appProvider.sidebarChoice,
              builder: (context, sidebarChoice, child) =>
                  Selector<AppProvider, bool>(
                selector: (context, appProvider) =>
                    !appProvider.showPanelNavigator,
                builder: (context, hideNavigator, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ResponsiveUtil.buildDesktopWidget(
                        desktop: const SizedBox(height: 5)),
                    ResponsiveUtil.buildDesktopWidget(desktop: _buildLogo()),
                    const SizedBox(height: 8),
                    ToolButton(
                      context: context,
                      selected:
                          hideNavigator && sidebarChoice == SideBarChoice.Feed,
                      icon: Icons.article_outlined,
                      selectedIcon: Icons.article_rounded,
                      onTap: () async {
                        appProvider.sidebarChoice = SideBarChoice.Feed;
                        panelScreenState?.popAll(false);
                      },
                      iconSize: 24,
                    ),
                    const SizedBox(height: 8),
                    ToolButton(
                      context: context,
                      selected:
                          hideNavigator && sidebarChoice == SideBarChoice.Star,
                      icon: Icons.star_border_rounded,
                      selectedIcon: Icons.star_rounded,
                      onTap: () async {
                        appProvider.sidebarChoice = SideBarChoice.Star;
                        panelScreenState?.popAll(false);
                      },
                      iconSize: 24,
                    ),
                    const SizedBox(height: 8),
                    ToolButton(
                      context: context,
                      selected: hideNavigator &&
                          sidebarChoice == SideBarChoice.ReadLater,
                      icon: Icons.bookmark_border_rounded,
                      selectedIcon: Icons.bookmark_rounded,
                      onTap: () async {
                        appProvider.sidebarChoice = SideBarChoice.ReadLater;
                        panelScreenState?.popAll(false);
                      },
                      iconSize: 24,
                    ),
                    const SizedBox(height: 8),
                    ToolButton(
                      context: context,
                      selected: hideNavigator &&
                          sidebarChoice == SideBarChoice.Highlights,
                      icon: Icons.auto_fix_high_outlined,
                      selectedIcon: Icons.auto_fix_high_rounded,
                      onTap: () async {
                        appProvider.sidebarChoice = SideBarChoice.Highlights;
                        panelScreenState?.popAll(false);
                      },
                      iconSize: 24,
                    ),
                    const SizedBox(height: 8),
                    ToolButton(
                      context: context,
                      selected:
                          hideNavigator && sidebarChoice == SideBarChoice.Saved,
                      icon: Icons.save_alt_rounded,
                      selectedIcon: Icons.save_alt_rounded,
                      onTap: () async {
                        appProvider.sidebarChoice = SideBarChoice.Saved;
                        panelScreenState?.popAll(false);
                      },
                      iconSize: 24,
                    ),
                    const SizedBox(height: 8),
                    ToolButton(
                      context: context,
                      selected: hideNavigator &&
                          sidebarChoice == SideBarChoice.History,
                      icon: Icons.history_rounded,
                      selectedIcon: Icons.history_rounded,
                      onTap: () async {
                        appProvider.sidebarChoice = SideBarChoice.History;
                        panelScreenState?.popAll(false);
                      },
                      iconSize: 24,
                    ),
                    const SizedBox(height: 8),
                    ToolButton(
                      context: context,
                      selected: hideNavigator &&
                          sidebarChoice == SideBarChoice.Explore,
                      icon: Icons.explore_outlined,
                      selectedIcon: Icons.explore_rounded,
                      onTap: () async {
                        appProvider.sidebarChoice = SideBarChoice.Explore;
                        panelScreenState?.popAll(false);
                      },
                    ),
                    const Spacer(),
                    const SizedBox(height: 8),
                    ToolButton(
                      context: context,
                      icon: Icons.rss_feed_rounded,
                      onTap: () async {
                        FilePickerResult? result = await FileUtil.pickFiles(
                          dialogTitle: "选择OPML文件",
                          allowedExtensions: ["opml"],
                        );
                        if (result != null) {
                          String filePath = result.files.single.path!;
                          String xmlString =
                              await File(filePath).readAsString();
                          OpmlDocument opml = OpmlDocument.parse(xmlString);
                          List<Feed> feeds = [];
                          for (OpmlOutline outline in opml.body) {
                            if (outline.xmlUrl != null) {
                              feeds.add(Feed(
                                "",
                                outline.xmlUrl!,
                                outline.title ?? outline.text ?? "",
                                serviceUid: LocalRssServiceAdapter.instance.service.id,
                              ));
                            }
                          }
                          LocalRssServiceAdapter.instance.addFeeds(feeds);
                        }
                      },
                      iconSize: 24,
                    ),
                    const SizedBox(height: 8),
                    ToolButton(
                      context: context,
                      icon: Icons.language_rounded,
                      onTap: () async {
                        BottomSheetBuilder.showContextMenu(
                            context, _buildServiceMoreButtons());
                      },
                      iconSize: 24,
                    ),
                    const SizedBox(height: 2),
                    ItemBuilder.buildDynamicToolButton(
                      context: context,
                      iconBuilder: (colors) => darkModeWidget ?? emptyWidget,
                      onTap: changeMode,
                      onChangemode: (context, themeMode, child) {
                        if (darkModeController.duration != null) {
                          if (themeMode == ActiveThemeMode.light) {
                            darkModeController.forward();
                          } else if (themeMode == ActiveThemeMode.dark) {
                            darkModeController.reverse();
                          } else {
                            if (Utils.isDark(context)) {
                              darkModeController.reverse();
                            } else {
                              darkModeController.forward();
                            }
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 2),
                    ToolButton(
                      context: context,
                      iconBuilder: (_) => AssetUtil.loadDouble(
                        context,
                        AssetUtil.settingLightIcon,
                        AssetUtil.settingDarkIcon,
                      ),
                      padding: const EdgeInsets.all(8),
                      onTap: () {
                        RouteUtil.pushPanelCupertinoRoute(
                            context, const SettingScreen());
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildServiceMoreButtons() {
    return GenericContextMenu(
      buttonConfigs: [
        ContextMenuButtonConfig(
          "本地账户",
          iconData: Icons.account_circle_rounded,
          onPressed: () {},
        ),
      ],
    );
  }

  _buildLogo({
    double size = 50,
  }) {
    return IgnorePointer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo-transparent.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  void cancleTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void setTimer() {
    if (!_hasJumpedToPinVerify) {
      _timer = Timer(
        Duration(seconds: appProvider.autoLockSeconds),
        () {
          jumpToLock();
        },
      );
    }
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
    trayManager.removeListener(this);
    WidgetsBinding.instance.removeObserver(this);
    windowManager.removeListener(this);
    darkModeController.dispose();
    super.dispose();
  }

  @override
  void onTrayIconMouseDown() {
    Utils.displayApp();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayIconRightMouseUp() {}

  @override
  Future<void> onTrayMenuItemClick(MenuItem menuItem) async {
    Utils.processTrayMenuItemClick(context, menuItem, false);
  }

  @override
  bool get wantKeepAlive => true;
}
