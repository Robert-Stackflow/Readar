import 'package:cloudreader/Resources/gaps.dart';
import 'package:flutter/material.dart';

import '../Scaffold/my_appbar.dart';

class ItemBuilder {
  static MyAppBar buildSimpleAppBar({
    String title = "",
    IconData leading = Icons.arrow_back_rounded,
    List<Widget>? actions,
    required BuildContext context,
  }) {
    return MyAppBar(
      backgroundColor: Theme
          .of(context)
          .appBarTheme
          .backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        child: buildIconButton(
          context: context,
          icon: Icon(leading, color: IconTheme
              .of(context)
              .color),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: title.isNotEmpty
          ? Container(
        margin: const EdgeInsets.only(left: 5),
        child:
        Text(title, style: Theme
            .of(context)
            .textTheme
            .titleMedium),
      )
          : Container(),
      actions: actions,
    );
  }

  static MyAppBar buildAppBar({
    Widget? title,
    IconData leading = Icons.arrow_back_rounded,
    Function()? onLeadingTap,
    List<Widget>? actions,
    required BuildContext context,
  }) {
    return MyAppBar(
      backgroundColor: Theme
          .of(context)
          .appBarTheme
          .backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        child: buildIconButton(
          context: context,
          icon: Icon(leading, color: IconTheme
              .of(context)
              .color),
          onTap: onLeadingTap,
        ),
      ),
      title: title,
      actions: actions,
    );
  }

  static Widget buildIconButton({
    required BuildContext context,
    required Icon icon,
    required Function()? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: Ink(
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: icon,
          ),
        ),
      ),
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
    double trailingLeftMargin = 5,
    double padding = 15,
    required BuildContext context,
  }) {
    assert(padding > 5);
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
          bottom:
          bottomRadius ? Radius.circular(radius) : const Radius.circular(0),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .canvasColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.vertical(
            top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
            bottom: bottomRadius
                ? Radius.circular(radius)
                : const Radius.circular(0),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.vertical(
              top: topRadius
                  ? Radius.circular(radius)
                  : const Radius.circular(0),
              bottom: bottomRadius
                  ? Radius.circular(radius)
                  : const Radius.circular(0)),
          onTap: onTap,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: description.isNotEmpty ? padding : padding - 5,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: showLeading,
                      child: Icon(leading,
                          size: 20, color: IconTheme
                              .of(context)
                              .color),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium,
                          ),
                          description.isNotEmpty
                              ? Text(description,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleSmall)
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(width: trailingLeftMargin),
                    Transform.scale(
                      scale: 0.9,
                      child: Switch(
                        value: value,
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
                      color: Theme
                          .of(context)
                          .dividerColor,
                      width: 0.5,
                      style:
                      bottomRadius ? BorderStyle.none : BorderStyle.solid,
                    ),
                  ),
                ),
              )
            ],
          ),
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
    double trailingLeftMargin = 5,
    bool dividerPadding = true,
    IconData trailing = Icons.keyboard_arrow_right_rounded,
  }) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
          bottom:
          bottomRadius ? Radius.circular(radius) : const Radius.circular(0),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme
              .of(context)
              .canvasColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.vertical(
            top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
            bottom: bottomRadius
                ? Radius.circular(radius)
                : const Radius.circular(0),
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.vertical(
            top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
            bottom: bottomRadius
                ? Radius.circular(radius)
                : const Radius.circular(0),
          ),
          child: Column(
            children: [
              Container(
                padding:
                EdgeInsets.symmetric(vertical: padding, horizontal: 10),
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
                                ? Theme
                                .of(context)
                                .textTheme
                                .titleSmall
                                : Theme
                                .of(context)
                                .textTheme
                                .titleMedium,
                          ),
                          description.isNotEmpty
                              ? Text(description,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleSmall)
                              : Container(),
                        ],
                      ),
                    ),
                    isCaption || tip.isEmpty
                        ? MyGaps.empty
                        : const SizedBox(width: 50),
                    Text(
                      tip,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall,
                    ),
                    SizedBox(width: showTrailing ? trailingLeftMargin : 0),
                    Visibility(
                      visible: showTrailing,
                      child: Icon(trailing,
                          size: 20,
                          color: Theme
                              .of(context)
                              .textTheme
                              .titleSmall
                              ?.color),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                EdgeInsets.symmetric(horizontal: dividerPadding ? 10 : 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme
                          .of(context)
                          .dividerColor,
                      width: 0.5,
                      style:
                      bottomRadius ? BorderStyle.none : BorderStyle.solid,
                    ),
                  ),
                ),
              )
            ],
          ),
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
      padding: 10,
      isCaption: true,
      dividerPadding: false,
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
        color: Theme
            .of(context)
            .canvasColor,
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
              color: Theme
                  .of(context)
                  .dividerColor,
              width: 0.05,
              style: bottomRadius ? BorderStyle.none : BorderStyle.solid,
            ),
            top: BorderSide(
              color: Theme
                  .of(context)
                  .dividerColor,
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
