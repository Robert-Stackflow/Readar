import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../Widgets/item_builder.dart';

class LabSettingScreen extends StatefulWidget {
  const LabSettingScreen({super.key});

  static const String routeName = "/setting/lab";

  @override
  State<LabSettingScreen> createState() => _LabSettingScreenState();
}

class _LabSettingScreenState extends State<LabSettingScreen>
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
            "实验室",
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
                  title: "AI摘要",
                  description: "关闭后文章详情页将不再显示摘要",
                  value: true,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "启用Cloud Reader AI",
                  description: "关闭后将无法使用Cloud Reader提供的AI服务",
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "第三方AI服务管理",
                  description: "通过API Key启用第三方AI服务",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "聊天室",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "翻译",
                  description: "关闭后将无法使用文章翻译功能",
                  value: true,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "第三方翻译服务管理",
                  description: "通过API Key启用第三方翻译服务",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "源语言",
                  description: "自动翻译源语言",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "目标语言",
                  description: "将文章自动翻译为目标语言",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "硬件加速",
                  value: true,
                  description: "启用以提高软件运行流畅度，也可能会造成一些问题",
                  topRadius: true,
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "预览视频",
                  value: true,
                  description: "启用后将在文章详情页显示解析到的视频",
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
