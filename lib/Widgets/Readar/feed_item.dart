import 'package:flutter/material.dart';
import 'package:readar/Resources/theme.dart';
import 'package:readar/Widgets/Item/item_builder.dart';
import 'package:readar/Widgets/TextDrawable/text_drawable_widget.dart';

import '../../Models/feed.dart';
import '../../Utils/utils.dart';

class FeedItem extends StatefulWidget {
  const FeedItem({
    super.key,
    required this.feed,
    this.onTap,
    this.onLongPress,
    this.selected = false,
  });

  final Feed feed;

  final Function()? onTap;
  final Function()? onLongPress;
  final bool selected;

  @override
  State<StatefulWidget> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  Feed get feed => widget.feed;

  double iconSize = 16;
  double radius = 2;

  @override
  Widget build(BuildContext context) {
    return ItemBuilder.buildInk(
      color: widget.selected ? MyTheme.lightPrimaryColor : null,
      onTap: () {
        widget.onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Utils.isNotEmpty(feed.iconUrl)
                  ? ItemBuilder.buildCachedImage(
                      imageUrl: feed.iconUrl!,
                      context: context,
                      width: iconSize,
                      height: iconSize,
                      fit: BoxFit.cover,
                      showLoading: false,
                    )
                  : TextDrawable(
                      text: feed.name,
                      width: iconSize,
                      height: iconSize,
                      boxShape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(radius),
                      textStyle: MyTheme.titleSmall.apply(fontWeightDelta: -2),
                    ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                feed.name,
                style: MyTheme.titleMedium,
              ),
            ),
            if (feed.unReadCount > 0)
              Text(
                feed.unReadCount.toString(),
                style: MyTheme.labelMedium,
              ),
          ],
        ),
      ),
    );
  }
}
