import 'package:cloudreader/Screens/Navigation/home_screen.dart';
import 'package:cloudreader/Screens/Navigation/read_later_screen.dart';
import 'package:cloudreader/Screens/Navigation/star_screen.dart';
import 'package:cloudreader/Screens/Navigation/subscription_screen.dart';
import 'package:flutter/material.dart';

import '../Utils/hive_util.dart';
import '../generated/l10n.dart';

class BottomNavigationIconData {
  BottomNavigationIconData(
      {this.label = '',
      this.icon = Icons.home_filled,
      this.index = 0,
      this.selectedIcon = Icons.home_filled,
      this.isShow = true,
      this.page});

  IconData icon;
  IconData selectedIcon;
  int index;
  String label;
  bool isShow;
  Widget? page;

  static List<BottomNavigationIconData> tabIconsList =
      <BottomNavigationIconData>[
    BottomNavigationIconData(
      icon: Icons.feed_outlined,
      selectedIcon: Icons.feed_rounded,
      index: 0,
      label: S.current.article,
      page: const HomeScreen(),
    ),
    BottomNavigationIconData(
      icon: Icons.rss_feed_rounded,
      selectedIcon: Icons.rss_feed_rounded,
      index: 1,
      label: S.current.feed,
      page: const FeedScreen(),
    ),
    BottomNavigationIconData(
      icon: Icons.star_outline_rounded,
      selectedIcon: Icons.star_rounded,
      index: 2,
      label: S.current.star,
      isShow:
          HiveUtil.getBool(key: HiveUtil.starNavigationKey, defaultValue: true),
      page: const StarScreen(),
    ),
    BottomNavigationIconData(
      icon: Icons.checklist_rounded,
      selectedIcon: Icons.checklist_rounded,
      index: 3,
      label: S.current.readLater,
      isShow: HiveUtil.getBool(
          key: HiveUtil.readLaterNavigationKey, defaultValue: true),
      page: const ReadLaterScreen(),
    ),
  ];
}
