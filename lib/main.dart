import 'dart:io';

import 'package:cloudreader/Configs/hive_config.dart';
import 'package:cloudreader/Screens/Lock/pin_change_screen.dart';
import 'package:cloudreader/Screens/Navigation/read_later_screen.dart';
import 'package:cloudreader/Screens/Navigation/star_screen.dart';
import 'package:cloudreader/Screens/Post/tts_screen.dart';
import 'package:cloudreader/Screens/Setting/appearance_setting_scrren.dart';
import 'package:cloudreader/Screens/Setting/backup_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/lab_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/service_setting_screen.dart';
import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Utils/hive_util.dart';
import 'package:cloudreader/Utils/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Bridge/android_back_desktop.dart';
import 'Configs/db_config.dart';
import 'Screens/Lock/pin_verify_screen.dart';
import 'Screens/Navigation/subscription_screen.dart';
import 'Screens/Post/chat_screen.dart';
import 'Screens/Post/login_screen.dart';
import 'Screens/Setting/about_setting_screen.dart';
import 'Screens/Setting/general_setting_screen.dart';
import 'Screens/Setting/privacy_setting_screen.dart';
import 'Screens/main_screen.dart';
import 'Screens/navigation/home_screen.dart';
import 'Screens/navigation/personal_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await initSqlite();
  runApp(const MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Future<void> initHive() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await Hive.initFlutter(HiveConfig.database);
  } else {
    await Hive.initFlutter();
  }
  await HiveUtil.openHiveBox(HiveConfig.settingsBox);
  await HiveUtil.openHiveBox(HiveConfig.servicesBox);
}

Future<void> initSqlite() async {
  openDatabase(
    join(await getDatabasesPath(), DBConfig.dbname),
    onCreate: (db, version) {
      return db.execute(DBConfig.chatTableCreateSql);
    },
    version: 1,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Reader',
      theme: ThemeData(scaffoldBackgroundColor: AppTheme.background),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorProvider.navigatorKey,
      home: WillPopScope(
        onWillPop: () async {
          AndroidBackDesktop.backToDesktop();
          return false;
        },
        child: MainScreen(key: drawerKey),
      ),
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        SubscriptionScreen.routeName: (context) => const SubscriptionScreen(),
        StarScreen.routeName: (context) => const StarScreen(),
        ReadLaterScreen.routeName: (context) => const ReadLaterScreen(),
        PersonalScreen.routeName: (context) => const PersonalScreen(),
        ChatScreen.routeName: (context) => const ChatScreen(),
        TTSScreen.routeName: (context) => const TTSScreen(),
        GeneralSettingScreen.routeName: (context) =>
            const GeneralSettingScreen(),
        LabSettingScreen.routeName: (context) => const LabSettingScreen(),
        AppearanceSettingScreen.routeName: (context) =>
            const AppearanceSettingScreen(),
        BackupSettingScreen.routeName: (context) => const BackupSettingScreen(),
        ServiceSettingScreen.routeName: (context) =>
            const ServiceSettingScreen(),
        PrivacySettingScreen.routeName: (context) =>
            const PrivacySettingScreen(),
        AboutSettingScreen.routeName: (context) => const AboutSettingScreen(),
        PinChangeScreen.routeName: (context) => const PinChangeScreen(),
        PinVerifyScreen.routeName: (context) => PinVerifyScreen(
              onSuccess:
                  ModalRoute.of(context)!.settings.arguments as Function(),
            ),
      },
    );
  }
}
