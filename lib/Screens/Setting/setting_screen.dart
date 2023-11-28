import 'package:cloudreader/Screens/Setting/service_setting_screen.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/uri_util.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';
import 'about_setting_screen.dart';
import 'backup_setting_screen.dart';
import 'experiment_setting_screen.dart';
import 'extension_setting_screen.dart';
import 'general_setting_screen.dart';
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
        appBar: ItemBuilder.buildSimpleAppBar(
            title: S.current.setting, context: context),
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
                    context: context, title: S.current.basicSetting),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.generalSetting,
                  showLeading: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                const GeneralSettingScreen()));
                  },
                  leading: Icons.settings_outlined,
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  showLeading: true,
                  title: S.current.globalSetting,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const GlobalSettingScreen()));
                  },
                  leading: Icons.settings_applications_outlined,
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.operationSetting,
                  showLeading: true,
                  bottomRadius: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                const OperationSettingScreen()));
                  },
                  leading: Icons.touch_app_outlined,
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: S.current.advancedSetting),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.serviceSetting,
                  showLeading: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                const ServiceSettingScreen()));
                  },
                  leading: Icons.business_center_outlined,
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.backupSetting,
                  showLeading: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const BackupSettingScreen()));
                  },
                  leading: Icons.backup_outlined,
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.extensionSetting,
                  showLeading: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                const ExtensionSettingScreen()));
                  },
                  leading: Icons.extension_outlined,
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  showLeading: true,
                  title: S.current.experimentSetting,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                const ExperimentSettingScreen()));
                  },
                  bottomRadius: true,
                  leading: Icons.outlined_flag_rounded,
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
