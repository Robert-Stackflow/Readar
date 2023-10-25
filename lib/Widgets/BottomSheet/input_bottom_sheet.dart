import 'package:cloudreader/Utils/theme.dart';
import 'package:flutter/material.dart';

class InputBottomSheet extends StatefulWidget {
  const InputBottomSheet({
    super.key,
    this.maxLines = 5,
    this.minLines = 1,
    this.hint,
    this.controller,
    required this.buttonText,
    this.onConfirm,
    required this.text,
  });

  final String? hint;
  final String text;
  final int maxLines;
  final int minLines;
  final Function(String)? onConfirm;
  final TextEditingController? controller;
  final String buttonText;

  @override
  InputBottomSheetState createState() => InputBottomSheetState();
}

class InputBottomSheetState extends State<InputBottomSheet> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.value = TextEditingValue(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                controller: controller,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                cursorColor: AppTheme.themeColor,
                cursorHeight: 22,
                cursorRadius: const Radius.circular(3),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hint,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                widget.onConfirm!(controller.text);
              },
              child: Container(
                height: 30,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppTheme.themeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(
                    color: AppTheme.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
