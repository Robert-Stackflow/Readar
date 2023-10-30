import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class ExtensionSettingScreen extends StatefulWidget {
  const ExtensionSettingScreen({super.key});

  static const String routeName = "/setting/extension";

  @override
  State<ExtensionSettingScreen> createState() => _ExtensionSettingScreenState();
}

class _ExtensionSettingScreenState extends State<ExtensionSettingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildSimpleAppBar(
            title: S.current.extensionSetting, context: context),
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
                ItemBuilder.buildCaptionItem(
                    context: context, title: "以下服务可用于直接保存文章"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "Pocket",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "Evernote",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "Instapaper",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "OneNote",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "Notion",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "PinBoard",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "印象笔记",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "为知笔记",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "专注笔记",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "有道云笔记",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "Joplin",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "flomo",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "建议新的服务",
                  description: "向我们建议你希望支持的笔记服务",
                  topRadius: true,
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
