import 'package:afar/Providers/provider_manager.dart';
import 'package:afar/Resources/theme_color_data.dart';
import 'package:afar/Utils/hive_util.dart';
import 'package:afar/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class SelectThemeScreen extends StatefulWidget {
  const SelectThemeScreen({super.key});

  static const String routeName = "/setting/theme";

  @override
  State<SelectThemeScreen> createState() => _SelectThemeScreenState();
}

class _SelectThemeScreenState extends State<SelectThemeScreen>
    with TickerProviderStateMixin {
  int _selectedLightIndex = HiveUtil.getLightThemeIndex();
  int _selectedDarkIndex = HiveUtil.getDarkThemeIndex();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildSimpleAppBar(
            title: S.current.selectTheme, context: context),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ScrollConfiguration(
            behavior: NoShadowScrollBehavior(),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: S.current.lightTheme),
                ItemBuilder.buildContainerItem(
                  context: context,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicHeight(
                        child: Row(
                          children: _buildLightThemeList(),
                        ),
                      ),
                    ),
                  ),
                  bottomRadius: true,
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: S.current.darkTheme),
                ItemBuilder.buildContainerItem(
                  context: context,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicHeight(
                        child: Row(
                          children: _buildDarkThemeList(),
                        ),
                      ),
                    ),
                  ),
                  bottomRadius: true,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLightThemeList() {
    var list = List<Widget>.generate(
      ThemeColorData.defaultLightThemes.length,
      (index) => ItemBuilder.buildThemeItem(
          index: index,
          groupIndex: _selectedLightIndex,
          themeColorData: ThemeColorData.defaultLightThemes[index],
          context: context,
          onChanged: (index) {
            setState(() {
              _selectedLightIndex = index ?? 0;
              ProviderManager.globalProvider.setLightTheme(index ?? 0);
            });
          }),
    );
    // list.add(ItemBuilder.buildEmptyThemeItem(context: context, onTap: null));
    return list;
  }

  List<Widget> _buildDarkThemeList() {
    var list = List<Widget>.generate(
      ThemeColorData.defaultDarkThemes.length,
      (index) => ItemBuilder.buildThemeItem(
          index: index,
          groupIndex: _selectedDarkIndex,
          themeColorData: ThemeColorData.defaultDarkThemes[index],
          context: context,
          onChanged: (index) {
            setState(() {
              _selectedDarkIndex = index ?? 0;
              ProviderManager.globalProvider.setDarkTheme(index ?? 0);
            });
          }),
    );
    // list.add(ItemBuilder.buildEmptyThemeItem(context: context, onTap: null));
    return list;
  }
}
