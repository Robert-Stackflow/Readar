import 'package:flutter/cupertino.dart';

class WaveController extends ChangeNotifier {
  bool isPlaying = false;

  void pause() {
    isPlaying = false;
    notifyListeners();
  }

  void start() {
    isPlaying = true;
    notifyListeners();
  }
}
