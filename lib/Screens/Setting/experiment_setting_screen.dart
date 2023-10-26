import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class ExperimentSettingScreen extends StatefulWidget {
  const ExperimentSettingScreen({super.key});

  static const String routeName = "/setting/experiment";

  @override
  State<ExperimentSettingScreen> createState() =>
      _ExperimentSettingScreenState();
}

class _ExperimentSettingScreenState extends State<ExperimentSettingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildAppBar(
            title: S.current.experimentSetting, context: context),
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
                  value: true,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "启用Cloud Reader AI",
                  description: "官方提供的AI服务，我们承诺不会泄露您的隐私",
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "第三方AI服务管理",
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
                  value: true,
                  topRadius: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "第三方翻译服务管理",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "源语言",
                  description: "当文章为何种语言时自动翻译",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
