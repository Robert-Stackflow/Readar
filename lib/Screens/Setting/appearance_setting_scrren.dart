import 'package:cloudreader/Utils/hive_util.dart';
import 'package:cloudreader/Widgets/BottomSheet/bottom_sheet_builder.dart'
    as bottom_sheet_builder;
import 'package:cloudreader/Widgets/item_builder.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../Widgets/BottomSheet/list_bottom_sheet.dart';
import '../../generated/l10n.dart';

class AppearanceSettingScreen extends StatefulWidget {
  const AppearanceSettingScreen({super.key});

  static const String routeName = "/setting/appearance";

  @override
  State<AppearanceSettingScreen> createState() =>
      _AppearanceSettingScreenState();
}

class _AppearanceSettingScreenState extends State<AppearanceSettingScreen>
    with TickerProviderStateMixin {
  bool _starNavigation =
      HiveUtil.getBool(key: HiveUtil.starNavigationKey, defaultValue: true);
  bool _readLaterNavigation = HiveUtil.getBool(
      key: HiveUtil.readLaterNavigationKey, defaultValue: true);
  int _localeOption = 0;
  List<String> labels = [];

  @override
  initState() {
    super.initState();
    filterLocale();
  }

  List<String> filterLocale() {
    List<Locale> locales = S.delegate.supportedLocales;
    for (Locale locale in locales) {
      labels.add(locale.toString());
      if (HiveUtil.getString(key: HiveUtil.languageKey) == locale.toString()) {
        setState(() {
          _localeOption = locales.indexOf(locale);
        });
      }
    }
    return labels;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildAppBar(title: S.current.apprearanceSetting),
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
                  tip: HiveUtil.getString(key: HiveUtil.languageKey) ?? "跟随系统",
                  topRadius: true,
                  bottomRadius: true,
                  onTap: () {
                    bottom_sheet_builder.showModalBottomSheet(
                      backgroundColor: Colors.white.withOpacity(0),
                      context: context,
                      builder: (context) => ListBottomSheet(
                        currentIndex: _localeOption,
                        title: "选择语言",
                        labels: labels,
                        onChanged: (int index) {
                          setState(() {
                            _localeOption = index;
                            HiveUtil.put(
                                key: HiveUtil.languageKey,
                                value: labels[index]);
                            S.load(Locale(labels[index]));
                          });
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "主题颜色",
                  tip: "森林绿",
                  topRadius: true,
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "深色模式跟随系统",
                  value: true,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "深色模式",
                  value: true,
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "星标",
                  value: _starNavigation,
                  description: "关闭后，底部导航栏的星标入口将移至侧边栏中",
                  topRadius: true,
                  onTap: () {
                    setState(() {
                      _starNavigation = !_starNavigation;
                    });
                    HiveUtil.put(
                        key: HiveUtil.starNavigationKey,
                        value: _starNavigation);
                  },
                ),
                ItemBuilder.buildRadioItem(
                  title: "稍后阅读",
                  value: _readLaterNavigation,
                  description: "关闭后，底部导航栏的稍后阅读入口将移至侧边栏中",
                  bottomRadius: true,
                  onTap: () {
                    setState(() {
                      _readLaterNavigation = !_readLaterNavigation;
                    });
                    HiveUtil.put(
                        key: HiveUtil.readLaterNavigationKey,
                        value: _readLaterNavigation);
                  },
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "文章详情页-视图选项",
                  description: "选择视图样式",
                  tip: "左右滑动-卡片式布局",
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "文章详情页-布局设置",
                  description: "是否显示头图、各种Meta",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "文章详情页-重绘超链接",
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
