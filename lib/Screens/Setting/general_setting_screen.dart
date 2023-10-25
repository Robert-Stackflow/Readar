import 'package:cloudreader/Themes/icon.dart';
import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Utils/cache_util.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../Widgets/item_builder.dart';

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
            "通用",
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
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "启用TTS",
                  value: true,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "TTS引擎",
                  tip: "默认引擎",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "默认朗读速度",
                  tip: "1.0x",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "忽略音频焦点",
                  value: true,
                  description: "允许与其他应用同时播放音频",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "自动阅读",
                  value: true,
                  description: "文章朗读完毕后自动阅读下一篇",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "自动标记为已读",
                  value: true,
                  description: "文章朗读完毕后自动标记为已读",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "唤醒锁",
                  value: true,
                  description: "开启朗读时启用唤醒锁(可能会被杀后台)",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "系统TTS设置",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "检查更新",
                  topRadius: true,
                  bottomRadius: true,
                  description: "上次检查更新:2023-04-15",
                  tip: "1.0.0",
                  onTap: () {
                    IToast.showTop(context, text: "已经是最新版本");
                  },
                  leading: Iconfont.jiju,
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  title: "清除缓存",
                  description: "包含下载的图片、文章等",
                  topRadius: true,
                  bottomRadius: true,
                  tip: _cacheSize,
                  onTap: () {
                    getTemporaryDirectory().then((tempDir) {
                      CacheUtil.delDir(tempDir).then((value) {
                        CacheUtil.loadCache().then((value) {
                          setState(() {
                            _cacheSize = value;
                            IToast.showTop(context, text: '清除缓存成功');
                          });
                        });
                      });
                    });
                  },
                  leading: Iconfont.anquan,
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
