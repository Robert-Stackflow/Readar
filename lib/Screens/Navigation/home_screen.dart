import 'dart:io';

import 'package:cloudreader/Models/tab_data.dart';
import 'package:cloudreader/Screens/Navigation/star_screen.dart';
import 'package:cloudreader/Themes/icon.dart';
import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "/nav/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late PageController searchHintController;

  @override
  void initState() {
    searchHintController = PageController();
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    super.initState();
  }

  @override
  void dispose() {
    searchHintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: ListView(
          physics: const ScrollPhysics(),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                    flex: 1,
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
                          },
                          highlightColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    true),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // IconButton(
                  //   splashColor: Colors.transparent,
                  //   highlightColor: Colors.transparent,
                  //   icon: const Icon(Iconfont.xiaoxi),
                  //   onPressed: () {
                  //     Scaffold.of(context).openDrawer();
                  //   },
                  // ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 80,
              child: ScrollConfiguration(
                behavior: NoShadowScrollBehavior(),
                child: RefreshIndicator(
                  color: AppTheme.themeColor,
                  onRefresh: () async {},
                  child: Container(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
