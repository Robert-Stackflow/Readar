import 'dart:io';

import 'package:cloudreader/Utils/iprint.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../Providers/global_provider.dart';

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
  static const String ttsAutoHaveReadKey = "ttsAutoHaveRead";
  static const String ttsWakeLockKey = "ttsWakeLock";

  //Appearance
  static const String localeKey = "locale";
  static const String themeColorKey = "themeColor";
  static const String activeThemeKey = "activeTheme";
  static const String showNavigationBarKey = "showNavigationBar";
  static const String navDataKey = "navData";
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

  static ActiveTheme getTheme() {
    return ActiveTheme
        .values[HiveUtil.getInt(key: HiveUtil.activeThemeKey, defaultValue: 0)];
  }

  static void setTheme(ActiveTheme theme) {
    HiveUtil.put(key: HiveUtil.activeThemeKey, value: theme.index);
  }

  static Locale? stringToLocale(String? localeString) {
    if (localeString == null || localeString.isEmpty) {
      return null;
    }
    var splitted = localeString.split('_');
    if (splitted.length > 1) {
      return Locale(splitted[0], splitted[1]);
    } else {
      return Locale(localeString);
    }
  }

  static Locale? getLocale() {
    return stringToLocale(HiveUtil.getString(key: HiveUtil.localeKey));
  }

  static void setLocale(Locale? locale) {
    if (locale == null) {
      HiveUtil.delete(key: HiveUtil.localeKey);
    } else {
      HiveUtil.put(key: HiveUtil.localeKey, value: locale.toString());
    }
  }

  static bool showNavigationBar() =>
      HiveUtil.getBool(key: HiveUtil.showNavigationBarKey, defaultValue: true);

  static bool starNavigationVisible() =>
      HiveUtil.getBool(key: HiveUtil.starNavigationKey, defaultValue: true);

  static bool readLaterNavigationVisible() => HiveUtil.getBool(
      key: HiveUtil.readLaterNavigationKey, defaultValue: true);

  static void setShowNavigationBar(bool value) =>
      HiveUtil.put(key: HiveUtil.showNavigationBarKey, value: value);

  static void setStarNavigationVisible(bool value) =>
      HiveUtil.put(key: HiveUtil.starNavigationKey, value: value);

  static void setReadLaterNavigationVisible(bool value) =>
      HiveUtil.put(key: HiveUtil.readLaterNavigationKey, value: value);

  static bool shouldAutoLock() =>
      HiveUtil.getBool(key: HiveUtil.lockEnableKey) &&
      HiveUtil.getString(key: HiveUtil.lockPinKey)!.isNotEmpty &&
      HiveUtil.getBool(key: HiveUtil.autoLockKey);

  //Essential

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

  static bool contains(
      {String boxName = HiveUtil.settingsBox, required String key}) {
    final Box box = Hive.box(boxName);
    return box.containsKey(key);
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
