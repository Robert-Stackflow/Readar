import 'package:cloudreader/Utils/theme.dart';
import 'package:cloudreader/Widgets/radio_item.dart';
import 'package:flutter/material.dart';

class AnonymousType {
  AnonymousType({required this.index, required this.label, required this.tip});

  int index;
  String label;
  String tip;
  static final AnonymousType none =
      AnonymousType(index: 0, label: "公开", tip: "他人能够看到你是帖子/提问/回答/评论的发布者");
  static final AnonymousType low = AnonymousType(
      index: 1, label: "弱匿名", tip: "他人不能看到你是帖子/提问/回答/评论的发布者，但是系统后台能够看到");
  static final AnonymousType high = AnonymousType(
      index: 2,
      label: "强匿名",
      tip:
          "他人或系统后台均不能看到你是帖子/提问/回答/评论的发布者，你也将无法编辑、删除帖子/提问/回答/评论或收到他人对帖子/提问/回答/评论的点赞、回复通知");
  static List<AnonymousType> types = [
    none,
    low,
    high,
  ];
}

class AnonymousBottomSheet extends StatefulWidget {
  const AnonymousBottomSheet(
      {super.key, required this.currentTypeIndex, this.onChanged});

  final int currentTypeIndex;

  final Function(int)? onChanged;

  @override
  AnonymousBottomSheetState createState() => AnonymousBottomSheetState();
}

class AnonymousBottomSheetState extends State<AnonymousBottomSheet> {
  late int _currentTypeIndex;

  @override
  void initState() {
    _currentTypeIndex = widget.currentTypeIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(4),
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "选择匿名方式",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      letterSpacing: 0.18,
                      color: AppTheme.darkerText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(color: AppTheme.spacer, width: 0.4),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: List.generate(AnonymousType.types.length,
                  (index) => _tile(data: AnonymousType.types[index])).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile({required AnonymousType data}) {
    bool isSelected = (data.index == _currentTypeIndex);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.themeColor : AppTheme.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(1.0, 1.0),
              blurRadius: 2.0),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: RadioItem<int>(
        contentPadding: EdgeInsets.zero,
        enableFeedback: true,
        selectedTileColor: AppTheme.themeColor,
        activeColor: AppTheme.themeColor,
        title: Center(
          child: Text(
            data.label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppTheme.white : AppTheme.darkerText),
          ),
        ),
        subtitle: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              data.tip,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? AppTheme.spacer : Colors.grey),
            ),
          ),
        ),
        value: data.index,
        selectedColor: AppTheme.white,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppTheme.spacer),
            borderRadius: BorderRadius.circular(10)),
        selected: isSelected,
        groupValue: _currentTypeIndex,
        onChanged: (value) {
          setState(() {
            _currentTypeIndex = value!;
            if (widget.onChanged != null) {
              widget.onChanged!(_currentTypeIndex);
            }
          });
        },
      ),
    );
  }
}
