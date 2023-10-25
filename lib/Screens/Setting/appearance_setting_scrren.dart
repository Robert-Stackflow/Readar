import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Widgets/item_builder.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';

class AppearanceSettingScreen extends StatefulWidget {
  const AppearanceSettingScreen({super.key});

  static const String routeName = "/setting/appearance";

  @override
  State<AppearanceSettingScreen> createState() =>
      _AppearanceSettingScreenState();
}

class _AppearanceSettingScreenState extends State<AppearanceSettingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          leadingWidth: 40,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.darkerText,
              size: 23,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "外观",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: AppTheme.darkerText,
                fontSize: 17),
          ),
          backgroundColor: AppTheme.background,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ScrollConfiguration(
            behavior: NoShadowScrollBehavior(),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "语言",
                  tip: "跟随系统",
                  topRadius: true,
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "主题颜色",
                  description: "选择图标、按钮等控件的强调色",
                  tip: "森林绿",
                  topRadius: true,
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "深色模式跟随系统",
                  description: "开启后软件的深色模式跟随系统设置",
                  value: true,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "深色模式",
                  value: true,
                  description: "由你自己控制软件的深浅色模式",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "文章详情页视图选项",
                  description: "选择视图样式",
                  tip: "左右滑动-卡片式布局",
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "文章详情页布局设置",
                  description: "是否显示头图、各种Meta",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "文章详情页是否显示回到顶部按钮",
                  value: true,
                  description: "关闭后将不再显示回到顶部悬浮按钮",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "文章详情页重绘超链接",
                  value: false,
                  description: "关闭后将不再重绘超链接为卡片样式",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
