// ignore_for_file: library_prefixes

import 'dart:io';

import 'package:cloudreader/Models/tab_data.dart';
import 'package:cloudreader/Themes/icon.dart';
import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Widgets/marquee_widget.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Utils/itoast.dart';

GlobalKey<StarScreenState> exploreKey = GlobalKey();

class StarScreen extends StatefulWidget {
  const StarScreen({super.key});

  static const String routeName = "/nav/star";

  @override
  State<StarScreen> createState() => StarScreenState();
}

class StarScreenState extends State<StarScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  late PageController searchHintController;

  @override
  void dispose() {
    animationController?.dispose();
    searchHintController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    searchHintController = PageController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController!.forward();
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: const Icon(
                      Iconfont.gengduo,
                      size: 23,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Expanded(
                    child: Container(
                      height: 35,
                      color: Colors.transparent,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: AppTheme.themeColor.withOpacity(0.5),
                            width: 0.2,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            IToast.showTop(context, text: "功能开发中");
                            // bottom_sheet_builder.showModalBottomSheet(
                            //   backgroundColor: Colors.white.withOpacity(0),
                            //   context: context,
                            //   builder: (BuildContext context) =>
                            //       SearchBottomSheet(
                            //     type: SearchType
                            //         .types[(tabController?.index ?? 0) + 2],
                            //   ),
                            // );
                          },
                          highlightColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              const Icon(Iconfont.sousuo,
                                  size: 14, color: Colors.grey),
                              const SizedBox(width: 5),
                              Flexible(
                                fit: FlexFit.loose,
                                flex: 1,
                                child: buildMarqueeWidget(
                                    TabData.toolTabSearchHint,
                                    searchHintController,
                                    false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ScrollConfiguration(
                behavior: NoShadowScrollBehavior(),
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _switchToHint(int index) {
    searchHintController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}

MarqueeWidget buildMarqueeWidget(
    List<String> loopList, PageController controller, bool autoplay) {
  return MarqueeWidget(
    itemBuilder: (BuildContext context, int index) {
      String itemStr = loopList[index];
      return Container(
        alignment: Alignment.centerLeft,
        child: Text(
          itemStr,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            letterSpacing: 0.1,
            color: Colors.grey,
          ),
        ),
      );
    },
    autoPlay: autoplay,
    count: loopList.length,
    controller: controller,
  );
}
