import 'package:flutter/material.dart';

import '../../Utils/theme.dart';

class EntryItem extends StatefulWidget {
  EntryItem({
    super.key,
    this.radius = 10,
    this.topRadius = false,
    this.bottomRadius = false,
    this.showLeading = false,
    this.showTrailing = true,
    this.isCaption = false,
    this.leading = Icons.home_filled,
    required this.title,
    this.tip = "",
    this.description = "",
    this.onTap,
    this.trailing = Icons.keyboard_arrow_right_rounded,
  });

  double radius;
  bool topRadius;
  bool bottomRadius;
  bool showLeading;
  bool showTrailing;
  bool isCaption;
  IconData leading;
  IconData trailing;
  String title;
  String tip;
  String description;
  Function()? onTap;

  void setBottomRadius(bool value) {
    bottomRadius = value;
  }

  @override
  State<EntryItem> createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.vertical(
          top: widget.topRadius
              ? Radius.circular(widget.radius)
              : const Radius.circular(0),
          bottom: widget.bottomRadius
              ? Radius.circular(widget.radius)
              : const Radius.circular(0)),
      onTap: widget.isCaption ? null : widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.05,
              style: widget.bottomRadius ? BorderStyle.none : BorderStyle.solid,
            ),
          ),
        ),
        child: Ink(
          padding: EdgeInsets.symmetric(
              vertical: widget.isCaption ? 12 : 15, horizontal: 10),
          decoration: BoxDecoration(
            color: AppTheme.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.vertical(
              top: widget.topRadius
                  ? Radius.circular(widget.radius)
                  : const Radius.circular(0),
              bottom: widget.bottomRadius
                  ? Radius.circular(widget.radius)
                  : const Radius.circular(0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: widget.showLeading,
                child:
                    Icon(widget.leading, size: 20, color: AppTheme.darkerText),
              ),
              widget.showLeading
                  ? const SizedBox(width: 10)
                  : const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: widget.isCaption
                          ? AppTheme.itemTitleLittle
                          : AppTheme.itemTitle,
                    ),
                    widget.description.isNotEmpty
                        ? Text(widget.description, style: AppTheme.itemTip)
                        : Container(),
                  ],
                ),
              ),
              Text(
                widget.tip,
                style: AppTheme.itemTip,
              ),
              const SizedBox(width: 5),
              Visibility(
                visible: widget.showTrailing,
                child: Icon(widget.trailing, size: 20, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
