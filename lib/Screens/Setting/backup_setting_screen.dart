import 'package:flutter/material.dart';
import 'package:readar/Utils/route_util.dart';
import 'package:readar/Widgets/Custom/no_shadow_scroll_behavior.dart';

import '../../Utils/responsive_util.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';
import 'backup_service_setting_screen.dart';

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
        appBar: ItemBuilder.buildResponsiveAppBar(
          showBack: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: S.current.backupSetting,
          context: context,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ScrollConfiguration(
            behavior: NoShadowScrollBehavior(),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                // const SizedBox(height: 10),
                // ItemBuilder.buildCaptionItem(
                //   context: context,
                //   leading: Icons.info_outline_rounded,
                //   showLeading: true,
                //   title: "备份内容包括：软件配置、订阅源、星标、稍后再读、阅读历史、集锦",
                //   roundBottom: true,
                // ),
                if (ResponsiveUtil.isLandscape()) const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "云端备份设置"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "启用云端备份",
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "选择备份服务",
                  description: "已选择：Dropbox",
                  onTap: () {
                    RouteUtil.pushPanelCupertinoRoute(
                        context, const BackupServiceSettingScreen());
                  },
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "立即备份到云端",
                  description: "上次备份时间：2023-11-11 20:10:09",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "从云端拉取备份",
                  description: "上次拉取时间：2023-11-11 20:10:09",
                  roundBottom: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: "云端自动备份设置"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "启用自动备份",
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "自动备份时机",
                  description: "已选择：软件配置更改后、订阅源更改后、插件设置更改后",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "备份份数阈值",
                  tip: "20份",
                  description: "已有备份份数超过该阈值后，新备份将自动覆盖旧备份；当设置为1份时，即表示仅保留最新备份",
                  roundBottom: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "本地备份"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "设置备份路径",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "备份到本地",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "从本地导入备份",
                  roundBottom: true,
                  onTap: () {},
                ),
                // ItemBuilder.buildEntryItem(
                //   context: context,
                //   title: "导出订阅源为OPML文件",
                //   onTap: () {},
                // ),
                // ItemBuilder.buildEntryItem(
                //   context: context,
                //   title: "从OPML文件导入订阅源",
                //   roundBottom: true,
                //   onTap: () {},
                // ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "其他选项"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "设置备份密码",
                  description:
                      "本地密码用来对备份中的敏感信息（如服务的密码）加密和解密，如需在不同设备间同步，本地密码需一致",
                  onTap: () {},
                  showTrailing: false,
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "恢复忽略列表",
                  description: "当从本地或云端恢复备份时不恢复的内容",
                  onTap: () {},
                  showTrailing: false,
                  roundBottom: true,
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
