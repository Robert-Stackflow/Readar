import 'package:flutter/material.dart';
import 'package:readar/Utils/app_provider.dart';
import 'package:readar/Utils/responsive_util.dart';

import '../Widgets/Custom/custom_cupertino_route.dart';
import '../Widgets/Dialog/dialog_builder.dart';
import '../Widgets/Dialog/widgets/dialog_wrapper_widget.dart';

class RouteUtil {
  static pushMaterialRoute(
    BuildContext context,
    Widget page, {
    Function(dynamic)? onThen,
    bool popAll = false,
  }) {
    return Navigator.push(
            context, MaterialPageRoute(builder: (context) => page))
        .then(onThen ?? (_) => {});
  }

  static pushCupertinoRoute(
    BuildContext context,
    Widget page, {
    Function(dynamic)? onThen,
    bool popAll = false,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ResponsiveUtil.isLandscape()) {
        pushFadeRoute(context, page, onThen: onThen);
      } else {
        if (popAll) {
          Navigator.pushAndRemoveUntil(
              context,
              CustomCupertinoPageRoute(builder: (context) => page),
              (_) => false).then(onThen ?? (_) => {});
        } else {
          Navigator.push(
                  context, CustomCupertinoPageRoute(builder: (context) => page))
              .then(onThen ?? (_) => {});
        }
      }
    });
  }

  static pushPanelCupertinoRoute(BuildContext context, Widget page) {
    panelScreenState?.pushPage(page);
  }

  static getFadeRoute(
    Widget page, {
    Duration? duration,
  }) {
    return PageRouteBuilder(
      transitionDuration: duration ?? const Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation secondaryAnimation) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: page,
        );
      },
    );
  }

  static pushFadeRoute(
    BuildContext context,
    Widget page, {
    Function(dynamic)? onThen,
    bool popAll = false,
  }) {
    return Navigator.push(
      context,
      getFadeRoute(page),
    ).then(onThen ?? (_) => {});
  }

  static pushDialogRoute(
    BuildContext context,
    Widget page, {
    bool barrierDismissible = true,
    bool showClose = true,
    bool fullScreen = false,
    double? preferMinWidth,
    double? preferMinHeight,
    Function(dynamic)? onThen,
    GlobalKey<DialogWrapperWidgetState>? overrideDialogNavigatorKey,
    bool useFade = false,
    bool popAll = false,
  }) {
    if (ResponsiveUtil.isLandscape()) {
      if (overrideDialogNavigatorKey == null && dialogNavigatorState != null) {
        dialogNavigatorState!.pushPage(page);
      } else {
        DialogBuilder.showPageDialog(
          context,
          child: page,
          barrierDismissible: barrierDismissible,
          showClose: showClose,
          fullScreen: fullScreen,
          onThen: onThen,
          preferMinWidth: preferMinWidth,
          preferMinHeight: preferMinHeight,
          overrideDialogNavigatorKey: overrideDialogNavigatorKey,
        );
      }
    } else {
      if (useFade) {
        pushFadeRoute(context, page, onThen: onThen, popAll: popAll);
      } else {
        pushCupertinoRoute(context, page, onThen: onThen, popAll: popAll);
      }
    }
  }
}