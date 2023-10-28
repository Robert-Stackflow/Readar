import 'package:cloudreader/Screens/Content/tts_screen.dart';
import 'package:cloudreader/Screens/Navigation/article_screen.dart';
import 'package:cloudreader/Screens/Navigation/feed_screen.dart';
import 'package:cloudreader/Screens/Navigation/star_screen.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../Providers/global.dart';
import '../Screens/Navigation/read_later_screen.dart';
import '../generated/l10n.dart';

part 'nav_data.g.dart';

@JsonSerializable()
class NavData {
  String id;
  int index;
  bool visible;
  static const int maxShown = 5;

  NavData({
    required this.id,
    required this.index,
    required this.visible,
  });

  Map<String, dynamic> toJson() => _$NavDataToJson(this);

  factory NavData.fromJson(Map<String, dynamic> json) =>
      _$NavDataFromJson(json);

  static List<NavData> defaultNavs = <NavData>[
    NavData(
      id: "article",
      index: 0,
      visible: true,
    ),
    NavData(
      id: "feed",
      index: 1,
      visible: true,
    ),
    NavData(
      id: "star",
      index: 2,
      visible: true,
    ),
    NavData(
      id: "readLater",
      index: 3,
      visible: true,
    ),
    NavData(
      id: "highlights",
      index: 4,
      visible: false,
    ),
    NavData(
      id: "explore",
      index: 5,
      visible: false,
    ),
    NavData(
      id: "statistics",
      index: 6,
      visible: false,
    ),
    NavData(
      id: "tts",
      index: 7,
      visible: false,
    ),
  ];

  static Map<String, IconData> idToIconMap = {
    "article": Icons.feed_outlined,
    "feed": Icons.rss_feed_rounded,
    "star": Icons.bookmark_outline_rounded,
    "readLater": Icons.checklist_rounded,
    "highlights": Icons.lightbulb_outline_rounded,
    "explore": Icons.explore_outlined,
    "statistics": Icons.show_chart_rounded,
    "tts": Icons.headset_outlined,
  };

  static Map<String, Widget> idToPageMap = {
    "article": ArticleScreen(ScrollTopNotifier()),
    "feed": const FeedScreen(),
    "star": const StarScreen(),
    "readLater": const ReadLaterScreen(),
    "highlights": const StarScreen(),
    "explore": const StarScreen(),
    "statistics": const StarScreen(),
    "tts": const TTSScreen(),
  };

  static int compare(NavData a, NavData b) {
    return a.index - b.index;
  }

  static String getLabel(String id) {
    Map<String, String> idToLabelMap = {
      "article": S.current.article,
      "feed": S.current.feed,
      "star": S.current.star,
      "readLater": S.current.readLater,
      "highlights": S.current.highlights,
      "explore": S.current.explore,
      "statistics": S.current.statistics,
      "tts": S.current.tts,
    };
    return idToLabelMap[id] ?? "";
  }

  static IconData getIcon(String id) {
    return idToIconMap[id] ?? Icons.add;
  }

  static Widget getPage(String id) {
    return idToPageMap[id]!;
  }

  static List<NavData> getNavs() {
    List<NavData> navs = Global.globalProvider.navData;
    navs.sort(compare);
    return navs;
  }

  static List<NavData> getShownNavs() {
    List<NavData> navs = Global.globalProvider.navData;
    navs.sort(compare);
    List<NavData> shownNavs = [];
    for (NavData nav in navs) {
      if (nav.visible) shownNavs.add(nav);
      if (shownNavs.length >= maxShown) break;
    }
    return shownNavs;
  }

  static List<NavData> getHiddenNavs() {
    List<NavData> navs = Global.globalProvider.navData;
    navs.sort(compare);
    List<NavData> hiddenNavs = [];
    List<String> ids = List.generate(navs.length, (index) => navs[index].id);
    for (NavData nav in navs) {
      if (!nav.visible) hiddenNavs.add(nav);
    }
    for (NavData nav in NavData.defaultNavs) {
      if (!ids.contains(nav.id)) hiddenNavs.add(nav);
    }
    return hiddenNavs;
  }
}
