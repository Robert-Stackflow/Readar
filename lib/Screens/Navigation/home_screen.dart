import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:provider/provider.dart';
import 'package:readar/Providers/Feed/feed_provider.dart';
import 'package:readar/Resources/theme.dart';
import 'package:readar/Screens/refresh_interface.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../Providers/RssService/base_rss_service_provider.dart';
import '../../Utils/app_provider.dart';
import '../../Utils/asset_util.dart';
import '../../Utils/constant.dart';
import '../../Utils/enums.dart';
import '../../Utils/lottie_util.dart';
import '../../Utils/responsive_util.dart';
import '../../Utils/route_util.dart';
import '../../Utils/utils.dart';
import '../../Widgets/General/EasyRefresh/easy_refresh.dart';
import '../../Widgets/Hidable/scroll_to_hide.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../Widgets/Readar/feed_item.dart';
import '../../generated/l10n.dart';
import '../Setting/setting_screen.dart';

int krefreshTimeout = 300;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.scrollController,
  });

  final ScrollController? scrollController;

  static const String routeName = "/nav/home";

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin,
        ScrollToHideMixin,
        BottomNavgationMixin {
  @override
  bool get wantKeepAlive => true;
  int lastRefreshTime = 0;
  final EasyRefreshController _refreshController = EasyRefreshController();
  late final ScrollController _scrollController =
      widget.scrollController ?? ScrollController();
  late AnimationController _refreshRotationController;
  final ScrollToHideController _scrollToHideController =
      ScrollToHideController();
  final ResizableController _resizableController = ResizableController();

  late AnimationController darkModeController;
  Widget? darkModeWidget;

  refresh() {
    _refreshController.callRefresh();
  }

  @override
  void initState() {
    _refreshRotationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => panelScreenState?.refreshScrollControllers());
    darkModeController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        darkModeWidget = LottieUtil.load(
          LottieUtil.sunLight,
          size: 25,
          autoForward: !Utils.isDark(context),
          controller: darkModeController,
        );
      } catch (_) {}
      panelScreenState?.refreshScrollControllers();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: MyTheme.getBackground(context),
      appBar: ItemBuilder.buildResponsiveAppBar(
        context: context,
        title: S.current.home,
        titleLeftMargin: 15,
        actions: [
          ItemBuilder.buildDynamicIconButton(
            context: context,
            icon: darkModeWidget,
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
          const SizedBox(width: 5),
          ItemBuilder.buildDynamicIconButton(
            context: context,
            icon: AssetUtil.loadDouble(
              context,
              AssetUtil.settingLightIcon,
              AssetUtil.settingDarkIcon,
            ),
            onTap: () {
              RouteUtil.pushPanelCupertinoRoute(context, const SettingScreen());
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ResizableContainer(
            direction: Axis.horizontal,
            controller: _resizableController,
            divider: ResizableDivider(
              color: Theme.of(context).dividerColor,
              thickness: ResponsiveUtil.isMobile() ? 2 : 1,
              size: 6,
              onHoverEnter: () {
                if (ResponsiveUtil.isMobile()) {
                  HapticFeedback.lightImpact();
                }
              },
            ),
            children: [
              ResizableChild(
                size: const ResizableSize.pixels(240),
                minSize: 240,
                maxSize: 300,
                child: _buildFeedList(),
              ),
              ResizableChild(
                minSize: 300,
                size: const ResizableSize.expand(),
                child: EasyRefresh(
                  refreshOnStart: true,
                  controller: _refreshController,
                  onRefresh: () {},
                  onLoad: () {},
                  child: ItemBuilder.buildEmptyPlaceholder(
                    context: context,
                    text: S.current.home,
                    shrinkWrap: false,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: ScrollToHide(
              controller: _scrollToHideController,
              scrollControllers: [_scrollController],
              hideDirection: AxisDirection.down,
              child: _buildFloatingButtons(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedList() {
    final serviceAdapter = Provider.of<BaseRssServiceProvider?>(context);
    return serviceAdapter == null
        ? Container()
        : WaterfallFlow.builder(
            itemCount: serviceAdapter.feedProviders.length,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              FeedProvider feedProvider = serviceAdapter.feedProviders[index];
              var feed = feedProvider.feedModel;
              return FeedItem(
                feed: feed,
                selected: serviceAdapter.selectedFeedUid == feed.uid,
                onTap: () {
                  serviceAdapter.selectedFeedUid = feed.uid;
                },
              );
            },
          );
  }

  void scrollToTopAndRefresh() {
    int nowTime = DateTime.now().millisecondsSinceEpoch;
    if (lastRefreshTime == 0 || (nowTime - lastRefreshTime) > krefreshTimeout) {
      lastRefreshTime = nowTime;
      if (_scrollController.offset > MediaQuery.sizeOf(context).height) {
        _scrollController
            .animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut)
            .then((_) {
          _refreshController.callRefresh();
        });
      } else {
        _refreshController.callRefresh();
      }
    }
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

  _buildFloatingButtons() {
    return ResponsiveUtil.isLandscape()
        ? Column(
            children: [
              ItemBuilder.buildShadowIconButton(
                context: context,
                icon: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0)
                      .animate(_refreshRotationController),
                  child: const Icon(Icons.refresh_rounded),
                ),
                onTap: () async {
                  refresh();
                },
              ),
              const SizedBox(height: 10),
              ItemBuilder.buildShadowIconButton(
                context: context,
                icon: const Icon(Icons.arrow_upward_rounded),
                onTap: () {
                  scrollToTop();
                },
              ),
            ],
          )
        : emptyWidget;
  }

  void scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void scrollToTopOrRefresh() {
    if (_scrollController.hasClients && _scrollController.offset > 30) {
      scrollToTop();
    } else {
      _refreshController.callRefresh();
    }
  }

  @override
  List<ScrollController> getScrollControllers() {
    return [_scrollController];
  }

  @override
  FutureOr onTapBottomNavigation() {
    scrollToTopOrRefresh();
  }
}
