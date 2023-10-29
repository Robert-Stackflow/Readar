import 'package:cloudreader/Utils/theme.dart';
import 'package:cloudreader/Widgets/Item/item_builder.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class TileList extends StatelessWidget {
  const TileList(this.children, {required this.title, required Key key})
      : super(key: key);

  TileList.fromOptions(
    List<Tuple2<String, dynamic>> options,
    dynamic selected,
    Function onSelected, {
    required this.title,
    required BuildContext context,
    super.key,
  }) : children = options.map(
          (t) => ItemBuilder.buildEntryItem(
            title: t.item1,
            trailing: Icons.done_rounded,
            showTrailing: t.item2 == selected,
            onTap: () {
              onSelected(t.item2);
            },
            context: context,
          ),
        );

  final Iterable<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Text(title, style: AppTheme.title),
        ),
        ...children,
      ],
    );
  }
}
