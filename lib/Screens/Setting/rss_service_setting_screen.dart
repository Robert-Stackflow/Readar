import 'package:flutter/material.dart';
import 'package:readar/Widgets/Custom/no_shadow_scroll_behavior.dart';

import '../../Utils/responsive_util.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';

class RssServiceSettingScreen extends StatefulWidget {
  const RssServiceSettingScreen({super.key});

  static const String routeName = "/setting/rssService";

  @override
  State<RssServiceSettingScreen> createState() => _RssServiceSettingScreenState();
}

class _RssServiceSettingScreenState extends State<RssServiceSettingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildResponsiveAppBar(
          showBack: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: S.current.rssServiceSetting,
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
                    context: context, title: "第三方RSS服务"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "Inoreader",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "FeedHQ",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "Feedbin",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "Feed Wrangler",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "The Old Reader",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "BazQux Reader",
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: false,
                  title: "NewsBlur",
                  roundBottom: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: "自建RSS服务"),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "Fever API",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "FreshRSS API",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "Google Reader API",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "Miniflux",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "Nextcloud News API",
                  roundBottom: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "建议新的RSS服务",
                  description: "向我们建议你希望支持的RSS服务",
                  roundTop: true,
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
