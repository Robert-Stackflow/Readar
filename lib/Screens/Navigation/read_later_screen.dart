import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Providers/provider_manager.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../Widgets/Scaffold/my_appbar.dart';

class ReadLaterScreen extends StatefulWidget {
  const ReadLaterScreen({super.key});

  static const String routeName = "/nav/readLater";

  @override
  State<ReadLaterScreen> createState() => _ReadLaterScreenState();
}

class _ReadLaterScreenState extends State<ReadLaterScreen>
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

  MyAppBar _buildAppBar() {
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
        ItemBuilder.buildIconButton(
            context: context,
            icon:
                Icon(Icons.search_rounded, color: IconTheme.of(context).color),
            onTap: () {}),
        const SizedBox(width: 5),
        ItemBuilder.buildIconButton(
            context: context,
            icon: Icon(Icons.filter_list_rounded,
                color: IconTheme.of(context).color),
            onTap: () {}),
        const SizedBox(width: 5),
      ],
    );
  }
}
