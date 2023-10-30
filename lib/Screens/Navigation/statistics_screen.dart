import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Widgets/Item/item_builder.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  static const String routeName = "/nav/statistics";

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with TickerProviderStateMixin {
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
          Scaffold.of(context).openDrawer();
        } else {
          Navigator.of(context).pop();
        }
      },
      actions: [
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
