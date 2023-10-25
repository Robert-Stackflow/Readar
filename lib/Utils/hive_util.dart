import 'dart:io';

import 'package:cloudreader/Utils/iprint.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveUtil {
  //Database
  static const String database = "CloudReader";

  //HiveBox
  static const String settingsBox = "settings";
  static const String servicesBox = "services";

  //TTS
  static const String ttsEnableKey = "ttsEnable";
  static const String ttsEngineKey = "ttsEngine";
  static const String ttsSpeedKey = "ttsSpeed";
  static const String ttsSpotKey = "ttsSpot";
  static const String ttsAutoNextKey = "ttsAutoNext";
  static const String ttsAutoHaveReadKey = "ttsAutoHaveRead";
  static const String ttsWakeLockKey = "ttsWakeLock";

  //Appearance
  static const String languageKey = "language";
  static const String themeColorKey = "themeColor";
  static const String autoDarkThemeKey = "autoDarkTheme";
  static const String darkThemeKey = "darkTheme";
  static const String starNavigationKey = "starNavigation";
  static const String readLaterNavigationKey = "readLaterNavigation";
  static const String articleLayoutKey = "articleLayout";
  static const String articleMetaKey = "articleMeta";
  static const String articleShowGoToTopKey = "articleShowGoToTop";
  static const String articleRedrawHyperlinkKey = "articleRedrawHyperlink";

  //AI Summary
  static const String aiSummaryEnableKey = "aiSummaryEnable";
  static const String aiSummaryUseOfficialKey = "aiSummaryUseOfficial";

  //Translate
  static const String translateEnableKey = "translateEnable";

  //Experiment
  static const String hardwareAccelerationKey = "hardwareAcceleration";
  static const String previewVideoKey = "previewVideo";

  //Privacy
  static const String lockEnableKey = "lockEnable";
  static const String lockPinKey = "lockPin";
  static const String biometricEnableKey = "biometricEnable";
  static const String autoLockKey = "autoLock";
  static const String autoLockTimeKey = "autoLockTime";
  static const String safeModeKey = "safeMode";

  //System
  static const String firstLoginKey = "firstLogin";
  static const String skipGuideKey = "skipGuide";

  //Mess
  static const String apiUrlKey = "apiUrl";
  static const String apiKeyKey = "apiKey";
  static const String apiCustomUrlKey = "apiCustomUrl";
  static const String apiCodeKey = "apiCode";

  static bool isFirstLogin() {
    if (getBool(key: firstLoginKey, defaultValue: true) == true) return true;
    return false;
  }

  static int getInt(
      {String boxName = HiveUtil.settingsBox,
      required String key,
      bool autoCreate = true,
      int defaultValue = 0}) {
    final Box box = Hive.box(boxName);
    if (!box.containsKey(key)) {
      put(boxName: boxName, key: key, value: defaultValue);
    }
    return box.get(key);
  }

  static bool getBool(
      {String boxName = HiveUtil.settingsBox,
      required String key,
      bool autoCreate = true,
      bool defaultValue = true}) {
    final Box box = Hive.box(boxName);
    if (!box.containsKey(key)) {
      put(boxName: boxName, key: key, value: defaultValue);
    }
    return box.get(key);
  }

  static String? getString(
      {String boxName = HiveUtil.settingsBox,
      required String key,
      bool autoCreate = true,
      String defaultValue = ""}) {
    final Box box = Hive.box(boxName);
    if (!box.containsKey(key)) {
      if (!autoCreate) {
        return null;
      }
      put(boxName: boxName, key: key, value: defaultValue);
    }
    return box.get(key);
  }

  static Future<void> put(
      {String boxName = HiveUtil.settingsBox,
      required String key,
      required dynamic value}) async {
    final Box box = Hive.box(boxName);
    return box.put(key, value);
  }

  static void delete(
      {String boxName = HiveUtil.settingsBox, required String key}) {
    final Box box = Hive.box(boxName);
    box.delete(key);
  }

  static Future<void> openHiveBox(String boxName, {bool limit = false}) async {
    final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
      IPrint.debug('Failed to open $boxName Box');
      final Directory dir = await getApplicationDocumentsDirectory();
      final String dirPath = dir.path;
      File dbFile = File('$dirPath/$boxName.hive');
      File lockFile = File('$dirPath/$boxName.lock');
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        dbFile = File('$dirPath/${HiveUtil.database}/$boxName.hive');
        lockFile = File('$dirPath/${HiveUtil.database}/$boxName.lock');
      }
      await dbFile.delete();
      await lockFile.delete();
      await Hive.openBox(boxName);
      throw 'Failed to open $boxName Box\nError: $error';
    });
    if (limit && box.length > 500) {
      box.clear();
    }
  }
}
