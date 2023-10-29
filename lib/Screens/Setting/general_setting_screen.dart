import 'package:cloudreader/Utils/cache_util.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class GeneralSettingScreen extends StatefulWidget {
  const GeneralSettingScreen({super.key});

  static const String routeName = "/setting/general";

  @override
  State<GeneralSettingScreen> createState() => _GeneralSettingScreenState();
}

class _GeneralSettingScreenState extends State<GeneralSettingScreen>
    with TickerProviderStateMixin {
  String _cacheSize = "";

  @override
  void initState() {
    super.initState();
    CacheUtil.loadCache().then((value) {
      setState(() {
        _cacheSize = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildAppBar(
            title: S.current.generalSetting, context: context),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ScrollConfiguration(
            behavior: NoShadowScrollBehavior(),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                ItemBuilder.buildCaptionItem(
                    context: context, title: S.current.ttsSetting),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.ttsEnable,
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.ttsEngine,
                  tip: "默认引擎",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.ttsSpeed,
                  tip: "1.0x",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.ttsSystemSetting,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.ttsSpot,
                  value: true,
                  description: S.current.ttsSpotTip,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.ttsAutoHaveRead,
                  value: true,
                  description: S.current.ttsAutoHaveReadTip,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.ttsWakeLock,
                  value: true,
                  description: S.current.ttsWakeLockTip,
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.checkUpdates,
                  topRadius: true,
                  bottomRadius: true,
                  description: "${S.current.checkUpdatesTip}2023-04-15",
                  tip: "1.0.0",
                  onTap: () {
                    IToast.showTop(context,
                        text: S.current.checkUpdatesAlreadyLatest);
                  },
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.clearCache,
                  topRadius: true,
                  bottomRadius: true,
                  tip: _cacheSize,
                  onTap: () {
                    getTemporaryDirectory().then((tempDir) {
                      CacheUtil.delDir(tempDir).then((value) {
                        CacheUtil.loadCache().then((value) {
                          setState(() {
                            _cacheSize = value;
                            IToast.showTop(context,
                                text: S.current.clearCacheSuccess);
                          });
                        });
                      });
                    });
                  },
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
