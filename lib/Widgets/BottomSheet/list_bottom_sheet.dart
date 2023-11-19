import 'package:cloudreader/Widgets/Item/item_builder.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class TileList extends StatelessWidget {
  const TileList(this.children,
      {required this.title, required Key key, this.onCloseTap})
      : super(key: key);

  TileList.fromOptions(
    List<Tuple2<String, dynamic>> options,
    dynamic selected,
    Function onSelected, {
    this.onCloseTap,
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
  final Function()? onCloseTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   mainAxisSize: MainAxisSize.min,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text(title, style: Theme.of(context).textTheme.titleLarge),
            //     GestureDetector(
            //       onTap: onCloseTap,
            //       child: Icon(
            //         Icons.close_rounded,
            //         color: Theme.of(context).iconTheme.color,
            //         size: 23,
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
        ...children,
      ],
    );
  }
}
