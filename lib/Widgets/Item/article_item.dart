import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudreader/Widgets/Item/time_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/feed.dart';
import '../../Models/rss_item.dart';
import '../../Providers/feed_content_provider.dart';
import '../../Providers/global.dart';
import '../../Screens/Content/article_detail_screen.dart';
import 'dismissible_background.dart';
import 'favicon.dart';

class ArticleItem extends StatefulWidget {
  final RSSItem item;
  final Feed feed;
  final Function openActionSheet;

  const ArticleItem(this.item, this.feed, this.openActionSheet, {super.key});

  @override
  ArticleItemState createState() => ArticleItemState();
}

class ArticleItemState extends State<ArticleItem> {
  bool pressed = false;

  void _openArticle() {
    Navigator.of(context, rootNavigator: true).popUntil((route) {
      return route.isFirst;
    });
    if (!widget.item.hasRead) {
      Global.itemsProvider.updateItem(widget.item.id, read: true);
    }
    if (widget.feed.openTarget == SourceOpenTarget.external) {
      launch(widget.item.link, forceSafariVC: false, forceWebView: false);
    } else {
      var isSource = Navigator.of(context).canPop();
      if (ArticleDetailScreen.state.currentWidget != null) {
        ArticleDetailScreen.state.currentState!.loadNewItem(
          widget.item.id,
          isSource: isSource,
        );
      } else {
        Navigator.of(context).pushNamed("/article/detail",
            arguments: Tuple2(widget.item.id, isSource));
      }
    }
  }

  void _openActionSheet() {
    HapticFeedback.mediumImpact();
    widget.openActionSheet(widget.item);
  }

  Widget _imagePlaceholderBuilder(BuildContext context, String _) {
    return Container(color: CupertinoColors.systemGrey5.resolveFrom(context));
  }

  static const _unreadIndicator = Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Icon(
      Icons.circle_rounded,
      size: 8,
      color: Colors.amber,
    ),
  );
  static const _starredIndicator = Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Icon(
      Icons.star_rounded,
      size: 9,
      color: CupertinoColors.activeBlue,
    ),
  );

  IconData? _getDismissIcon(ItemSwipeOption option) {
    switch (option) {
      case ItemSwipeOption.toggleRead:
        return widget.item.hasRead
            ? Icons.radio_button_checked
            : Icons.radio_button_unchecked;
      case ItemSwipeOption.toggleStar:
        return widget.item.starred
            ? Icons.star_outline_rounded
            : Icons.star_rounded;
      case ItemSwipeOption.share:
        return Icons.share;
      case ItemSwipeOption.openMenu:
        return Icons.more_horiz_rounded;
      case ItemSwipeOption.openExternal:
        return Icons.open_in_browser_rounded;
    }
  }

  void _performSwipeAction(ItemSwipeOption option) async {
    switch (option) {
      case ItemSwipeOption.toggleRead:
        await Future.delayed(const Duration(milliseconds: 200));
        Global.itemsProvider
            .updateItem(widget.item.id, read: !widget.item.hasRead);
        break;
      case ItemSwipeOption.toggleStar:
        await Future.delayed(const Duration(milliseconds: 200));
        Global.itemsProvider
            .updateItem(widget.item.id, starred: !widget.item.starred);
        break;
      case ItemSwipeOption.share:
        break;
      case ItemSwipeOption.openMenu:
        widget.openActionSheet(widget.item);
        break;
      case ItemSwipeOption.openExternal:
        if (!widget.item.hasRead) {
          Global.itemsProvider.updateItem(widget.item.id, read: true);
        }
        launch(widget.item.link, forceSafariVC: false, forceWebView: false);
        break;
    }
  }

  Future<bool> _onDismiss(DismissDirection direction) async {
    HapticFeedback.mediumImpact();
    if (direction == DismissDirection.startToEnd) {
      _performSwipeAction(Global.feedContentProvider.swipeR);
    } else {
      _performSwipeAction(Global.feedContentProvider.swipeL);
    }
    return false;
  }

  static const _dismissThresholds = {
    DismissDirection.horizontal: 0.25,
  };

  @override
  Widget build(BuildContext context) {
    final _descStyle = TextStyle(
      fontSize: 12,
      color: CupertinoColors.secondaryLabel.resolveFrom(context),
    );
    final _titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Global.feedContentProvider.dimRead && widget.item.hasRead
          ? CupertinoColors.secondaryLabel.resolveFrom(context)
          : CupertinoColors.label.resolveFrom(context),
    );
    final _snippetStyle = TextStyle(
      fontSize: 16,
      color: CupertinoColors.secondaryLabel.resolveFrom(context),
    );
    final infoLine = Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            widget.feed.name,
            style: _descStyle,
            overflow: TextOverflow.ellipsis,
          )),
          Row(children: [
            if (!Global.feedContentProvider.dimRead && !widget.item.hasRead)
              _unreadIndicator,
            if (widget.item.starred) _starredIndicator,
            TimeText(widget.item.date, style: _descStyle),
          ]),
        ],
      ),
    );
    final itemTexts = Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.item.title,
          style: _titleStyle,
        ),
        if (Global.feedContentProvider.showSnippet &&
            widget.item.snippet.isNotEmpty)
          Text(
            widget.item.snippet,
            style: _snippetStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
      ],
    ));
    final body = GestureDetector(
      onTapDown: (_) {
        setState(() {
          pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          pressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          pressed = false;
        });
      },
      onLongPress: _openActionSheet,
      onTap: _openArticle,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: pressed
              ? CupertinoColors.systemGrey4.resolveFrom(context)
              : CupertinoColors.systemBackground.resolveFrom(context),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 8, 0),
                    child: Favicon(widget.feed),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        infoLine,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            itemTexts,
                            if (Global.feedContentProvider.showThumb &&
                                widget.item.thumb != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.item.thumb ?? "",
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                    placeholder: _imagePlaceholderBuilder,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   color: CupertinoColors.systemBackground.resolveFrom(context),
            //   padding: const EdgeInsets.only(left: 16),
            //   child: Divider(
            //       color: CupertinoColors.systemGrey4.resolveFrom(context),
            //       height: 1),
            // ),
          ],
        ),
      ),
    );
    return Dismissible(
      key: Key("D-${widget.item.id}"),
      background: DismissibleBackground(
        _getDismissIcon(Global.feedContentProvider.swipeR) ?? Icons.add,
        true,
      ),
      secondaryBackground: DismissibleBackground(
        _getDismissIcon(Global.feedContentProvider.swipeL) ?? Icons.add,
        false,
      ),
      dismissThresholds: _dismissThresholds,
      confirmDismiss: _onDismiss,
      child: body,
    );
  }
}
