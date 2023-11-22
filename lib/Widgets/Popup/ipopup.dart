import 'package:flutter/material.dart';

import 'ipopup_child.dart';
import 'ipopup_route.dart';

class IPopup {
  static pop(BuildContext context) {
    IPopupRoute.pop(context);
  }

  static show(
    BuildContext context,
    IPopupChild child, {
    Offset? offsetLT,
    Offset? offsetRB,
    bool cancelable = true,
    bool outsideTouchCancelable = true,
    bool darkEnable = true,
    Duration duration = const Duration(milliseconds: 300),
    List<RRect>? highlights,
  }) {
    Navigator.of(context).push(
      IPopupRoute(
        child: child,
        offsetLT: offsetLT,
        offsetRB: offsetRB,
        cancelable: cancelable,
        outsideTouchCancelable: outsideTouchCancelable,
        darkEnable: darkEnable,
        duration: duration,
        highlights: highlights,
      ),
    );
  }

  static setHighlights(BuildContext context, List<RRect> highlights) {
    IPopupRoute.setHighlights(context, highlights);
  }
}
