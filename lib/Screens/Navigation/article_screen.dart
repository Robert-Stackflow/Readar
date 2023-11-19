import 'dart:io';

import 'package:cloudreader/Models/rss_item_list.dart';
import 'package:cloudreader/Models/rss_service.dart';
import 'package:cloudreader/Providers/rss_provider.dart';
import 'package:cloudreader/Resources/gaps.dart';
import 'package:cloudreader/Utils/iprint.dart';
import 'package:cloudreader/Widgets/Item/item_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';

import '../../Models/feed.dart';
import '../../Providers/provider_manager.dart';
import '../../Widgets/Custom/no_shadow_scroll_behavior.dart';
import '../../Widgets/Dropdown/dropdown_menu.dart';
import '../../Widgets/Dropdown/dropdown_menu_controller.dart';
import '../../Widgets/Item/article_item.dart';
import '../../Widgets/Scaffold/my_appbar.dart';

class ScrollTopNotifier with ChangeNotifier {
  int index = 0;

  void onTap(int newIndex) {
    var oldIndex = index;
    index = newIndex;
    if (newIndex == oldIndex) notifyListeners();
  }
}

class ArticleScreen extends StatefulWidget {
  const ArticleScreen(this.scrollTopNotifier, {super.key});

  final ScrollTopNotifier scrollTopNotifier;

  static const String routeName = "/nav/article";

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  DateTime? _lastLoadedMoreTime;
  late RefreshController _refreshController;
  final DropdownMenuController _dropdownMenuController =
      DropdownMenuController();
  late final AnimationController _dropdownAnimationController;
  late RssService? _currentRssService;
  List<Feed> _currentFeedList = [];

  @override
  void initState() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    super.initState();
    widget.scrollTopNotifier.addListener(_onScrollTop);
    _refreshController = RefreshController(initialRefresh: false);
    _dropdownAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 0,
      lowerBound: 0,
      upperBound: 0.5,
    );
    _dropdownMenuController.addListener(() {
      ProviderManager.globalProvider.shouldInterceptBack =
          _dropdownMenuController.isShow;
      if (_dropdownMenuController.isShow) {
        _dropdownAnimationController.forward();
      } else {
        _dropdownAnimationController.reverse();
      }
    });
    ProviderManager.globalProvider.addListener(() {
      if (ProviderManager.globalProvider.shouldInterceptBack == false &&
          _dropdownMenuController.isShow) {
        _dropdownMenuController.hide();
      }
    });
    refreshCurrentRssService(
        ProviderManager.rssProvider.currentRssServiceManager.rssService);
  }

  void refreshCurrentRssService(RssService? value) {
    setState(() {
      _currentRssService = value;
      _currentFeedList = ProviderManager.rssProvider
          .getRssServiceManager(_currentRssService)
          .getFeeds();
    });
  }

  @override
  void dispose() {
    widget.scrollTopNotifier.removeListener(_onScrollTop);
    super.dispose();
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    var feed = ProviderManager.rssProvider.currentRssItemList;
    if (feed.loading) {
      return;
    } else if (feed.allLoaded) {
      _refreshController.loadNoData();
    } else if ((_lastLoadedMoreTime == null ||
        DateTime.now().difference(_lastLoadedMoreTime!).inSeconds > 1)) {
      _lastLoadedMoreTime = DateTime.now();
      feed.loadMore().then((value) {
        IPrint.debug("加载完毕");
        _refreshController.loadComplete();
      });
    }
  }

  void _onScrollTop() {
    var expectedCanPop = widget.scrollTopNotifier.index == 1;
    if (expectedCanPop == Navigator.of(context).canPop()) {
      PrimaryScrollController.of(context).animateTo(
        0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: ScrollConfiguration(
        behavior: NoShadowScrollBehavior(),
        child: Stack(
          children: [
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: MaterialClassicHeader(
                backgroundColor: Theme.of(context).canvasColor,
                color: Theme.of(context).primaryColor,
              ),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = const Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = const Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = const Text("release to load more");
                  } else {
                    body = const Text("No more Data");
                  }
                  return SizedBox(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: _buildRssItemList(),
            ),
            DropDownMenu(
              controller: _dropdownMenuController,
              animationMilliseconds: 300,
              dropdownMenuChanging: (isShow, index) {},
              dropdownMenuChanged: (isShow, index) {},
              menus: [
                DropdownMenuBuilder(
                  dropDownHeight: 40 * 8.0,
                  dropDownWidget: Container(
                    color: Theme.of(context).canvasColor,
                    child: Selector<RssProvider, List<RssService>>(
                      selector: (context, rssProvider) =>
                          rssProvider.rssServices,
                      builder: (context, rssServices, _) =>
                          rssServices.isNotEmpty
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildFeedServiceList(rssServices),
                                    MyGaps.verticleDivider,
                                    _buildFeedList(),
                                  ],
                                )
                              : _buildFeedServceNull(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedServceNull() {
    return Container(
      alignment: Alignment.center,
      child: Text("暂无订阅源，请从本地导入或添加RSS服务",
          style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildFeedServiceList(List<RssService> rssServices) {
    return SizedBox(
      width: 100,
      child: ListView.builder(
        itemCount: rssServices.length,
        itemBuilder: (content, index) {
          return Material(
            child: Ink(
              decoration: BoxDecoration(color: Theme.of(context).canvasColor),
              child: InkWell(
                onTap: () {
                  refreshCurrentRssService(rssServices[index]);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    rssServices[index].name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _currentFeedList.length,
        itemBuilder: (content, index) {
          return Material(
            child: Ink(
              decoration: BoxDecoration(color: Theme.of(context).canvasColor),
              child: InkWell(
                onTap: () {
                  ProviderManager.rssProvider
                      .loadRssItemListByFid(_currentFeedList[index].fid);
                  _dropdownMenuController.hide();
                  _onScrollTop();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    _currentFeedList[index].name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRssItemList() {
    return Selector<RssProvider, RssItemList>(
      selector: (context, rssProvider) => rssProvider.currentRssItemList,
      builder: (context, currentRssItemList, child) => ListView.builder(
        itemCount: currentRssItemList.iids.length,
        itemBuilder: (content, index) {
          var item = ProviderManager.rssProvider.currentRssServiceManager
              .getItem(currentRssItemList.iids[index]);
          var tuple = Tuple2(
              item,
              ProviderManager.rssProvider.currentRssServiceManager
                  .getFeed(item.feedFid));
          return ArticleItem(tuple.item1, tuple.item2, (_) {},
              topMargin: index == 0);
        },
      ),
    );
  }

  bool _isNavigationBarEntry() {
    String? name = ModalRoute.of(context)!.settings.name;
    Object? arguments = ModalRoute.of(context)!.settings.arguments;
    if (name != null && arguments != null && name == "isNavigationBarEntry") {
      return arguments as bool;
    } else {
      return true;
    }
  }

  MyAppBar _buildAppBar() {
    return ItemBuilder.buildAppBar(
      context: context,
      leading: _isNavigationBarEntry()
          ? Icons.menu_rounded
          : Icons.arrow_back_rounded,
      onLeadingTap: () {
        if (_isNavigationBarEntry()) {
          ProviderManager.globalProvider.homeScaffoldKey.currentState
              ?.openDrawer();
          ProviderManager.globalProvider.isDrawerOpen = true;
        } else {
          Navigator.of(context).pop();
        }
      },
      title: GestureDetector(
        onTap: () {
          if (_dropdownMenuController.isShow) {
            _dropdownMenuController.hide();
          } else {
            _dropdownMenuController.show(0);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                "知乎热榜",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 0.1,
                  color: Theme.of(context).textTheme.titleMedium!.color,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Feedbin", style: Theme.of(context).textTheme.labelSmall),
                RotationTransition(
                  turns: CurvedAnimation(
                      parent: _dropdownAnimationController,
                      curve: Curves.linear),
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                      size: 15,
                      color: Theme.of(context).textTheme.labelSmall!.color),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        ItemBuilder.buildIconButton(
            context: context,
            icon: Icon(Icons.done_all_rounded,
                color: IconTheme.of(context).color),
            onTap: () {}),
        const SizedBox(width: 5),
        ItemBuilder.buildIconButton(
            context: context,
            icon:
                Icon(Icons.search_rounded, color: IconTheme.of(context).color),
            onTap: () {}),
        const SizedBox(width: 5),
        ItemBuilder.buildIconButton(
            context: context,
            icon: Icon(Icons.filter_list_rounded,
                color: IconTheme.of(context).color),
            onTap: () {}),
        const SizedBox(width: 5),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  bool _onScroll(ScrollNotification scrollInfo) {
    var feed = ProviderManager.rssProvider.currentRssItemList;
    if (!ModalRoute.of(context)!.isCurrent ||
        !feed.initialized ||
        feed.loading ||
        feed.allLoaded) {
      return true;
    }
    if (scrollInfo.metrics.extentAfter == 0.0 &&
        scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent * 0.8 &&
        (_lastLoadedMoreTime == null ||
            DateTime.now().difference(_lastLoadedMoreTime!).inSeconds > 1)) {
      _lastLoadedMoreTime = DateTime.now();
      feed.loadMore();
    }
    return false;
  }
}
