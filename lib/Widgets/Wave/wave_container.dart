import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart' as vector;

class WaveContainer extends StatelessWidget {
  final double height;
  final double width;
  final int xOffset;
  final int yOffset;
  final Color color;
  final EdgeInsetsGeometry margin;
  final Duration duration;

  const WaveContainer({
    super.key,
    required this.height,
    required this.width,
    required this.xOffset,
    required this.yOffset,
    required this.color,
    required this.duration,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    Size size = Size(MediaQuery.of(context).size.width, 200.0);

    return Wave(
      height: height,
      width: width,
      size: size,
      yOffset: yOffset,
      xOffset: xOffset,
      color: color,
      margin: margin,
      duration: duration,
    );
  }
}

class Wave extends StatefulWidget {
  final double height;
  final double width;
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;
  final EdgeInsetsGeometry margin;
  final Duration duration;

  const Wave({
    super.key,
    required this.height,
    required this.width,
    required this.size,
    required this.xOffset,
    required this.yOffset,
    required this.color,
    required this.margin,
    required this.duration,
  });

  @override
  WaveState createState() => WaveState();
}

class WaveState extends State<Wave> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        final dx = i.toDouble() + widget.xOffset;
        final dy = sin((animationController.value * 360 - i) %
                    360 *
                    vector.degrees2Radians) *
                20 +
            50 +
            widget.yOffset;

        animList1.add(Offset(dx, dy));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => ClipPath(
          clipper: WaveClipper(
            animationController.value,
            animList1,
          ),
          child: Container(
            height: widget.height,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
