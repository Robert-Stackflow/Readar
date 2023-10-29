import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StarScreen extends StatefulWidget {
  const StarScreen({super.key});

  static const String routeName = "/nav/star";

  @override
  State<StarScreen> createState() => _StarScreenState();
}

class _StarScreenState extends State<StarScreen> with TickerProviderStateMixin {
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
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: _isNavigationBarEntry()
          ? IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon:
                  Icon(Icons.menu_rounded, color: IconTheme.of(context).color),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            )
          : IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.arrow_back_rounded,
                  color: IconTheme.of(context).color),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
