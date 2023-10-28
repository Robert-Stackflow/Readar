import 'dart:io';

import 'package:cloudreader/Providers/feed_content_provider.dart';
import 'package:cloudreader/Utils/iprint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../Models/feed.dart';
import '../../Models/feed_content.dart';
import '../../Models/rss_item.dart';
import '../../Providers/feeds_provider.dart';
import '../../Providers/global.dart';
import '../../Providers/items_provider.dart';
import '../../Providers/sync_control.dart';
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

  static const String routeName = "/nav/home";

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with TickerProviderStateMixin {
  DateTime? _lastLoadedMore;

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
  void initState() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
    super.initState();
    widget.scrollTopNotifier.addListener(_onScrollTop);
  }

  @override
  void dispose() {
    widget.scrollTopNotifier.removeListener(_onScrollTop);
    super.dispose();
  }

  FeedContent getFeed() {
    return ModalRoute.of(context)?.settings.arguments != null
        ? Global.feedsProvider.source
        : Global.feedsProvider.all;
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
        (_lastLoadedMore == null ||
            DateTime.now().difference(_lastLoadedMore!).inSeconds > 1)) {
      _lastLoadedMore = DateTime.now();
      feed.loadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final itemList = Consumer<FeedContentProvider>(
      builder: (context, feedsProvider, child) {
        var feed = getFeed();
        IPrint.debug(feed.iids);
        return SliverList(
          delegate: SliverChildBuilderDelegate((content, index) {
            return Selector2<ItemsProvider, FeedsProvider,
                Tuple2<RSSItem, Feed>>(
              selector: (context, itemsProvider, sourcesProvider) {
                var item = itemsProvider.getItem(feed.iids[index]);
                var source = sourcesProvider.getSource(item.source);
                return Tuple2(item, source);
              },
              builder: (context, tuple, child) =>
                  ArticleItem(tuple.item1, tuple.item2, () {}),
            );
          }, childCount: feed.iids.length),
        );
      },
    );
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: CupertinoScrollbar(
          child: ScrollConfiguration(
            behavior: NoShadowScrollBehavior(),
            child: CustomScrollView(
              slivers: [
                _buildBar(),
                const SyncControl(),
                itemList,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBar() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 5),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.dehaze_rounded,
                size: 23,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            Expanded(
              child: Container(),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.headset_outlined,
                size: 23,
              ),
              onPressed: () {},
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.search_rounded,
                size: 25,
              ),
              onPressed: () {},
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.done_all_rounded,
                size: 23,
              ),
              onPressed: () {},
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.filter_list_rounded,
                size: 25,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
