import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:cloudreader/Widgets/tab_indicator.dart';
import 'package:flutter/material.dart';

class MainTabData {
  final Widget child;
  final String label;

  const MainTabData({
    required this.label,
    required this.child,
  });
}

class MainTabView extends StatelessWidget {
  final List<MainTabData> tabs;
  final Animation<double>? paddingAnimation;

  const MainTabView({
    super.key,
    required this.tabs,
    this.paddingAnimation,
  });

  @override
  Widget build(BuildContext context) {
    var isDark = true;

    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTopAnimatedPadding(),
            _buildTabBar(isDark),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAnimatedPadding() {
    if (paddingAnimation == null) {
      return const SizedBox(height: 6);
    }

    return AnimatedBuilder(
      animation: paddingAnimation!,
      builder: (context, _) => SizedBox(
        height: (1 - paddingAnimation!.value) * 16 + 6,
      ),
    );
  }

  Widget _buildTabBar(bool isDark) {
    return TabBar(
      tabs: tabs.map((value) {
        var tp = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: value.label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        )..layout();
        return Tab(
          child: SizedBox(
            width: tp.width,
            child: Text(value.label),
          ),
        );
      }).toList(),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      enableFeedback: true,
      physics: const BouncingScrollPhysics(),
      labelColor: AppTheme.darkerText,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 18,
        color: AppTheme.darkerText,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 18,
        color: Colors.grey,
      ),
      indicator: const TabIndicator(),
    );
  }

  Widget _buildTabContent() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: NoShadowScrollBehavior(),
        child: TabBarView(
          children: tabs.map((tab) => tab.child).toList(),
        ),
      ),
    );
  }
}
