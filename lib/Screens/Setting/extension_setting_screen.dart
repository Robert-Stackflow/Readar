import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../Widgets/item_builder.dart';
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
        appBar: ItemBuilder.buildAppBar(title: S.current.extensionSetting),
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
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Dropbox",
                  description: "向你的Dropbox帐号中备份数据并保存文章为PDF",
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Google Drive",
                  description: "向你的Google Drive帐号中备份数据并保存文章为PDF",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "坚果云",
                  description: "向你的坚果云帐号中备份数据并保存文章为PDF",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "WebDAV",
                  description: "向你的WebDAV帐号中备份数据并保存文章为PDF",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Pocket",
                  description: "将文章保存到你的Pocket帐号中",
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Evernote",
                  description: "将文章保存到你的Evernote帐号中",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Instapaper",
                  description: "将文章保存到你的Instapaper帐号中",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "OneNote",
                  description: "将文章保存到你的OneNote帐号中",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Notion",
                  description: "将文章保存到你的Notion帐号中",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "印象笔记",
                  description: "将文章保存到你的印象笔记帐号中",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "为知笔记",
                  description: "将文章保存到你的为知笔记帐号中",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "专注笔记",
                  description: "将文章保存到你的专注笔记帐号中",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "有道云笔记",
                  description: "将文章保存到你的有道云笔记帐号中",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Joplin",
                  description: "将文章保存到你的Joplin帐号中",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "flomo",
                  description: "将文章保存到你的flomo帐号中",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "其他帐户",
                  description: "向我们建议你希望支持的云服务",
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
