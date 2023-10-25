import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../Widgets/item_builder.dart';

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
        appBar: AppBar(
          elevation: 0.2,
          leadingWidth: 40,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.darkerText,
              size: 23,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "备份",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: AppTheme.darkerText,
                fontSize: 17),
          ),
          backgroundColor: AppTheme.background,
        ),
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
                  description: "将订阅源导出为OPML文件",
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "从OPML文件导入",
                  description: "从OPML文件导入订阅源",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "启用云服务",
                  topRadius: true,
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "云服务指南",
                  description: "查看有关云服务的相关指南",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "选择云服务",
                  description: "选择要备份到的云服务",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "立即备份到云服务",
                  description: "将备份软件配置、订阅源、星标、稍后再读、阅读历史、剪切板到云服务",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "从云服务恢复备份",
                  description: "选择备份文件后可选择需要恢复的内容",
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
                  description: "自动备份时，超过该阈值后将自动覆盖旧备份",
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
