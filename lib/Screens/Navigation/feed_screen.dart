import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Providers/provider_manager.dart';
import '../../Widgets/Item/item_builder.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  static const String routeName = "/nav/subscription";

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(),
    );
  }

  bool _isNavigationBarEntry() {
    String? name = ModalRoute.of(context)!.settings.name;
    Object? arguments = ModalRoute.of(context)!.settings.arguments;
    if (name != null && arguments != null && name == "isNavigationBarEntry") {
      return arguments as bool;
    } else {
      return true;
    }
  }

  AppBar _buildAppBar() {
    return ItemBuilder.buildAppBar(
      context: context,
      leading: _isNavigationBarEntry()
          ? Icons.menu_rounded
          : Icons.arrow_back_rounded,
      onLeadingTap: () {
        if (_isNavigationBarEntry()) {
          ProviderManager.globalProvider.homeScaffoldKey.currentState
              ?.openDrawer();
          ProviderManager.globalProvider.isDrawerOpen = true;
        } else {
          Navigator.of(context).pop();
        }
      },
      actions: [
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon:
              Icon(Icons.add_link_rounded, color: IconTheme.of(context).color),
          onPressed: () {},
        ),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(Icons.search_rounded, color: IconTheme.of(context).color),
          onPressed: () {},
        ),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(Icons.filter_list_rounded,
              color: IconTheme.of(context).color),
          onPressed: () {},
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
