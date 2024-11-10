import 'package:flutter/material.dart';

import '../../Utils/responsive_util.dart';
import '../../Widgets/Custom/no_shadow_scroll_behavior.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class AISettingScreen extends StatefulWidget {
  const AISettingScreen({super.key});

  static const String routeName = "/setting/experiment";

  @override
  State<AISettingScreen> createState() => _AISettingScreenState();
}

class _AISettingScreenState extends State<AISettingScreen>
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: S.current.aiSetting,
          context: context,
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
                if (ResponsiveUtil.isLandscape()) const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "AI摘要"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "第三方AI服务管理",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "内容发送模板",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "内容发送字数上限",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "聊天室",
                  roundBottom: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "AI翻译"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "第三方翻译服务管理",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "源语言",
                  description: "当文章为何种语言时自动翻译",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "目标语言",
                  description: "将文章自动翻译为目标语言",
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
