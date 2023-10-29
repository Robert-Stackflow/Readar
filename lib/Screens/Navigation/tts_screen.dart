import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloudreader/Utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Widgets/Wave/config.dart';
import '../../Widgets/Wave/wave_controller.dart';
import '../../Widgets/Wave/wave_widget.dart';

class TTSScreen extends StatefulWidget {
  const TTSScreen({super.key});

  static const String routeName = "/tts";

  static const TTSScreen _instance = TTSScreen._internal();

  const TTSScreen._internal();

  static TTSScreen getInstance() {
    return _instance;
  }

  @override
  TTSScreenState createState() => TTSScreenState();
}

class TTSScreenState extends State<TTSScreen> with TickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  bool isShowingControls = true;
  late WaveController controller;
  Duration duration = const Duration();
  bool isTimeOut = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    controller = WaveController();
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  void toggleControls() {
    setState(() {
      isShowingControls = !isShowingControls;
    });
  }

  void toggleAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
      controller.pause();
    } else {
      controller.start();
      await audioPlayer.play(isTimeOut ? AssetSource("") : UrlSource(""));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
    audioPlayer.onPositionChanged.listen((Duration d) {
      setState(() => duration = d);
    });
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        duration = const Duration();
        isPlaying = false;
        controller.pause();
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    controller.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: toggleControls,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedOpacity(
              opacity: isShowingControls ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _isNavigationBarEntry()
                          ? IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: const Icon(Icons.menu_rounded, size: 25),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            )
                          : IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: const Icon(Icons.arrow_back_rounded,
                                  size: 25),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                      const Text(
                        "",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: const Icon(Icons.queue_music_rounded),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 5),
            GestureDetector(
              onTap: toggleAudio,
              child: Container(
                height: 240,
                width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppTheme.spacer.withOpacity(0.1), width: 0.01),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2.0,
                      spreadRadius: -5.0,
                      offset: Offset(0.0, 8.0),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: AnimatedOpacity(
                        opacity: isShowingControls ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            isLoading
                                ? "正在加载资源..."
                                : (isPlaying ? '轻触波纹以暂停' : '轻触波纹以播放'),
                            style: TextStyle(
                              color: AppTheme.white.withOpacity(0.3),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipOval(
                      child: WaveWidget(
                        wavePhase: 20,
                        controller: controller,
                        config: CustomConfig(
                          gradients: [
                            [
                              AppTheme.spacer.withOpacity(0.1),
                              Theme.of(context).primaryColor.withOpacity(0.2)
                            ],
                            [
                              AppTheme.spacer.withOpacity(0.1),
                              Theme.of(context).primaryColor.withOpacity(0.4)
                            ],
                            [
                              AppTheme.gradientColor.withOpacity(0.1),
                              Theme.of(context).primaryColor.withOpacity(0.6)
                            ],
                            [
                              AppTheme.gradientColor.withOpacity(0.1),
                              Theme.of(context).primaryColor.withOpacity(0.8)
                            ],
                            [
                              AppTheme.gradientColor.withOpacity(0.1),
                              Theme.of(context).primaryColor.withOpacity(1.0)
                            ],
                          ],
                          durations: [8000, 10800, 14000, 19440, 35000],
                          heightPercentages: [0.46, 0.48, 0.50, 0.52, 0.54],
                        ),
                        backgroundColor: AppTheme.background,
                        waveAmplitude: 10,
                        size: const Size(double.infinity, double.infinity),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AnimatedOpacity(
                opacity: isShowingControls ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: ProgressBar(
                        progress: duration,
                        total: const Duration(milliseconds: 0),
                        progressBarColor: Theme.of(context).primaryColor,
                        baseBarColor: AppTheme.darkerText.withOpacity(0.24),
                        bufferedBarColor: AppTheme.darkerText.withOpacity(0.24),
                        thumbColor: Theme.of(context).primaryColor,
                        barHeight: 2.0,
                        thumbRadius: 3.0,
                        onSeek: (duration) {
                          audioPlayer.seek(duration);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
