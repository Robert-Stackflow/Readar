import 'package:flutter/material.dart';

import 'ipopup_child.dart';

class DropDownMenu extends StatefulWidget with IPopupChild {
  final PopController controller;

  final AnimationController? animationController;

  final Widget? child;

  final Color maskColor;

  final EdgeInsets? padding;

  DropDownMenu({
    super.key,
    this.padding,
    required this.controller,
    this.animationController,
    this.maskColor = Colors.black54,
    this.child,
  });

  @override
  DropDownMenuState createState() => DropDownMenuState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class DropDownMenuState extends State<DropDownMenu>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  double _maskColorOpacity = 0;

  @override
  void initState() {
    super.initState();
    widget.controller._bindState(this);
    _controller = widget.animationController ??
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        );
    // _animation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
    //     .animate(_controller);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _animation.addListener(_controllerListener);
    _controller.forward();
  }

  dismiss() {
    _controller.reverse();
  }

  get isOpen => _controller.isCompleted;

  void _controllerListener() {
    if (mounted) {
      setState(() {
        _maskColorOpacity = widget.maskColor.opacity * _animation.value;
      });
    }
  }

  @override
  void dispose() {
    if (widget.animationController == null) {
      _controller.dispose();
    }
    _animation.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: Stack(
        children: [
          Container(
            color: widget.maskColor.withOpacity(_maskColorOpacity),
            height: MediaQuery.of(context).size.height,
          ),
          SizeTransition(
            sizeFactor: _animation,
            child: widget.child,
          ),
          // widget.child ?? Container(),
        ],
      ),
    );
  }
}

class PopController {
  DropDownMenuState? state;

  _bindState(DropDownMenuState state) {
    this.state = state;
  }

  addListener(Function() listener) {
    state?._controller.addListener(listener);
  }

  dismiss() {
    state?.dismiss();
  }
}
