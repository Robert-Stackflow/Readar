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
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        ...children,
      ],
    );
  }
}
