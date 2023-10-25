import 'package:cloudreader/Themes/theme.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

const double mainAppbarPadding = 28;

class MainSliverAppBar extends SliverAppBar {
  static const TextStyle _textStyle = TextStyle(
    // color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: kToolbarHeight / 3,
    height: 1,
  );

  static Size getTextSize(BuildContext context, String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size;
  }

  MainSliverAppBar(
      {super.key,
      GlobalKey? appBarKey,
      String title = '',
      double height = kToolbarHeight + mainAppbarPadding * 2,
      double expandedFontSize = 30,
      void Function()? onLeadingPress = AppNavigator.pop,
      void Function()? onTrailingPress,
      required BuildContext context})
      : super(
          centerTitle: true,
          expandedHeight: height,
          floating: false,
          pinned: true,
          backgroundColor: AppTheme.background,
          elevation: 0,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: mainAppbarPadding),
            onPressed: onLeadingPress,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          actions: [
            IconButton(
              padding:
                  const EdgeInsets.symmetric(horizontal: mainAppbarPadding),
              icon: Icon(Icons.favorite_border_rounded,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
              onPressed: onTrailingPress,
            ),
          ],
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final safeAreaTop = MediaQuery.of(context).padding.top;
              final minHeight = safeAreaTop + kToolbarHeight;
              final maxHeight = height + safeAreaTop;

              final percent =
                  (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
              final fontSize = _textStyle.fontSize ?? 16;
              final currentTextStyle = _textStyle.copyWith(
                fontSize: fontSize + (expandedFontSize - fontSize) * percent,
              );

              final textWidth =
                  getTextSize(context, title, currentTextStyle).width;
              const startX = mainAppbarPadding;
              final endX = MediaQuery.of(context).size.width / 2 -
                  textWidth / 2 -
                  startX;
              final dx = startX + endX - endX * percent;

              return Container(
                color: AppTheme.background.withOpacity(0.8 - percent * 0.8),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: kToolbarHeight / 3),
                      child: Transform.translate(
                        offset:
                            Offset(dx, constraints.maxHeight - kToolbarHeight),
                        child: Text(
                          title,
                          style: currentTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
}

class MainAppBar extends AppBar {
  MainAppBar(
      {super.key, super.title, List<IconData>? rightIcons, Function()? onBack})
      : super(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: mainAppbarPadding),
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: onBack ?? AppNavigator.pop,
          ),
          actions: rightIcons != null
              ? rightIcons
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: mainAppbarPadding),
                      child: Icon(
                        e,
                        color: Colors.white,
                      ),
                    ),
                  )
                  .toList()
              : [Container()],
        );
}
