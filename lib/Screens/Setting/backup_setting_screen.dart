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
        appBar: ItemBuilder.buildAppBar(
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
                ItemBuilder.buildEntryItem(
                  title: "从本地导出配置",
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "从本地导入配置",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "导出为OPML文件",
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "从OPML文件导入",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "启用云服务备份",
                  topRadius: true,
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "云服务备份指南",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "选择云服务",
                  description: "选择要备份到的云服务",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "立即备份到云服务",
                  description: "备份软件配置、订阅源、星标、稍后再读、阅读历史、剪切板到云服务",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "从云服务恢复备份",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "自动备份",
                  topRadius: true,
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "自动备份时机",
                  description: "选择何种操作后自动备份到云服务(软件配置更改、订阅源更改等)",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
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
