import 'package:cloudreader/Providers/global_provider.dart';
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
          appBar: ItemBuilder.buildAppBar(
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
                          title: S.current.chooseLanguage,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  ItemBuilder.buildEntryItem(
                    title: S.current.themeColor,
                    tip: "森林绿",
                    topRadius: true,
                    onTap: () {},
                  ),
                  ItemBuilder.buildEntryItem(
                    title: S.current.themeMode,
                    tip: S.current.followSystem,
                    bottomRadius: true,
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  ItemBuilder.buildEntryItem(
                    title: S.current.bottomNavigationBarSetting,
                    topRadius: true,
                    showTrailing: false,
                    isCaption: true,
                  ),
                  ItemBuilder.buildRadioItem(
                    title: S.current.starNav,
                    value: globalProvider.starNavigationVisible,
                    onTap: () {
                      setState(() {
                        globalProvider.starNavigationVisible =
                            !globalProvider.starNavigationVisible;
                      });
                    },
                  ),
                  ItemBuilder.buildRadioItem(
                    title: S.current.readLaterNav,
                    value: globalProvider.readLaterNavigationVisible,
                    bottomRadius: true,
                    onTap: () {
                      setState(() {
                        globalProvider.readLaterNavigationVisible =
                            !globalProvider.readLaterNavigationVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ItemBuilder.buildEntryItem(
                    title: S.current.articleDetailSetting,
                    topRadius: true,
                    showTrailing: false,
                    isCaption: true,
                  ),
                  ItemBuilder.buildEntryItem(
                    title: S.current.articleDetailViewOption,
                    tip: "左右滑动-卡片式布局",
                    onTap: () {},
                  ),
                  ItemBuilder.buildEntryItem(
                    title: S.current.articleDetailMetaSetting,
                    onTap: () {},
                  ),
                  ItemBuilder.buildEntryItem(
                    title: S.current.articleDetailHeaderImageDisplayMode,
                    tip: "全文图片轮播",
                    onTap: () {},
                  ),
                  ItemBuilder.buildEntryItem(
                    title: S.current.articleDetailVideoDisplayMode,
                    tip: "截取图片",
                    onTap: () {},
                  ),
                  ItemBuilder.buildRadioItem(
                    title: S.current.articleDetailShowRelated,
                    value: false,
                    onTap: () {},
                  ),
                  ItemBuilder.buildRadioItem(
                    title: S.current.articleDetailRedrawHyperLink,
                    value: false,
                    description: S.current.articleDetailRedrawHyperLinkTip,
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
