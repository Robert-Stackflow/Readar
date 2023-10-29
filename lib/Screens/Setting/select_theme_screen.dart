import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildAppBar(
            title: S.current.selectTheme, context: context),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ScrollConfiguration(
            behavior: NoShadowScrollBehavior(),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                ItemBuilder.buildCaptionItem(
                    context: context, title: S.current.lightTheme),
                ItemBuilder.buildContainerItem(
                  context: context,
                  child: const SizedBox(height: 150),
                  bottomRadius: true,
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: S.current.darkTheme),
                ItemBuilder.buildContainerItem(
                  child: const SizedBox(height: 150),
                  context: context,
                  bottomRadius: true,
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: S.current.primaryColor),
                ItemBuilder.buildContainerItem(
                  context: context,
                  child: const SizedBox(height: 100),
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
}
