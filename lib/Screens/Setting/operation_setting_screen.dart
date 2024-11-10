import 'package:flutter/material.dart';
import 'package:readar/Widgets/Custom/no_shadow_scroll_behavior.dart';

import '../../Utils/responsive_util.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class OperationSettingScreen extends StatefulWidget {
  const OperationSettingScreen({super.key});

  static const String routeName = "/setting/operation";

  @override
  State<OperationSettingScreen> createState() => _OperationSettingScreenState();
}

class _OperationSettingScreenState extends State<OperationSettingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildResponsiveAppBar(
          showBack: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: S.current.operationSetting,
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
                ItemBuilder.buildCaptionItem(
                    context: context, title: "文章列表快捷操作"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "向左短滑动",
                  tip: "标记为星标",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "向左长滑动",
                  tip: "分享文章",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "向右短滑动",
                  tip: "标记为已读",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "向右长滑动",
                  tip: "加入稍后读",
                  onTap: () {},
                  roundBottom: true,
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: "文章详情页快捷操作"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "双击页面",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "触顶滑动",
                  description: "仅在视图选项为非上下滑动式时生效",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "触底滑动",
                  description: "仅在视图选项为非上下滑动式时生效",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "音量键",
                  tip: "切换文章",
                  roundBottom: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "其他选项"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "隐藏空的订阅源",
                  value: false,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "仅在WiFi下加载图片",
                  description: "图片将以占位符显示，你可以点击以加载",
                  value: false,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "标记为已读前确认",
                  roundBottom: true,
                  value: false,
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
