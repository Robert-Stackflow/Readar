import 'dart:io';

import 'package:cloudreader/Widgets/Item/item_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';

import '../../Models/feed.dart';
import '../../Models/feed_content.dart';
import '../../Models/rss_item.dart';
import '../../Providers/feeds_provider.dart';
import '../../Providers/global.dart';
import '../../Providers/items_provider.dart';
import '../../Widgets/Custom/no_shadow_scroll_behavior.dart';
import '../../Widgets/Item/article_item.dart';

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
    with TickerProviderStateMixin {
  DateTime? _lastLoadedMoreTime;
  late RefreshController _refreshController;

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
  }

  @override
  void dispose() {
    widget.scrollTopNotifier.removeListener(_onScrollTop);
    super.dispose();
  }

  FeedContent getFeed() {
    return ModalRoute.of(context)?.settings.arguments != null
        ? Global.feedContentProvider.source
        : Global.feedContentProvider.all;
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    var feed = getFeed();
    if (feed.loading) {
      return;
    } else if (feed.allLoaded) {
      _refreshController.loadNoData();
    } else if ((_lastLoadedMoreTime == null ||
        DateTime.now().difference(_lastLoadedMoreTime!).inSeconds > 1)) {
      _lastLoadedMoreTime = DateTime.now();
      feed.loadMore().then((value) => _refreshController.loadComplete());
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

  bool _onScroll(ScrollNotification scrollInfo) {
    var feed = getFeed();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ScrollConfiguration(
        behavior: NoShadowScrollBehavior(),
        child: SmartRefresher(
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
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    var feed = getFeed();
    return ListView.builder(
      itemCount: feed.iids.length,
      itemBuilder: (content, index) {
        return Selector2<ItemsProvider, FeedsProvider, Tuple2<RSSItem, Feed>>(
          selector: (context, itemsProvider, sourcesProvider) {
            var item = itemsProvider.getItem(feed.iids[index]);
            var source = sourcesProvider.getSource(item.source);
            return Tuple2(item, source);
          },
          builder: (context, tuple, child) =>
              ArticleItem(tuple.item1, tuple.item2, () {}),
        );
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

  AppBar _buildAppBar() {
    return ItemBuilder.buildAppBar(
      context: context,
      leading: _isNavigationBarEntry()
          ? Icons.menu_rounded
          : Icons.arrow_back_rounded,
      onLeadingTap: () {
        if (_isNavigationBarEntry()) {
          Scaffold.of(context).openDrawer();
        } else {
          Navigator.of(context).pop();
        }
      },
      actions: [
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon:
              Icon(Icons.done_all_rounded, color: IconTheme.of(context).color),
          onPressed: () {},
        ),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(Icons.search_rounded, color: IconTheme.of(context).color),
          onPressed: () {},
        ),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(Icons.filter_list_rounded,
              color: IconTheme.of(context).color),
          onPressed: () {},
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
