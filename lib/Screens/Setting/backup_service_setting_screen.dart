import 'package:flutter/material.dart';
import 'package:readar/Widgets/Custom/no_shadow_scroll_behavior.dart';

import '../../Utils/responsive_util.dart';
import '../../Utils/uri_util.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class BackupServiceSettingScreen extends StatefulWidget {
  const BackupServiceSettingScreen({super.key});

  static const String routeName = "/setting/backup/service";

  @override
  State<BackupServiceSettingScreen> createState() =>
      _BackupServiceSettingScreenState();
}

class _BackupServiceSettingScreenState extends State<BackupServiceSettingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildResponsiveAppBar(
          showBack: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: S.current.backupServiceSetting,
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
                if (ResponsiveUtil.isLandscape()) const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "云端备份服务使用指南",
                  roundTop: true,
                  roundBottom: true,
                  leading: Icons.info,
                  showLeading: true,
                  showTrailing: false,
                  onTap: () {
                    UriUtil.launchUrlUri(context,
                        "https://rssreader.cloudchewie.com/help/cloudBackup");
                  },
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context,
                    title:
                        "以下服务可用于备份软件配置、订阅源、星标、稍后再读、阅读历史、集锦等内容，其中星标、稍后再读、阅读历史不会备份文章正文；当你设置云盘备份服务后，也可以选择将文章以PDF/EPUB/MOBI格式导出到云盘"),
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
                  roundBottom: true,
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
