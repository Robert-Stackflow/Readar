import 'package:flutter/material.dart';
import 'package:readar/Resources/fonts.dart';
import 'package:readar/Screens/Setting/select_font_screen.dart';
import 'package:readar/Screens/Setting/select_theme_screen.dart';
import 'package:readar/Utils/app_provider.dart';
import 'package:readar/Utils/hive_util.dart';
import 'package:readar/Utils/responsive_util.dart';
import 'package:provider/provider.dart';

import '../../Resources/theme_color_data.dart';
import '../../Utils/enums.dart';
import '../../Utils/route_util.dart';
import '../../Widgets/BottomSheet/bottom_sheet_builder.dart';
import '../../Widgets/BottomSheet/list_bottom_sheet.dart';
import '../../Widgets/General/EasyRefresh/easy_refresh.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class AppearanceSettingScreen extends StatefulWidget {
  const AppearanceSettingScreen({super.key});

  static const String routeName = "/setting/apperance";

  @override
  State<AppearanceSettingScreen> createState() =>
      _AppearanceSettingScreenState();
}

class _AppearanceSettingScreenState extends State<AppearanceSettingScreen>
    with TickerProviderStateMixin {
  bool _enableLandscapeInTablet =
      HiveUtil.getBool(HiveUtil.enableLandscapeInTabletKey, defaultValue: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: ItemBuilder.buildResponsiveAppBar(
            showBack: true,
          title: S.current.appearanceSetting,
          context: context,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: EasyRefresh(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              if (ResponsiveUtil.isLandscape()) const SizedBox(height: 10),
              ItemBuilder.buildCaptionItem(
                  context: context, title: S.current.themeSetting),
              Selector<AppProvider, ActiveThemeMode>(
                selector: (context, globalProvider) => globalProvider.themeMode,
                builder: (context, themeMode, child) =>
                    ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.themeMode,
                  tip: AppProvider.getThemeModeLabel(themeMode),
                  onTap: () {
                    BottomSheetBuilder.showListBottomSheet(
                      context,
                      (context) => TileList.fromOptions(
                        AppProvider.getSupportedThemeMode(),
                        (item2) {
                          appProvider.themeMode = item2;
                          Navigator.pop(context);
                        },
                        selected: themeMode,
                        context: context,
                        title: S.current.chooseThemeMode,
                        onCloseTap: () => Navigator.pop(context),
                      ),
                    );
                  },
                ),
              ),
              Selector<AppProvider, ThemeColorData>(
                selector: (context, appProvider) => appProvider.lightTheme,
                builder: (context, lightTheme, child) =>
                    Selector<AppProvider, ThemeColorData>(
                  selector: (context, appProvider) => appProvider.darkTheme,
                  builder: (context, darkTheme, child) =>
                      ItemBuilder.buildEntryItem(
                    context: context,
                    title: S.current.selectTheme,
                    tip: "${lightTheme.name}/${darkTheme.name}",
                    onTap: () {
                      RouteUtil.pushPanelCupertinoRoute(
                          context, const SelectThemeScreen());
                    },
                  ),
                ),
              ),
              Selector<AppProvider, CustomFont>(
                selector: (context, appProvider) => appProvider.currentFont,
                builder: (context, currentFont, child) =>
                    ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.chooseFontFamily,
                  tip: currentFont.intlFontName,
                  roundBottom: true,
                  onTap: () {
                    RouteUtil.pushPanelCupertinoRoute(
                        context, const SelectFontScreen());
                  },
                ),
              ),
              if (ResponsiveUtil.isTablet()) const SizedBox(height: 10),
              if (ResponsiveUtil.isTablet())
                ItemBuilder.buildRadioItem(
                  value: _enableLandscapeInTablet,
                  context: context,
                  title: S.current.useDesktopLayoutWhenLandscape,
                  roundTop: true,
                  roundBottom: true,
                  onTap: () {
                    setState(() {
                      _enableLandscapeInTablet = !_enableLandscapeInTablet;
                      appProvider.enableLandscapeInTablet =
                          _enableLandscapeInTablet;
                    });
                  },
                ),
              const SizedBox(height: 10),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
