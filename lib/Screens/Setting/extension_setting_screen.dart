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
        appBar: ItemBuilder.buildAppBar(
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
                ItemBuilder.buildEntryItem(
                  title: "以下自建类型服务可用于同步订阅源",
                  isCaption: true,
                  showTrailing: false,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "Fever API",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "FreshRSS API",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "Google Reader API",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "Miniflux",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "Nextcloud News API",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "以下商业服务可用于同步订阅源",
                  isCaption: true,
                  showTrailing: false,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Inoreader",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Feedbin",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "The Old Reader",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "BazQux Reader",
                  bottomRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "NewsBlur",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "以下服务可用于备份数据，并保存文章为PDF",
                  isCaption: true,
                  showTrailing: false,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Dropbox",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Google Drive",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "OneDrive",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "坚果云",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "其他WebDAV服务",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "以下服务可用于直接保存文章",
                  isCaption: true,
                  showTrailing: false,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Pocket",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Evernote",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Instapaper",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "OneNote",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Notion",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "印象笔记",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "为知笔记",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "专注笔记",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "有道云笔记",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "Joplin",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  value: false,
                  title: "flomo",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "建议新的服务",
                  description: "向我们建议你希望支持的服务（包括订阅源服务、云盘服务、笔记服务）",
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
