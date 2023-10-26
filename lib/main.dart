import 'dart:io';

import 'package:cloudreader/Providers/global_provider.dart';
import 'package:cloudreader/Screens/Content/tts_screen.dart';
import 'package:cloudreader/Screens/Lock/pin_change_screen.dart';
import 'package:cloudreader/Screens/Navigation/read_later_screen.dart';
import 'package:cloudreader/Screens/Navigation/star_screen.dart';
import 'package:cloudreader/Screens/Setting/appearance_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/backup_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/experiment_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/extension_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/operation_setting_screen.dart';
import 'package:cloudreader/Utils/hive_util.dart';
import 'package:cloudreader/Utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'Bridge/android_back_desktop.dart';
import 'Configs/db_config.dart';
import 'Providers/global.dart';
import 'Screens/Lock/pin_verify_screen.dart';
import 'Screens/Navigation/subscription_screen.dart';
import 'Screens/Setting/about_setting_screen.dart';
import 'Screens/Setting/general_setting_screen.dart';
import 'Screens/Setting/privacy_setting_screen.dart';
import 'Screens/main_screen.dart';
import 'Screens/navigation/home_screen.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await initSqlite();
  Global.init();
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
    await Hive.initFlutter(HiveUtil.database);
  } else {
    await Hive.initFlutter();
  }
  await HiveUtil.openHiveBox(HiveUtil.settingsBox);
  await HiveUtil.openHiveBox(HiveUtil.servicesBox);
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Global.globalProvider),
      ],
      child: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) => MaterialApp(
          title: 'Cloud Reader',
          theme: ThemeData(scaffoldBackgroundColor: AppTheme.background),
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: globalProvider.locale,
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            if (globalProvider.locale != null) {
              return globalProvider.locale;
            } else if (locale != null && supportedLocales.contains(locale)) {
              return locale;
            } else {
              return const Locale("en");
            }
          },
          home: WillPopScope(
            onWillPop: () async {
              AndroidBackDesktop.backToDesktop();
              return false;
            },
            child: const MainScreen(),
          ),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          routes: {
            TTSScreen.routeName: (context) => const TTSScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            StarScreen.routeName: (context) => const StarScreen(),
            PinChangeScreen.routeName: (context) => const PinChangeScreen(),
            ReadLaterScreen.routeName: (context) => const ReadLaterScreen(),
            ExperimentSettingScreen.routeName: (context) =>
                const ExperimentSettingScreen(),
            FeedScreen.routeName: (context) => const FeedScreen(),
            AboutSettingScreen.routeName: (context) =>
                const AboutSettingScreen(),
            OperationSettingScreen.routeName: (context) =>
                const OperationSettingScreen(),
            BackupSettingScreen.routeName: (context) =>
                const BackupSettingScreen(),
            GeneralSettingScreen.routeName: (context) =>
                const GeneralSettingScreen(),
            AppearanceSettingScreen.routeName: (context) =>
                const AppearanceSettingScreen(),
            ExtensionSettingScreen.routeName: (context) =>
                const ExtensionSettingScreen(),
            PrivacySettingScreen.routeName: (context) =>
                const PrivacySettingScreen(),
            PinVerifyScreen.routeName: (context) => PinVerifyScreen(
                  onSuccess:
                      ModalRoute.of(context)!.settings.arguments as Function(),
                ),
          },
        ),
      ),
    );
  }
}
