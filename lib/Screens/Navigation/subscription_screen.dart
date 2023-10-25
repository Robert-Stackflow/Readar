import 'dart:io';

import 'package:cloudreader/Models/tab_data.dart';
import 'package:cloudreader/Themes/icon.dart';
import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Widgets/tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  static const String routeName = "/nav/subscription";

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  AnimationController? animationController;
  List<TabData> holeTabData = TabData.holeTabList;

  @override
  void dispose() {
    animationController?.dispose();
    tabController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
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
    tabController = TabController(vsync: this, length: holeTabData.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        body: SafeArea(
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child: TabBar(
                        controller: tabController,
                        tabs: holeTabData.map((value) {
                          var tp = TextPainter(
                            textDirection: TextDirection.ltr,
                            text: TextSpan(
                              text: value.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          )..layout();
                          return Tab(
                            child: SizedBox(
                              width: tp.width,
                              child: Text(value.name),
                            ),
                          );
                        }).toList(),
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        isScrollable: true,
                        enableFeedback: true,
                        physics: const BouncingScrollPhysics(),
                        labelColor: AppTheme.darkerText,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: AppTheme.darkerText,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        indicator: const TabIndicator(),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: tabController,
                    children: [
                      Container(),
                      Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
