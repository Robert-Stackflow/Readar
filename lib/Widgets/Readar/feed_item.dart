import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:readar/Resources/theme.dart';
import 'package:readar/Utils/uri_util.dart';
import 'package:readar/Widgets/BottomSheet/bottom_sheet_builder.dart';
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

  final FeedModel feed;

  final Function()? onTap;
  final Function()? onLongPress;
  final bool selected;

  @override
  State<StatefulWidget> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  FeedModel get feed => widget.feed;

  double iconSize = 16;
  double iconRadius = 2;
  double containerRadius = 8;

  GenericContextMenu _buildMoreButtons() {
    return GenericContextMenu(
      buttonConfigs: [
        ContextMenuButtonConfig(
          "全部标记为已读",
          iconData: Icons.done_all_rounded,
          onPressed: () {},
        ),
        ContextMenuButtonConfig.divider(),
        ContextMenuButtonConfig(
          "编辑",
          iconData: Icons.edit_rounded,
          onPressed: () {},
        ),
        ContextMenuButtonConfig(
          "取消订阅",
          iconData: Icons.unsubscribe,
          onPressed: () {},
        ),
        ContextMenuButtonConfig.divider(),
        ContextMenuButtonConfig(
          "在浏览器中打开订阅源",
          iconData: Icons.open_in_browser_rounded,
          onPressed: () {
            UriUtil.openExternal(feed.url);
          },
        ),
        ContextMenuButtonConfig(
          "复制链接",
          iconData: Icons.link_rounded,
          onPressed: () {
            Utils.copy(context, feed.url);
          },
        ),
        ContextMenuButtonConfig(
          "复制UID",
          iconData: Icons.copy_rounded,
          onPressed: () {
            Utils.copy(context, feed.uid);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ItemBuilder.buildInk(
      color: widget.selected ? MyTheme.lightPrimaryColor : Colors.transparent,
      borderRadius: BorderRadius.circular(containerRadius),
      onTap: () {
        widget.onTap?.call();
      },
      onSecondaryTap: () {
        BottomSheetBuilder.showContextMenu(context, _buildMoreButtons());
      },
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(containerRadius)),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(iconRadius),
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
                      borderRadius: BorderRadius.circular(iconRadius),
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
