import 'package:cloudreader/Screens/Setting/entry_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/select_theme_screen.dart';
import 'package:cloudreader/Utils/cache_util.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../Providers/global_provider.dart';
import '../../Providers/provider_manager.dart';
import '../../Utils/locale_util.dart';
import '../../Widgets/BottomSheet/bottom_sheet_builder.dart';
import '../../Widgets/BottomSheet/list_bottom_sheet.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class GeneralSettingScreen extends StatefulWidget {
  const GeneralSettingScreen({super.key});

  static const String routeName = "/setting/general";

  @override
  State<GeneralSettingScreen> createState() => _GeneralSettingScreenState();
}

class _GeneralSettingScreenState extends State<GeneralSettingScreen>
    with TickerProviderStateMixin {
  String _cacheSize = "";
  List<Tuple2<String, Locale?>> _supportedLocaleTuples = [];

  @override
  void initState() {
    super.initState();
    filterLocale();
    getCacheSize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void getCacheSize() {
    CacheUtil.loadCache().then((value) {
      setState(() {
        _cacheSize = value;
      });
    });
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
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: ItemBuilder.buildSimpleAppBar(
            title: S.current.generalSetting, context: context),
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
                Selector<GlobalProvider, Locale?>(
                  selector: (context, globalProvider) => globalProvider.locale,
                  builder: (context, locale, child) =>
                      ItemBuilder.buildEntryItem(
                    context: context,
                    title: S.current.language,
                    tip: LocaleUtil.getLabel(locale)!,
                    topRadius: true,
                    bottomRadius: true,
                    onTap: () {
                      filterLocale();
                      BottomSheetBuilder.showListBottomSheet(
                        context,
                        (context) => TileList.fromOptions(
                          _supportedLocaleTuples,
                          locale,
                          (item2) {
                            ProviderManager.globalProvider.locale = item2;
                            Navigator.pop(context);
                          },
                          context: context,
                          title: S.current.chooseLanguage,
                          onCloseTap: () => Navigator.pop(context),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: S.current.themeSetting),
                Selector<GlobalProvider, ActiveThemeMode>(
                  selector: (context, globalProvider) =>
                      globalProvider.themeMode,
                  builder: (context, themeMode, child) =>
                      ItemBuilder.buildEntryItem(
                    context: context,
                    title: S.current.themeMode,
                    tip: GlobalProvider.getThemeModeLabel(themeMode),
                    onTap: () {
                      BottomSheetBuilder.showListBottomSheet(
                        context,
                        (context) => TileList.fromOptions(
                          GlobalProvider.getSupportedThemeMode(),
                          themeMode,
                          (item2) {
                            ProviderManager.globalProvider.themeMode = item2;
                            Navigator.pop(context);
                          },
                          context: context,
                          title: S.current.chooseThemeMode,
                          onCloseTap: () => Navigator.pop(context),
                        ),
                      );
                    },
                  ),
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.selectTheme,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SelectThemeScreen()));
                  },
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.sideBarEntriesSetting,
                  bottomRadius: true,
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const EntrySettingScreen()));
                    });
                  },
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.checkUpdates,
                  topRadius: true,
                  bottomRadius: true,
                  description: "${S.current.checkUpdatesTip}2023-04-15",
                  tip: "1.0.0",
                  onTap: () {
                    IToast.showTop(context,
                        text: S.current.checkUpdatesAlreadyLatest);
                  },
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.clearCache,
                  topRadius: true,
                  bottomRadius: true,
                  tip: _cacheSize,
                  onTap: () {
                    getTemporaryDirectory().then((tempDir) {
                      CacheUtil.delDir(tempDir).then((value) {
                        CacheUtil.loadCache().then((value) {
                          setState(() {
                            _cacheSize = value;
                            IToast.showTop(context,
                                text: S.current.clearCacheSuccess);
                          });
                        });
                      });
                    });
                  },
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
