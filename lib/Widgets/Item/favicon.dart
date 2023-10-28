import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../Models/feed.dart';

class Favicon extends StatelessWidget {
  final Feed source;
  final double size;

  const Favicon(this.source, {this.size = 16, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: size - 5,
      color: CupertinoColors.systemGrey6,
    );

    if (source.iconUrl != null && source.iconUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: source.iconUrl ?? "",
        width: size,
        height: size,
      );
    } else {
      return Container(
        width: size,
        height: size,
        color: CupertinoColors.systemGrey.resolveFrom(context),
        child: Center(
          child: Text(
            source.name.isNotEmpty ? source.name[0] : "?",
            style: textStyle,
          ),
        ),
      );
    }
  }
}
