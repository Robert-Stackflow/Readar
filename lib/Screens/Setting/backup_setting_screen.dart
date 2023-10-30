import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class BackupSettingScreen extends StatefulWidget {
  const BackupSettingScreen({super.key});

  static const String routeName = "/setting/backup";

  @override
  State<BackupSettingScreen> createState() => _BackupSettingScreenState();
}

class _BackupSettingScreenState extends State<BackupSettingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildSimpleAppBar(
            title: S.current.backupSetting, context: context),
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
                    context: context, title: "本地备份与恢复"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "导出配置为JSON文件",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "从JSON文件导入配置",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "导出订阅源为OPML文件",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "从OPML文件导入订阅源",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: "以下服务可用于备份数据，并将文章保存为PDF"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "Dropbox",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "Google Drive",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "OneDrive",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "坚果云",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "其他WebDAV服务",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "查看如何使用备份服务",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: "云端备份与恢复"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "启用云端备份",
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "选择云端",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "立即备份到云服务",
                  // description: "备份软件配置、订阅源、星标、稍后再读、阅读历史、剪切板到云服务",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "从云服务恢复备份",
                  onTap: () {},
                  bottomRadius: true,
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "自动备份"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "启用自动备份",
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "自动备份时机",
                  description: "选择何种操作后自动备份到云服务(软件配置更改、订阅源更改等)",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "自动备份份数阈值",
                  description: "自动备份时，备份数超过该阈值后新备份将自动覆盖旧备份",
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
