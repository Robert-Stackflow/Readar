import 'dart:io';

import 'package:afar/Providers/rss_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Models/feed.dart';
import '../../Models/feed_setting.dart';
import '../../Models/rss_item.dart';
import '../../Providers/provider_manager.dart';
import '../../Utils/store.dart';
import '../../Widgets/Item/toolbar.dart';
import '../../generated/l10n.dart';

class ArticleDetailScreen extends StatefulWidget {
  static final GlobalKey<ArticleDetailScreenState> state = GlobalKey();

  ArticleDetailScreen() : super(key: state);

  static const String routeName = "/article/detail";

  @override
  ArticleDetailScreenState createState() => ArticleDetailScreenState();
}

enum ArticleLoadState { loading, success, failure }

class ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late WebViewController _controller;
  int requestId = 0;
  ArticleLoadState loaded = ArticleLoadState.loading;
  bool navigated = false;
  CrawlType? _target;
  late String iid;
  late bool isSourceFeed;

  void loadNewItem(String id, {bool? isSource}) {
    if (!ProviderManager.rssProvider.currentRssServiceManager
        .getItem(id)
        .hasRead) {
      ProviderManager.rssProvider.currentRssServiceManager
          .updateItem(id, read: true);
    }
    setState(() {
      iid = id;
      loaded = ArticleLoadState.loading;
      navigated = false;
      _target = null;
      if (isSource != null) isSourceFeed = isSource;
    });
  }

  Future<NavigationDecision> _onNavigate(NavigationRequest request) async {
    if (navigated && request.isForMainFrame) {
      //TODO 是否内置浏览器
      const internal = true;
      await launch(request.url,
          forceSafariVC: internal, forceWebView: internal);
      return NavigationDecision.prevent;
    } else {
      return NavigationDecision.navigate;
    }
  }

  void _loadHtml(RssItem item, Feed source, {loadFull = false}) async {
    var localUrl =
        "http://${ProviderManager.address}:${ProviderManager.port}/article/article.html";
    var currId = requestId;
    String a;
    if (loadFull) {
      try {
        var uri = Uri.parse(item.url);
        var html = (await http.get(uri)).body;
        a = Uri.encodeComponent(html);
      } catch (exp) {
        if (mounted && currId == requestId) {
          setState(() {
            loaded = ArticleLoadState.failure;
          });
        }
        return;
      }
    } else {
      a = Uri.encodeComponent(item.content);
    }
    if (!mounted || currId != requestId) return;
    var h =
        '<p id="source">${source.name}${(item.creator != null && item.creator!.isNotEmpty) ? ' / ${item.creator}' : ''}</p>';
    h += '<p id="title">${item.title}</p>';
    h +=
        '<p id="date">${DateFormat.yMd(Localizations.localeOf(context).toString()).add_Hm().format(item.date)}</p>';
    h += '<article></article>';
    h = Uri.encodeComponent(h);
    var s = Store.getArticleFontSize();
    localUrl += "?a=$a&h=$h&s=$s&u=${item.url}&m=${loadFull ? 1 : 0}";
    if (Platform.isAndroid ||
        ProviderManager.globalProvider.getBrightness() != null) {
      var brightness = ProviderManager.currentBrightness(context);
      localUrl += "&t=${brightness.index}";
    }
    _controller.loadUrl(localUrl);
  }

  void _onPageReady(_) async {
    if (Platform.isAndroid ||
        ProviderManager.globalProvider.getBrightness() != null) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    setState(() {
      loaded = ArticleLoadState.success;
    });
    if (_target == CrawlType.rss || _target == CrawlType.full) {
      navigated = true;
    }
  }

  void _onWebpageReady(_) {
    if (loaded == ArticleLoadState.success) navigated = true;
  }

  void _setOpenTarget(Feed source, {CrawlType? target}) {
    setState(() {
      _target = target ?? (source.feedSetting?.crawlType ?? CrawlType.web);
    });
  }

  void _loadOpenTarget(RssItem item, Feed source) {
    setState(() {
      requestId += 1;
      loaded = ArticleLoadState.loading;
      navigated = false;
    });
    switch (_target) {
      case CrawlType.unspecified:
      case CrawlType.rss:
        _loadHtml(item, source);
        break;
      case CrawlType.full:
        _loadHtml(item, source, loadFull: true);
        break;
      case CrawlType.web:
      case CrawlType.external:
        _controller.loadUrl(item.url);
        break;
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Tuple2<String, bool> arguments =
        ModalRoute.of(context)?.settings.arguments as Tuple2<String, bool>;
    iid = arguments.item1;
    isSourceFeed = arguments.item2;
    final viewOptions = {
      0: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          Icons.rss_feed,
          semanticLabel: "RSS内容",
        ),
      ),
      1: const Icon(
        Icons.article_outlined,
        semanticLabel: "加载全文",
      ),
      2: const Icon(
        Icons.language,
        semanticLabel: "加载网页",
      ),
    };
    return Selector<RssProvider, Tuple2<RssItem, Feed>>(
      selector: (context, rssProvider) {
        var item = rssProvider.currentRssServiceManager.getItem(iid);
        var source = rssProvider.currentRssServiceManager.getFeed(item.feedFid);
        return Tuple2(item, source);
      },
      builder: (context, tuple, child) {
        var item = tuple.item1;
        var source = tuple.item2;
        _target ??= source.feedSetting?.crawlType;
        final body = SafeArea(
          bottom: false,
          child: IndexedStack(
            index: loaded.index,
            children: [
              const Center(child: CupertinoActivityIndicator()),
              WebView(
                key: Key("a-$iid-${_target?.index}"),
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                  _loadOpenTarget(item, source);
                },
                onPageStarted: _onPageReady,
                onPageFinished: _onWebpageReady,
                navigationDelegate: _onNavigate,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "发生错误",
                      style: TextStyle(
                          color: CupertinoColors.label.resolveFrom(context)),
                    ),
                    CupertinoButton(
                      child: const Text("重试"),
                      onPressed: () {
                        _loadOpenTarget(item, source);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemBackground,
            middle: CupertinoSlidingSegmentedControl(
              children: viewOptions,
              onValueChanged: (v) {
                _setOpenTarget(source, target: CrawlType.values[v ?? 0]);
              },
              groupValue: _target?.index,
            ),
          ),
          child: Consumer<RssProvider>(
            child: body,
            builder: (context, feedContentProvider, child) {
              final feed = isSourceFeed
                  ? feedContentProvider.currentRssItemList
                  : feedContentProvider.currentRssItemList;
              var idx = feed.iids.indexOf(iid);
              return CupertinoToolbar(
                items: [
                  CupertinoToolbarItem(
                    icon: item.hasRead
                        ? Icons.check_circle_outline_rounded
                        : Icons.circle_outlined,
                    semanticLabel: item.hasRead ? "标为未读" : "标为已读",
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      ProviderManager.rssProvider.currentRssServiceManager
                          .updateItem(item.iid, read: !item.hasRead);
                    },
                  ),
                  CupertinoToolbarItem(
                    icon: item.starred
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    semanticLabel: item.starred ? S.of(context).star : "取消星标",
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      ProviderManager.rssProvider.currentRssServiceManager
                          .updateItem(item.iid, starred: !item.starred);
                    },
                  ),
                  CupertinoToolbarItem(
                    icon: Icons.share,
                    semanticLabel: "分享",
                    onPressed: () {
                      final media = MediaQuery.of(context);
                      Share.share(item.url,
                          sharePositionOrigin: Rect.fromLTWH(
                              media.size.width -
                                  MediaQuery.of(context).size.width / 2,
                              media.size.height - media.padding.bottom - 54,
                              0,
                              0));
                    },
                  ),
                  CupertinoToolbarItem(
                    icon: Icons.keyboard_arrow_up_rounded,
                    semanticLabel: "上一个",
                    onPressed: idx <= 0
                        ? () {}
                        : () {
                            loadNewItem(feed.iids[idx - 1]);
                          },
                  ),
                  CupertinoToolbarItem(
                    icon: Icons.keyboard_arrow_down_rounded,
                    semanticLabel: "下一个",
                    onPressed: (idx == -1 ||
                            (idx == feed.iids.length - 1 && feed.allLoaded))
                        ? () {}
                        : () async {
                            if (idx == feed.iids.length - 1) {
                              await feed.loadMore();
                            }
                            idx = feed.iids.indexOf(iid);
                            if (idx != feed.iids.length - 1) {
                              loadNewItem(feed.iids[idx + 1]);
                            }
                          },
                  ),
                ],
                body: child ?? Container(),
              );
            },
          ),
        );
      },
    );
  }
}
