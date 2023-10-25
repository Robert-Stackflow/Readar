import 'dart:io';

import 'package:cloudreader/Screens/Content/tts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ReadLaterScreen extends StatefulWidget {
  const ReadLaterScreen({super.key});

  static const String routeName = "/nav/readLater";

  @override
  State<ReadLaterScreen> createState() => _ReadLaterScreenState();
}

class _ReadLaterScreenState extends State<ReadLaterScreen>
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
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        body: SafeArea(
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 5),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.dehaze_rounded,
                        size: 23,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.headset_outlined,
                        size: 23,
                      ),
                      onPressed: () {
                        Get.toNamed(TTSScreen.routeName);
                      },
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.search_rounded,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.filter_list_rounded,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
