class TabData {
  TabData({
    required this.name,
  });

  String name;

  static List<TabData> toolTabList = <TabData>[
    TabData(
      name: '星标',
    ),
    TabData(
      name: '稍后再读',
    ),
    TabData(
      name: '剪切板',
    ),
    TabData(
      name: '播放器',
    )
  ];
  static List<TabData> holeTabList = <TabData>[
    TabData(
      name: '订阅源',
    ),
    TabData(
      name: '发现',
    ),
  ];
  static List<String> toolTabSearchHint = <String>[
    "搜索测评量表",
    "搜索冥想音频",
    "搜索心理名词",
    "搜索书籍",
    "搜索影视",
  ];
}
