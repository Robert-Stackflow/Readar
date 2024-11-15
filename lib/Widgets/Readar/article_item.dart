import 'package:flutter/material.dart';
import 'package:readar/Resources/theme.dart';
import 'package:readar/Widgets/Item/item_builder.dart';

import '../../Models/article.dart';
import '../../Utils/utils.dart';

class ArticleItem extends StatefulWidget {
  const ArticleItem({
    super.key,
    required this.article,
    this.onTap,
    this.onLongPress,
  });

  final Article article;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  State<StatefulWidget> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return ItemBuilder.buildInk(
      borderRadius: BorderRadius.zero,
      onTap: (){
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onSecondaryTap: (){
        if (widget.onLongPress != null) {
          widget.onLongPress!();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          children: [
            if (Utils.isNotEmpty(widget.article.thumb))
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: ItemBuilder.buildCachedImage(
                  imageUrl: widget.article.thumb!,
                  context: context,
                  showLoading: false,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  simpleError: true,
                ),
              ),
            if (Utils.isNotEmpty(widget.article.thumb)) SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MyTheme.titleMedium,
                  ),
                  Text(
                    Utils.extractTextFromHtml(widget.article.snippet),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MyTheme.bodySmall,
                  ),
                ],
              ),
            ),
            // 星标
            if (widget.article.starred)
              Icon(
                Icons.star,
                color: Colors.orange,
              ),
            // 已读
            if (widget.article.read)
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
