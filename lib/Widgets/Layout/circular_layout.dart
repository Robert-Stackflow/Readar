import 'dart:math';

import 'package:flutter/material.dart';

class CircularLayout extends StatelessWidget {
  final List<Widget> children;

  /// Initial angle
  final double initAngle;

  /// Arrangement direction
  final bool reverse;

  /// Scale the distance from the center of the subcomponent's circle to the center of the container's circle
  final double radiusRatio;

  /// The angle size of the container, 1 represents a circle
  final double angleRatio;

  /// Custom coordinates
  final Offset center;

  /// A Layout that makes sub-components present a circular layout
  ///
  /// * [reverse] Used to control the arrangement direction of sub-components. False means clockwise arrangement. True means counterclockwise arrangement.
  ///
  /// * [initAngle] Used to set the position of the first sub-component between 0 ~ 360
  ///
  /// * [radiusRatio] Used to adjust the distance between the center of the subcomponent and the center of the container.
  ///
  const CircularLayout({
    super.key,
    required this.children,
    this.reverse = false,
    this.radiusRatio = 1.0,
    this.initAngle = 0,
    this.angleRatio = 1.0,
    this.center = const Offset(0, 0),
  })  : assert(0.0 <= radiusRatio && radiusRatio <= 1.0),
        assert(0.0 < angleRatio && angleRatio <= 1.0),
        assert(0 <= initAngle && initAngle <= 360);

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _RingDelegate(
          count: children.length,
          initAngle: initAngle,
          reverse: reverse,
          center: center,
          radiusRatio: radiusRatio,
          angleRatio: angleRatio),
      children: [
        for (int i = 0; i < children.length; i++)
          LayoutId(id: i, child: children[i])
      ],
    );
  }
}

class _RingDelegate extends MultiChildLayoutDelegate {
  final double initAngle;
  final bool reverse;
  final int count;
  final double radiusRatio;
  final double angleRatio;
  final Offset center;

  _RingDelegate({
    required this.initAngle,
    required this.reverse,
    required this.count,
    required this.center,
    required this.radiusRatio,
    required this.angleRatio,
  });

  @override
  void performLayout(Size size) {
    /// Center point coordinates
    Offset centralPoint = Offset(size.width / 2, size.height / 2 + 43);
    // Offset centralPoint = center;

    /// Container radius reference value
    double fatherRadius = min(size.width, size.height) / 2;

    double childRadius = _getChildRadius(fatherRadius, 360 / count);

    Size constraintsSize = Size(childRadius * 2, childRadius * 2);

    /// Traverse the children to get the space they need, and get the width of the widest child and the height of the tallest child.
    /// Used to calculate an available radius r
    /// r = radius given by the parent container - the "radius" of the largest child component
    List<Size> sizeCache = [];
    double largersRadius = 0;
    for (int i = 0; i < count; i++) {
      if (!hasChild(i)) break;

      Size childSize = layoutChild(i, BoxConstraints.loose(constraintsSize));
      sizeCache.add(Size.copy(childSize));

      double radius = max(childSize.width, childSize.height) / 2;
      largersRadius = radius > largersRadius ? radius : largersRadius;
    }
    fatherRadius -= largersRadius;

    /// Place components
    for (int i = 0; i < count; i++) {
      if (!hasChild(i)) break;

      Offset offset = _getChildCenterOffset(
          centerPoint: centralPoint,
          radius: fatherRadius * radiusRatio,
          which: i,
          count: count,
          initAngle: initAngle,
          angleRatio: angleRatio,
          direction: reverse ? -1 : 1);
      // Since the drawing direction is lt-rb, in order to avoid drawing beyond the boundaries of the parent container, the "radius" of the child control itself needs to be removed.
      double cr = max(sizeCache[i].width, sizeCache[i].height) / 2;
      offset -= Offset(cr, cr);

      positionChild(i, offset);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => true;
}

/// Get the offset of the center point of the subcomponent in the container
///
/// * [centerPoint] container center point
///
/// * [radius] container radius
///
/// * [which] which child
///
/// * [count] Total number of sub-components
///
/// * [initAngle] is used to determine the starting position, the recommended value range is 0-360
///
/// * [direction] is used to determine the arrangement direction: 1 clockwise, -1 counterclockwise
///
Offset _getChildCenterOffset({
  required Offset centerPoint,
  required double radius,
  required int which,
  required int count,
  required double initAngle,
  required int direction,
  required double angleRatio,
}) {
  /// Circle center coordinates (a, b)
  /// Radius: r
  /// Radian: radian (π / 180 * angle)
  ///
  /// Find any point on the circle to be (x, y)
  /// but
  /// x = a + r * cos(radian)
  /// y = b + r * sin(radian)
  double radian = angleRatio == 1.0
      ? _radian(360 / count)
      : _radian(360 * angleRatio / (count - 1));
  double radianOffset =
      _radian(360 * ((0.75 - angleRatio / 2)) + initAngle * direction);
  double x = centerPoint.dx + radius * cos(radian * which + radianOffset);
  double y = centerPoint.dy + radius * sin(radian * which + radianOffset);

  if (count == 3 && which == 1) {
    y += 20;
  }
  if (count == 5) {
    switch (which) {
      case 0:
        x -= 10;
        y -= 5;
        break;
      case 1:
      case 2:
      case 3:
        break;
      case 4:
        x += 10;
        y -= 5;
        break;
    }
  }
  return Offset(x, y);
}

/// Get the child radius. Calculated based on the formula of the largest circle within the sector radius
double _getChildRadius(double r, double a) {
  /// It is greater than 180 because only one child is placed, and because the formula cannot calculate the obtuse angle, just return the radius of the container.
  if (a > 180) return r;

  /// The radius of the sector is R, the central angle is A, and the radius of the inscribed circle is r.
  /// SIN(A/2)=r/(R-r)
  /// r=(R-r)*SIN(A/2)
  /// r=R*SIN(A/2)-r*SIN(A/2)
  /// r+r*SIN(A/2)=R*SIN(A/2)
  /// r=(R*SIN(A/2))/(1+SIN(A/2))
  return (r * sin(_radian(a / 2))) / (1 + sin(_radian(a / 2)));
}

/// Convert angle to radian
double _radian(double angle) {
  return pi / 180 * angle;
}
