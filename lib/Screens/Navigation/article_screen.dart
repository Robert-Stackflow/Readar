import 'dart:io';

import 'package:cloudreader/Models/rss_service.dart';
import 'package:cloudreader/Providers/global_provider.dart';
import 'package:cloudreader/Providers/rss_provider.dart';
import 'package:cloudreader/Resources/gaps.dart';
import 'package:cloudreader/Widgets/Item/item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';

import '../../Models/feed.dart';
import '../../Providers/provider_manager.dart';
import '../../Widgets/Custom/no_shadow_scroll_behavior.dart';
import '../../Widgets/Item/article_item.dart';
import '../../Widgets/Popup/dropdown_menu.dart';
import '../../Widgets/Popup/ipopup.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  static const String routeName = "/nav/article";

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  DateTime? _lastLoadedMoreTime;
  late RefreshController _refreshController;
  late PopController _dropdownController;
  late final AnimationController _dropdownAnimationController;
  late RssService? _currentRssService;
  List<Feed> _currentFeedList = [];
  final GlobalKey _appbarKey = GlobalKey();

  @override
  void initState() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _dropdownAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 0,
      lowerBound: 0,
      upperBound: 0.5,
    );
    _dropdownController = PopController();
    refreshCurrentRssService(
        ProviderManager.rssProvider.currentRssServiceManager.rssService);
  }

  @override
  bool get wantKeepAlive => true;

  void refreshCurrentRssService(RssService? value) {
    setState(() {
      _currentRssService = value;
      _currentFeedList = ProviderManager.rssProvider
          .getRssServiceManager(_currentRssService)
          .getFeeds();
    });
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
        _refreshController.loadComplete();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: ScrollConfiguration(
          behavior: NoShadowScrollBehavior(),
          child: Consumer2<GlobalProvider, RssProvider>(
            builder: (context, globalProvider, rssProvider, child) =>
                SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: MaterialClassicHeader(
                backgroundColor: Theme.of(context).canvasColor,
                color: Theme.of(context).primaryColor,
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: _buildRssItemList(rssProvider),
            ),
          ),
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
        padding: EdgeInsets.zero,
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
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Material(
            child: Ink(
              decoration: BoxDecoration(color: Theme.of(context).canvasColor),
              child: InkWell(
                onTap: () {
                  ProviderManager.rssProvider
                      .loadRssItemListByFid(_currentFeedList[index].fid);
                  IPopup.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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

  Widget _buildRssItemList(RssProvider rssProvider) {
    return ListView.builder(
      itemCount: rssProvider.currentRssItemList.iids.length,
      itemBuilder: (content, index) {
        var item = ProviderManager.rssProvider.currentRssServiceManager
            .getItem(rssProvider.currentRssItemList.iids[index]);
        var tuple = Tuple2(
            item,
            ProviderManager.rssProvider.currentRssServiceManager
                .getFeed(item.feedFid));
        return ArticleItem(tuple.item1, tuple.item2, (_) {},
            topMargin: index == 0);
      },
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

  PreferredSizeWidget _buildAppBar() {
    return ItemBuilder.buildAppBar(
      key: _appbarKey,
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
          _showDropdownMenu();
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
                color: Theme.of(context).iconTheme.color),
            onTap: () {}),
        const SizedBox(width: 5),
        ItemBuilder.buildIconButton(
            context: context,
            icon: Icon(Icons.search_rounded,
                color: Theme.of(context).iconTheme.color),
            onTap: () {}),
        const SizedBox(width: 5),
        ItemBuilder.buildIconButton(
            context: context,
            icon: Icon(Icons.filter_list_rounded,
                color: Theme.of(context).iconTheme.color),
            onTap: () {}),
        const SizedBox(width: 5),
      ],
    );
  }

  _showDropdownMenu() {
    double height = MediaQuery.of(context).padding.top +
        (_appbarKey.currentWidget as PreferredSizeWidget).preferredSize.height;
    IPopup.show(
      context,
      DropDownMenu(
        padding: EdgeInsets.only(top: height),
        animationController: _dropdownAnimationController,
        controller: _dropdownController,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            color: Theme.of(context).canvasColor,
            margin: EdgeInsets.only(top: height + 314.5),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Selector<RssProvider, List<RssService>>(
              selector: (context, rssProvider) => rssProvider.rssServices,
              builder: (context, rssServices, _) => rssServices.isNotEmpty
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildFeedServiceList(rssServices),
                        MyGaps.verticleDivider(context),
                        _buildFeedList(),
                      ],
                    )
                  : _buildFeedServceNull(),
            ),
          ),
        ),
      ),
      offsetLT: Offset(0, height),
    );
  }
}
