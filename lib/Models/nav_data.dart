import 'package:cloudreader/Screens/Navigation/article_screen.dart';
import 'package:cloudreader/Utils/hive_util.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class NavData {
  String label;
  IconData icon;
  int index;
  bool visible;
  String route;

  NavData({
    required this.label,
    required this.icon,
    required this.index,
    required this.visible,
    required this.route,
  });

  Map<String, dynamic> toMap() {
    return {
      "label": label,
      "icon": icon,
      "index": index,
      "visible": visible,
      "route": route,
    };
  }

  NavData.fromMap(Map<String, dynamic> map)
      : label = map['label'],
        icon = map['icon'],
        index = map['index'],
        visible = map['visible'],
        route = map['route'];

  static List<NavData> defaultNavs = <NavData>[
    NavData(
      label: S.current.article,
      icon: Icons.feed_outlined,
      index: 0,
      visible: true,
      route: ArticleScreen.routeName,
    ),
    NavData(
      label: S.current.article,
      icon: Icons.feed_outlined,
      index: 0,
      visible: true,
      route: ArticleScreen.routeName,
    ),
    NavData(
      label: S.current.article,
      icon: Icons.feed_outlined,
      index: 0,
      visible: true,
      route: ArticleScreen.routeName,
    ),
    NavData(
      label: S.current.article,
      icon: Icons.feed_outlined,
      index: 0,
      visible: true,
      route: ArticleScreen.routeName,
    ),
    NavData(
      label: S.current.article,
      icon: Icons.feed_outlined,
      index: 0,
      visible: true,
      route: ArticleScreen.routeName,
    ),
    NavData(
      label: S.current.article,
      icon: Icons.feed_outlined,
      index: 0,
      visible: true,
      route: ArticleScreen.routeName,
    ),
  ];

  static List<NavData> getNavs() {
    List<NavData> navs = [];
    String? json = HiveUtil.getString(key: HiveUtil.navDataKey);
    if (json == null) {}
    return navs;
  }
}
