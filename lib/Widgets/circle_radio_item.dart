import 'package:cloudreader/Utils/theme.dart';
import 'package:flutter/material.dart';

class CircleRadioItem<T> extends StatelessWidget {
  const CircleRadioItem({
    super.key,
    required this.value,
    required this.radius,
    this.child,
    this.isSelected = false,
    this.unselectedBorderColor = AppTheme.themeColor,
    this.borderColor = AppTheme.themeColor,
    this.borderWidth = 2.0,
    this.unselectedColor = AppTheme.background,
    this.color = AppTheme.themeColor,
    this.groupValue,
    this.onChanged,
  });

  final T value;

  final T? groupValue;

  final ValueChanged<T?>? onChanged;

  final double radius;

  final bool? isSelected;

  final Color? unselectedBorderColor;

  final Color? borderColor;

  final double? borderWidth;

  final Color? unselectedColor;

  final Color? color;

  final Widget? child;

  bool get checked => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged != null
          ? () {
              if (checked) {
                onChanged!(null);
                return;
              }
              if (!checked) {
                onChanged!(value);
              }
            }
          : null,
      child: Container(
        constraints: BoxConstraints(
          minHeight: radius * 2,
          maxHeight: radius * 2,
          minWidth: radius * 2,
          maxWidth: radius * 2,
        ),
        width: radius * 2,
        height: radius * 2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
              color: isSelected! ? borderColor! : unselectedBorderColor!,
              width: borderWidth!),
          color: isSelected! ? color : unselectedColor,
        ),
        child: child,
      ),
    );
  }
}
