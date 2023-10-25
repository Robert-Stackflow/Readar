import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/theme.dart';

class ItemBuilder {
  static AppBar buildAppBar({
    String title = "",
    IconData leading = Icons.arrow_back_rounded,
  }) {
    return AppBar(
      elevation: 0,
      leadingWidth: 30,
      leading: Container(
        margin: const EdgeInsets.only(left: 5),
        child: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            leading,
            color: AppTheme.darkerText,
            size: 23,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      title:
          title.isNotEmpty ? Text(title, style: AppTheme.title) : Container(),
      backgroundColor: AppTheme.background,
    );
  }

  static Widget buildRadioItem({
    double radius = 10,
    bool topRadius = false,
    bool bottomRadius = false,
    required bool value,
    Color? titleColor,
    bool showIcon = false,
    IconData leading = Icons.check_box_outline_blank,
    required String title,
    String description = "",
    Function()? onTap,
    Function(bool?)? onChanged,
  }) {
    return InkWell(
      borderRadius: BorderRadius.vertical(
          top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
          bottom: bottomRadius
              ? Radius.circular(radius)
              : const Radius.circular(0)),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.05,
              style: bottomRadius ? BorderStyle.none : BorderStyle.solid,
            ),
          ),
        ),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: AppTheme.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.vertical(
              top: topRadius
                  ? Radius.circular(radius)
                  : const Radius.circular(0),
              bottom: bottomRadius
                  ? Radius.circular(radius)
                  : const Radius.circular(0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showIcon ? Icon(leading, size: 20) : Container(),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.itemTitle,
                    ),
                    description.isNotEmpty
                        ? Text(description, style: AppTheme.itemTip)
                        : Container(),
                  ],
                ),
              ),
              Transform.scale(
                scale: 0.9,
                child: CupertinoSwitch(
                  value: value,
                  activeColor: AppTheme.themeColor,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildEntryItem({
    double radius = 10,
    bool topRadius = false,
    bool bottomRadius = false,
    bool showIcon = false,
    IconData leading = Icons.home_filled,
    required String title,
    String tip = "",
    String description = "",
    Function()? onTap,
    IconData trailing = Icons.keyboard_arrow_right_rounded,
  }) {
    return InkWell(
      borderRadius: BorderRadius.vertical(
          top: topRadius ? Radius.circular(radius) : const Radius.circular(0),
          bottom: bottomRadius
              ? Radius.circular(radius)
              : const Radius.circular(0)),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.05,
              style: bottomRadius ? BorderStyle.none : BorderStyle.solid,
            ),
          ),
        ),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: AppTheme.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.vertical(
              top: topRadius
                  ? Radius.circular(radius)
                  : const Radius.circular(0),
              bottom: bottomRadius
                  ? Radius.circular(radius)
                  : const Radius.circular(0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showIcon ? Icon(leading, size: 20) : Container(),
              showIcon ? const SizedBox(width: 10) : const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.itemTitle,
                    ),
                    description.isNotEmpty
                        ? Text(description, style: AppTheme.itemTip)
                        : Container(),
                  ],
                ),
              ),
              Text(
                tip,
                style: AppTheme.itemTip,
              ),
              const SizedBox(width: 5),
              Icon(trailing, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
