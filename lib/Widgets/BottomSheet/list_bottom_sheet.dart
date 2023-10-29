import 'package:cloudreader/Utils/theme.dart';
import 'package:cloudreader/Widgets/Item/radio_item.dart';
import 'package:flutter/material.dart';

class ListBottomSheet extends StatefulWidget {
  const ListBottomSheet(
      {super.key,
      required this.currentIndex,
      this.onChanged,
      required this.title,
      required this.labels,
      this.showTip = false,
      this.tips});

  final bool showTip;

  final int currentIndex;

  final String title;

  final List<String> labels;

  final List<String>? tips;

  final Function(int)? onChanged;

  @override
  ListBottomSheetState createState() => ListBottomSheetState();
}

class ListBottomSheetState extends State<ListBottomSheet> {
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
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
                  child: Text(
                    widget.title,
                    style: const TextStyle(
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
              children: List.generate(
                  widget.labels.length,
                  (index) => _tile(
                      label: widget.labels[index],
                      tip: widget.tips?[index],
                      index: index)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile({required String label, String? tip, required int index}) {
    bool isSelected = (index == _currentIndex);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : AppTheme.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(1.0, 1.0),
              blurRadius: 2.0),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: widget.showTip
          ? RadioItem<int>(
              contentPadding: EdgeInsets.zero,
              enableFeedback: true,
              selectedTileColor: Theme.of(context).primaryColor,
              activeColor: Theme.of(context).primaryColor,
              title: Center(
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? AppTheme.white : AppTheme.darkerText),
                ),
              ),
              subtitle: Center(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    tip ?? "",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: isSelected ? AppTheme.spacer : Colors.grey),
                  ),
                ),
              ),
              value: index,
              selectedColor: AppTheme.white,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppTheme.spacer),
                  borderRadius: BorderRadius.circular(10)),
              selected: isSelected,
              groupValue: _currentIndex,
              onChanged: (value) {
                setState(() {
                  _currentIndex = value!;
                  if (widget.onChanged != null) {
                    widget.onChanged!(_currentIndex);
                  }
                });
              },
            )
          : RadioItem<int>(
              contentPadding: EdgeInsets.zero,
              enableFeedback: true,
              selectedTileColor: Theme.of(context).primaryColor,
              activeColor: Theme.of(context).primaryColor,
              title: Center(
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? AppTheme.white : AppTheme.darkerText),
                ),
              ),
              value: index,
              selectedColor: AppTheme.white,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppTheme.spacer),
                  borderRadius: BorderRadius.circular(10)),
              selected: isSelected,
              groupValue: _currentIndex,
              onChanged: (value) {
                setState(() {
                  _currentIndex = value!;
                  if (widget.onChanged != null) {
                    widget.onChanged!(_currentIndex);
                  }
                });
              },
            ),
    );
  }
}
