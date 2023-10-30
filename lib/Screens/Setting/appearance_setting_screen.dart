import 'package:cloudreader/Providers/global_provider.dart';
import 'package:cloudreader/Screens/Setting/nav_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/select_theme_screen.dart';
import 'package:cloudreader/Utils/locale_util.dart';
import 'package:cloudreader/Widgets/BottomSheet/bottom_sheet_builder.dart';
import 'package:cloudreader/Widgets/BottomSheet/tile_list.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:cloudreader/Widgets/Item/item_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

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
  List<Tuple2<String, Locale?>> _supportedLocaleTuples = [];

  @override
  initState() {
    super.initState();
    filterLocale();
  }

  void filterLocale() {
    _supportedLocaleTuples = [];
    List<Locale> locales = S.delegate.supportedLocales;
    _supportedLocaleTuples.add(Tuple2(S.current.followSystem, null));
    for (Locale locale in locales) {
      dynamic tuple = LocaleUtil.getTuple(locale);
      if (tuple != null) {
        _supportedLocaleTuples.add(tuple);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, globalProvider, child) {
      return Container(
        color: Colors.transparent,
        child: Scaffold(
          appBar: ItemBuilder.buildSimpleAppBar(
              title: S.current.apprearanceSetting, context: context),
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
                    context: context,
                    title: S.current.language,
                    tip: LocaleUtil.getLabel(globalProvider.locale)!,
                    topRadius: true,
                    bottomRadius: true,
                    onTap: () {
                      filterLocale();
                      BottomSheetBuilder.showListBottomSheet(
                        context,
                        (context) => TileList.fromOptions(
                          _supportedLocaleTuples,
                          globalProvider.locale,
                          (item2) {
                            globalProvider.locale = item2;
                            Navigator.pop(context);
                          },
                          context: context,
                          title: S.current.chooseLanguage,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  ItemBuilder.buildCaptionItem(
                      context: context, title: S.current.themeSetting),
                  ItemBuilder.buildEntryItem(
                    context: context,
                    title: S.current.selectTheme,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(SelectThemeScreen.routeName);
                    },
                  ),
                  ItemBuilder.buildEntryItem(
                    context: context,
                    title: S.current.themeMode,
                    tip: S.current.followSystem,
                    onTap: () {},
                  ),
                  ItemBuilder.buildEntryItem(
                    context: context,
                    title: S.current.bottomNavigationBarSetting,
                    bottomRadius: true,
                    onTap: () {
                      setState(() {
                        Navigator.of(context)
                            .pushNamed(NavSettingScreen.routeName);
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ItemBuilder.buildCaptionItem(
                      context: context, title: S.current.articleDetailSetting),
                  ItemBuilder.buildEntryItem(
                    context: context,
                    title: S.current.articleDetailViewOption,
                    tip: "左右滑动-卡片式布局",
                    onTap: () {},
                  ),
                  ItemBuilder.buildEntryItem(
                    context: context,
                    title: S.current.articleDetailMetaSetting,
                    onTap: () {},
                  ),
                  ItemBuilder.buildEntryItem(
                    context: context,
                    title: S.current.articleDetailHeaderImageDisplayMode,
                    tip: "全文图片轮播",
                    onTap: () {},
                  ),
                  ItemBuilder.buildEntryItem(
                    context: context,
                    title: S.current.articleDetailVideoDisplayMode,
                    tip: "截取图片",
                    onTap: () {},
                  ),
                  ItemBuilder.buildRadioItem(
                    context: context,
                    title: S.current.articleDetailShowRelated,
                    value: false,
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
    });
  }
}
