import 'package:cloudreader/Screens/Navigation/title_screen.dart';
import 'package:flutter/material.dart';

import '../Providers/provider_manager.dart';
import '../generated/l10n.dart';

class NavEntry {
  String id;
  int index;
  bool visible;

  NavEntry({
    required this.id,
    required this.index,
    required this.visible,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'index': index,
        'visible': visible ? 1 : 0,
      };

  factory NavEntry.fromJson(Map<String, dynamic> json) => NavEntry(
        id: json['id'] as String,
        index: json['index'] as int,
        visible: json['visible'] == 0 ? false : true,
      );

  static NavEntry libraryEntry = NavEntry(
    id: "library",
    index: 1,
    visible: true,
  );

  static List<NavEntry> defaultEntries = <NavEntry>[
    NavEntry(
      id: "explore",
      index: 2,
      visible: true,
    ),
  ];

  static List<NavEntry> changableEntries = <NavEntry>[
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
      id: "highlights",
      index: 4,
      visible: false,
    ),
    NavEntry(
      id: "saved",
      index: 5,
      visible: false,
    ),
    NavEntry(
      id: "history",
      index: 6,
      visible: false,
    ),
    NavEntry(
      id: "statistics",
      index: 7,
      visible: false,
    ),
  ];

  static Map<String, IconData> idToIconMap = {
    "feed": Icons.rss_feed_rounded,
    'star': Icons.star_outline_rounded,
    "readLater": Icons.checklist_rounded,
    'highlights': Icons.lightbulb_outline_rounded,
    'saved': Icons.save_alt_rounded,
    'history': Icons.history_outlined,
    "statistics": Icons.show_chart_rounded,
    "explore": Icons.explore_outlined,
    "library": Icons.library_books_outlined,
  };

  static Map<String, Widget> idToPageMap = {
    "feed": const TitleScreen("feed"),
    'star': const TitleScreen("star"),
    "readLater": const TitleScreen("readLater"),
    'highlights': const TitleScreen("highlights"),
    'saved': const TitleScreen("saved"),
    'history': const TitleScreen("history"),
    "statistics": const TitleScreen("statistics"),
    "explore": const TitleScreen("explore"),
    "library": const TitleScreen("library"),
  };

  static int compare(NavEntry a, NavEntry b) {
    return a.index - b.index;
  }

  static String getLabel(String id) {
    Map<String, String> idToLabelMap = {
      "feed": S.current.feed,
      'star': S.current.star,
      "readLater": S.current.readLater,
      'highlights': S.current.highlights,
      'saved': S.current.saved,
      'history': S.current.history,
      "statistics": S.current.statistics,
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

  static List<NavEntry> getHiddenEntries() {
    List<NavEntry> navEntries = ProviderManager.globalProvider.navEntries;
    navEntries.sort(compare);
    List<NavEntry> hiddenEntries = [];
    for (NavEntry entry in navEntries) {
      if (!entry.visible) hiddenEntries.add(entry);
    }
    return hiddenEntries;
  }

  static List<NavEntry> getShownEntries() {
    List<NavEntry> navEntries = ProviderManager.globalProvider.navEntries;
    navEntries.sort(compare);
    List<NavEntry> showEntries = [];
    List<String> ids =
        List.generate(navEntries.length, (index) => navEntries[index].id);
    for (NavEntry entry in navEntries) {
      if (entry.visible) showEntries.add(entry);
    }
    for (NavEntry entry in NavEntry.changableEntries) {
      if (!ids.contains(entry.id)) showEntries.add(entry);
    }
    return showEntries;
  }
}
