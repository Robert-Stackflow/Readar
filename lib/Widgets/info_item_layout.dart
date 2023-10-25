import 'package:cloudreader/Utils/theme.dart';
import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class InfoItemLayout extends StatefulWidget {
  const InfoItemLayout({
    super.key,
    this.backgroundColor = Colors.transparent,
    required this.onExpansionChanged,
    this.children = const <Widget>[],
    this.title,
    this.content,
    required this.isExpanded,
  });

  final ValueChanged<bool> onExpansionChanged;

  final List<Widget> children;

  final Color backgroundColor;

  final bool isExpanded;

  final String? title;
  final String? content;

  @override
  InfoItemLayoutState createState() => InfoItemLayoutState();
}

class InfoItemLayoutState extends State<InfoItemLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _isExpanded = widget.isExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(String tag, bool newValue) {
    setState(() {
      _isExpanded = newValue;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
        });
      }
      PageStorage.of(context).writeState(context, _isExpanded);
    });
    widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              _handleTap("dd", !_isExpanded);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkerText,
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _controller.value * 1.55,
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _content() {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: SelectableText(
        widget.content ?? "",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
          color: AppTheme.darkerText.withOpacity(0.8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _handleTap("tag", _isExpanded);
    final bool closed = !_isExpanded;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: [_content()]),
    );
  }
}
