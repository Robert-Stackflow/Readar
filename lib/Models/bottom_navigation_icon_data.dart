import 'package:cloudreader/Themes/icon.dart';
import 'package:flutter/material.dart';

class BottomNavigationIconData {
  BottomNavigationIconData({
    this.label = '',
    this.icon = Iconfont.shouye,
    this.index = 0,
    this.selectedIcon = Iconfont.shouye,
    this.isSelected = false,
    this.animationController,
  });

  IconData icon;
  IconData selectedIcon;
  bool isSelected;
  int index;
  String label;

  AnimationController? animationController;

  static List<BottomNavigationIconData> tabIconsList =
      <BottomNavigationIconData>[
    BottomNavigationIconData(
      icon: Icons.feed_outlined,
      selectedIcon: Icons.feed_rounded,
      index: 0,
      label: '文章',
      isSelected: true,
      animationController: null,
    ),
    BottomNavigationIconData(
      icon: Icons.rss_feed_rounded,
      selectedIcon: Icons.rss_feed_rounded,
      index: 1,
      label: '订阅',
      isSelected: false,
      animationController: null,
    ),
    BottomNavigationIconData(
      icon: Icons.star_outline_rounded,
      selectedIcon: Icons.star_rounded,
      index: 2,
      label: '星标',
      isSelected: false,
      animationController: null,
    ),
    BottomNavigationIconData(
      icon: Icons.checklist_rounded,
      selectedIcon: Icons.checklist_rounded,
      index: 3,
      label: "稍后阅读",
      isSelected: false,
      animationController: null,
    ),
  ];
}

class BottomNavigationFabData {
  BottomNavigationFabData({
    this.label = '',
    this.icon = Iconfont.shouye,
    this.description = '',
  });

  IconData icon;
  String description;
  String label;

  static List<String> labels = ["聊天", "冥想", "发布", "提问", "心晴日记"];
  static List<String> descriptions = [
    "向噬云兽倾诉内心",
    "沉浸式冥想中心",
    "向树洞表达快乐与烦恼",
    "向他人寻求帮助",
    "记录今天的自己"
  ];

  static List<BottomNavigationFabData> fabIconsList = <BottomNavigationFabData>[
    BottomNavigationFabData(
      label: "聊天",
      description: "向AI询问问题",
      icon: Icons.message_outlined,
    ),
    BottomNavigationFabData(
      label: "TTS",
      description: "为你朗读文章",
      icon: Icons.headset_outlined,
    ),
    BottomNavigationFabData(
      label: "订阅源",
      description: "浏览订阅源社区",
      icon: Icons.add_chart_outlined,
    ),
    BottomNavigationFabData(
      label: "标签",
      description: "按标签分类文章",
      icon: Icons.tag_rounded,
    ),
    BottomNavigationFabData(
      label: "集锦",
      description: "查看你收藏的文本或图片",
      icon: Icons.bookmark_outline_rounded,
    ),
    BottomNavigationFabData(
      label: "滑动选择",
      description: "按住滑动至按钮选择功能",
    ),
  ];
}
