import 'package:flutter/material.dart';
import 'package:readar/Screens/Setting/apperance_setting_screen.dart';
import 'package:readar/Screens/Setting/general_setting_screen.dart';
import 'package:readar/Screens/Setting/rss_service_setting_screen.dart';
import 'package:readar/Utils/app_provider.dart';

import '../../Utils/responsive_util.dart';
import '../../Utils/route_util.dart';
import '../../Widgets/General/EasyRefresh/easy_refresh.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';
import 'about_setting_screen.dart';
import 'ai_setting_screen.dart';
import 'backup_service_setting_screen.dart';
import 'backup_setting_screen.dart';
import 'experiment_setting_screen.dart';
import 'extension_setting_screen.dart';
import 'global_setting_screen.dart';
import 'operation_setting_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  static const String routeName = "/setting";

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildResponsiveAppBar(
          showBack: true,
          title: S.current.setting,
          context: context,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: EasyRefresh(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              if (ResponsiveUtil.isLandscape()) const SizedBox(height: 10),
              ItemBuilder.buildCaptionItem(
                  context: context, title: S.current.basicSetting),
              ItemBuilder.buildEntryItem(
                context: context,
                title: S.current.generalSetting,
                showLeading: true,
                onTap: () {
                  RouteUtil.pushPanelCupertinoRoute(context,
                      GeneralSettingScreen(key: generalSettingScreenKey));
                },
                leading: Icons.settings_outlined,
              ),
              ItemBuilder.buildEntryItem(
                context: context,
                title: S.current.appearanceSetting,
                showLeading: true,
                onTap: () {
                  RouteUtil.pushPanelCupertinoRoute(
                      context, const AppearanceSettingScreen());
                },
                leading: Icons.color_lens_outlined,
              ),
              ItemBuilder.buildEntryItem(
                context: context,
                showLeading: true,
                title: S.current.globalSetting,
                onTap: () {
                  RouteUtil.pushPanelCupertinoRoute(
                      context, const GlobalSettingScreen());
                },
                leading: Icons.settings_applications_outlined,
              ),
              ItemBuilder.buildEntryItem(
                context: context,
                title: S.current.operationSetting,
                showLeading: true,
                roundBottom: true,
                onTap: () {
                  RouteUtil.pushPanelCupertinoRoute(
                      context, const OperationSettingScreen());
                },
                leading: Icons.touch_app_outlined,
              ),
              const SizedBox(height: 10),
              ItemBuilder.buildCaptionItem(
                  context: context, title: S.current.advancedSetting),
              ItemBuilder.buildEntryItem(
                context: context,
                title: S.current.rssServiceSetting,
                showLeading: true,
                onTap: () {
                  RouteUtil.pushPanelCupertinoRoute(
                      context, const RssServiceSettingScreen());
                },
                leading: Icons.business_center_outlined,
              ),
              ItemBuilder.buildEntryItem(
                context: context,
                title: S.current.backupSetting,
                showLeading: true,
                onTap: () {
                  RouteUtil.pushPanelCupertinoRoute(
                      context, const BackupSettingScreen());
                },
                leading: Icons.backup_outlined,
              ),
              ItemBuilder.buildEntryItem(
                context: context,
                title: S.current.extensionSetting,
                showLeading: true,
                onTap: () {
                  RouteUtil.pushPanelCupertinoRoute(
                      context, const ExtensionSettingScreen());
                },
                leading: Icons.extension_outlined,
              ),
              ItemBuilder.buildEntryItem(
                context: context,
                title: S.current.aiSetting,
                showLeading: true,
                onTap: () {
                  RouteUtil.pushPanelCupertinoRoute(
                      context, const AISettingScreen());
                },
                leading: Icons.face_rounded,
              ),
              ItemBuilder.buildEntryItem(
                context: context,
                title: S.current.experimentSetting,
                showLeading: true,
                roundBottom: true,
                onTap: () {
                  RouteUtil.pushPanelCupertinoRoute(
                      context, const ExperimentSettingScreen());
                },
                leading: Icons.flag_outlined,
              ),
              const SizedBox(height: 10),
              ItemBuilder.buildEntryItem(
                context: context,
                title: S.current.about,
                roundBottom: true,
                roundTop: true,
                showLeading: true,
                padding: 15,
                onTap: () {
                  RouteUtil.pushPanelCupertinoRoute(
                      context, const AboutSettingScreen());
                },
                leading: Icons.info_outline_rounded,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
