import 'package:flutter/material.dart';
import 'package:readar/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:readar/Widgets/Item/item_builder.dart';

import '../../Utils/responsive_util.dart';
import '../../generated/l10n.dart';

class GlobalSettingScreen extends StatefulWidget {
  const GlobalSettingScreen({super.key});

  static const String routeName = "/setting/global";

  @override
  State<GlobalSettingScreen> createState() => _GlobalSettingScreenState();
}

class _GlobalSettingScreenState extends State<GlobalSettingScreen>
    with TickerProviderStateMixin {
  @override
  initState() {
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
          title: S.current.globalSetting,
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
                ItemBuilder.buildCaptionItem(
                  context: context,
                  roundBottom: true,
                  title: "以下为针对所有订阅源的全局设置。你可以通过修改某个具体订阅源的局部设置，来覆盖全局设置",
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "拉取文章"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.pullStrategy,
                  tip: "仅在充电且使用WiFi时",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.cacheImageWhenPull,
                  tip: "仅在充电且使用WiFi时",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.cacheWebPageWhenPull,
                  tip: "仅在充电且使用WiFi时",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.cacheWebPageWhenReading,
                  tip: "仅在充电且使用WiFi时",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.removeDuplicateArticles,
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.pullWhenStartUp,
                  value: true,
                  roundBottom: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "文章列表"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.articleListLayoutType,
                  tip: "卡片",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.autoReadWhenScrolling,
                  value: true,
                  roundBottom: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: "文章详情页布局"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.articleDetailLayoutType,
                  tip: "左右滑动",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.articleDetailHeaderImageViewType,
                  tip: "全文图片轮播",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.articleDetailVideoViewType,
                  tip: "截取图片",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.articleDetailShowRelatedArticles,
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.articleDetailShowImageAlt,
                  value: true,
                  roundBottom: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: "文章详情页功能"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.crawlType,
                  tip: "抓取全文",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.mobilizerType,
                  tip: "Feedbin Parser",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "启用自动翻译",
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "启用AI摘要",
                  value: true,
                  onTap: () {},
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
