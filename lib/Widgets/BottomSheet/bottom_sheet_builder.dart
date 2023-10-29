import 'package:flutter/material.dart';

class BottomSheetBuilder {
  static void showListBottomSheet(
    BuildContext context,
    WidgetBuilder builder, {
    Color? backgroundColor,
    ShapeBorder shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
  }) {
    // backgroundColor ??= Theme.of(context).scaffoldBackgroundColor;
    showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      shape: shape,
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top),
      builder: builder,
    );
  }
}
