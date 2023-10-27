import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';

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
        appBar: ItemBuilder.buildAppBar(
            title: S.current.operationSetting, context: context),
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
                  title: "文章列表快捷操作",
                  topRadius: true,
                ),
                ItemBuilder.buildEntryItem(
                  title: "向左短滑动",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "向左长滑动",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "向右短滑动",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "向右长滑动",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  title: "滚动时自动标记已读",
                  bottomRadius: true,
                  value: false,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                  title: "文章详情页快捷操作",
                  topRadius: true,
                ),
                ItemBuilder.buildEntryItem(
                  title: "双击页面",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "触顶滑动",
                  description: "仅在视图选项为非上下滑动式时生效",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  title: "触底滑动",
                  description: "仅在视图选项为非上下滑动式时生效",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  title: "标记为已读前确认",
                  topRadius: true,
                  bottomRadius: true,
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
