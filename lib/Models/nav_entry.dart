import 'package:cloudreader/Screens/Navigation/article_screen.dart';
import 'package:cloudreader/Screens/Navigation/explore_screen.dart';
import 'package:cloudreader/Screens/Navigation/feed_screen.dart';
import 'package:cloudreader/Screens/Navigation/star_screen.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../Providers/provider_manager.dart';
import '../Screens/Navigation/library_screen.dart';
import '../Screens/Navigation/read_later_screen.dart';
import '../generated/l10n.dart';

part 'nav_entry.g.dart';

@JsonSerializable()
class NavEntry {
  String id;
  int index;
  bool visible;
  static const int maxShown = 5;

  NavEntry({
    required this.id,
    required this.index,
    required this.visible,
  });

  Map<String, dynamic> toJson() => _$NavEntryToJson(this);

  factory NavEntry.fromJson(Map<String, dynamic> json) =>
      _$NavEntryFromJson(json);

  static List<NavEntry> defaultEntries = <NavEntry>[
    NavEntry(
      id: "article",
      index: 0,
      visible: true,
    ),
    NavEntry(
      id: "feed",
      index: 1,
      visible: true,
    ),
    NavEntry(
      id: "star",
      index: 2,
      visible: true,
    ),
    NavEntry(
      id: "readLater",
      index: 3,
      visible: true,
    ),
    NavEntry(
      id: "explore",
      index: 4,
      visible: false,
    ),
    NavEntry(
      id: "library",
      index: 5,
      visible: false,
    ),
  ];

  static Map<String, IconData> idToIconMap = {
    "article": Icons.feed_outlined,
    "feed": Icons.rss_feed_rounded,
    "star": Icons.bookmark_outline_rounded,
    "readLater": Icons.checklist_rounded,
    "explore": Icons.explore_outlined,
    "library": Icons.library_books_outlined,
  };

  static Map<String, Widget> idToPageMap = {
    "article": const ArticleScreen(),
    "feed": const FeedScreen(),
    "star": const StarScreen(),
    "readLater": const ReadLaterScreen(),
    "explore": const ExploreScreen(),
    "library": const LibraryScreen(),
  };

  static int compare(NavEntry a, NavEntry b) {
    return a.index - b.index;
  }

  static String getLabel(String id) {
    Map<String, String> idToLabelMap = {
      "article": S.current.article,
      "feed": S.current.feed,
      "star": S.current.star,
      "readLater": S.current.readLater,
      "explore": S.current.explore,
      "library": S.current.library,
    };
    return idToLabelMap[id] ?? "";
  }

  static IconData getIcon(String id) {
    return idToIconMap[id] ?? Icons.add;
  }

  static Widget getPage(String id) {
    return idToPageMap[id]!;
  }

  static List<NavEntry> getNavs() {
    List<NavEntry> navs = ProviderManager.globalProvider.navEntries;
    navs.sort(compare);
    return navs;
  }

  static List<NavEntry> getNavigationBarEntries() {
    List<NavEntry> navEntries = ProviderManager.globalProvider.navEntries;
    navEntries.sort(compare);
    List<NavEntry> navigationBarEntries = [];
    for (NavEntry entry in navEntries) {
      if (entry.visible) navigationBarEntries.add(entry);
      if (navigationBarEntries.length >= maxShown) break;
    }
    return navigationBarEntries;
  }

  static List<NavEntry> getSidebarEntries() {
    List<NavEntry> navEntries = ProviderManager.globalProvider.navEntries;
    navEntries.sort(compare);
    List<NavEntry> sidebarEntries = [];
    List<String> ids =
        List.generate(navEntries.length, (index) => navEntries[index].id);
    for (NavEntry entry in navEntries) {
      if (!entry.visible) sidebarEntries.add(entry);
    }
    for (NavEntry entry in NavEntry.defaultEntries) {
      if (!ids.contains(entry.id)) sidebarEntries.add(entry);
    }
    return sidebarEntries;
  }
}
