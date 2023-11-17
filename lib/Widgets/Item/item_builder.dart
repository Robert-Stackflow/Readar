import 'package:cloudreader/Resources/gaps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBuilder {
  static AppBar buildSimpleAppBar({
    String title = "",
    IconData leading = Icons.arrow_back_rounded,
    List<Widget>? actions,
    required BuildContext context,
  }) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      leadingWidth: 30,
      leading: Container(
        margin: const EdgeInsets.only(left: 5),
        child: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(leading, color: IconTheme.of(context).color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: title.isNotEmpty
          ? Text(title, style: Theme.of(context).textTheme.titleMedium)
          : Container(),
      actions: actions,
    );
  }

  static AppBar buildAppBar({
    Widget? title,
    IconData leading = Icons.arrow_back_rounded,
    Function()? onLeadingTap,
    List<Widget>? actions,
    required BuildContext context,
  }) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0.3,
      leadingWidth: 30,
      leading: Container(
        margin: const EdgeInsets.only(left: 5),
        child: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(leading, color: IconTheme.of(context).color),
          onPressed: onLeadingTap,
        ),
      ),
      title: title,
      actions: actions,
    );
  }

  static Widget buildRadioItem({
    double radius = 10,
    bool topRadius = false,
    bool bottomRadius = false,
    required bool value,
    Color? titleColor,
    bool showLeading = false,
    IconData leading = Icons.check_box_outline_blank,
    required String title,
    String description = "",
    Function()? onTap,
    Function(bool?)? onChanged,
    required BuildContext context,
  }) {
    return Ink(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.vertical(
          top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
          bottom:
              bottomRadius ? Radius.circular(radius) : const Radius.circular(0),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.vertical(
            top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
            bottom: bottomRadius
                ? Radius.circular(radius)
                : const Radius.circular(0)),
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: description.isNotEmpty ? 16 : 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: showLeading,
                    child: Icon(leading,
                        size: 20, color: IconTheme.of(context).color),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        description.isNotEmpty
                            ? Text(description,
                                style: Theme.of(context).textTheme.titleSmall)
                            : Container(),
                      ],
                    ),
                  ),
                  Transform.scale(
                    scale: 0.9,
                    child: CupertinoSwitch(
                      value: value,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 0.5,
                    style: bottomRadius ? BorderStyle.none : BorderStyle.solid,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget buildEntryItem({
    required BuildContext context,
    double radius = 10,
    bool topRadius = false,
    bool bottomRadius = false,
    bool showLeading = false,
    bool showTrailing = true,
    bool isCaption = false,
    Color? backgroundColor,
    IconData leading = Icons.home_filled,
    required String title,
    String tip = "",
    String description = "",
    Function()? onTap,
    double padding = 18,
    IconData trailing = Icons.keyboard_arrow_right_rounded,
  }) {
    return Ink(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).canvasColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.vertical(
          top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
          bottom:
              bottomRadius ? Radius.circular(radius) : const Radius.circular(0),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
          bottom:
              bottomRadius ? Radius.circular(radius) : const Radius.circular(0),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: padding, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: showLeading,
                    child: Icon(leading, size: 20),
                  ),
                  showLeading
                      ? const SizedBox(width: 10)
                      : const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: isCaption
                              ? Theme.of(context).textTheme.titleSmall
                              : Theme.of(context).textTheme.titleMedium,
                        ),
                        description.isNotEmpty
                            ? Text(description,
                                style: Theme.of(context).textTheme.titleSmall)
                            : Container(),
                      ],
                    ),
                  ),
                  isCaption ? MyGaps.empty : const SizedBox(width: 50),
                  Text(
                    tip,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: 5),
                  Visibility(
                    visible: showTrailing,
                    child: Icon(trailing,
                        size: 20,
                        color: Theme.of(context).textTheme.titleSmall?.color),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: isCaption ? 0 : 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 0.5,
                    style: bottomRadius ? BorderStyle.none : BorderStyle.solid,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget buildCaptionItem({
    required BuildContext context,
    double radius = 10,
    bool topRadius = true,
    bool bottomRadius = false,
    bool showLeading = false,
    bool showTrailing = true,
    IconData leading = Icons.home_filled,
    required String title,
    IconData trailing = Icons.keyboard_arrow_right_rounded,
  }) {
    return buildEntryItem(
      context: context,
      title: title,
      radius: radius,
      topRadius: topRadius,
      bottomRadius: bottomRadius,
      showTrailing: false,
      showLeading: showLeading,
      onTap: null,
      leading: leading,
      trailing: trailing,
      padding: 15,
      isCaption: true,
    );
  }

  static Widget buildContainerItem({
    double radius = 10,
    bool topRadius = false,
    bool bottomRadius = false,
    required Widget child,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.vertical(
          top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
          bottom:
              bottomRadius ? Radius.circular(radius) : const Radius.circular(0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.05,
              style: bottomRadius ? BorderStyle.none : BorderStyle.solid,
            ),
            top: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.05,
              style: topRadius ? BorderStyle.none : BorderStyle.solid,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
