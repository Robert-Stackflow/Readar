import 'dart:io';

import 'package:cloudreader/Api/service_handler.dart';
import 'package:cloudreader/Providers/global_provider.dart';
import 'package:cloudreader/Resources/theme.dart';
import 'package:cloudreader/Screens/Content/article_detail_screen.dart';
import 'package:cloudreader/Screens/Lock/pin_change_screen.dart';
import 'package:cloudreader/Screens/Navigation/explore_screen.dart';
import 'package:cloudreader/Screens/Navigation/highlights_screen.dart';
import 'package:cloudreader/Screens/Navigation/read_later_screen.dart';
import 'package:cloudreader/Screens/Navigation/star_screen.dart';
import 'package:cloudreader/Screens/Navigation/statistics_screen.dart';
import 'package:cloudreader/Screens/Navigation/tts_screen.dart';
import 'package:cloudreader/Screens/Setting/appearance_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/backup_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/experiment_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/extension_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/nav_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/operation_setting_screen.dart';
import 'package:cloudreader/Screens/Setting/select_theme_screen.dart';
import 'package:cloudreader/Utils/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Channel/android_back_desktop.dart';
import 'Providers/global.dart';
import 'Screens/Lock/pin_verify_screen.dart';
import 'Screens/Navigation/article_screen.dart';
import 'Screens/Navigation/feed_screen.dart';
import 'Screens/Setting/about_setting_screen.dart';
import 'Screens/Setting/backup_service_setting_screen.dart';
import 'Screens/Setting/general_setting_screen.dart';
import 'Screens/Setting/service_setting_screen.dart';
import 'Screens/main_screen.dart';
import 'Utils/store.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  Store.sp = await SharedPreferences.getInstance();
  Store.sp.setInt(StoreKeys.SYNC_SERVICE, SyncService.googleReader.index);
  Store.sp.setString(StoreKeys.ENDPOINT, "https://theoldreader.com");
  Store.sp.setString(StoreKeys.USERNAME, "yutuan.victory@gmail.com");
  Store.sp.setString(StoreKeys.PASSWORD, "6Jv#f9g@cXNPs9z");
  Store.sp.setInt(StoreKeys.FETCH_LIMIT, 500);
  Store.sp.setBool(StoreKeys.USE_INT_64, false);
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Global.globalProvider),
        ChangeNotifierProvider.value(value: Global.feedContentProvider),
        ChangeNotifierProvider.value(value: Global.feedsProvider),
        ChangeNotifierProvider.value(value: Global.groupsProvider),
        ChangeNotifierProvider.value(value: Global.itemsProvider),
        ChangeNotifierProvider.value(value: Global.syncProvider),
      ],
      child: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) => MaterialApp(
          title: 'Cloud Reader',
          theme: AppTheme.getTheme(
            isDarkMode: (Global.globalProvider.getBrightness() != null
                ? Global.globalProvider.getBrightness() == Brightness.dark
                : false),
          ),
          darkTheme: AppTheme.getTheme(
            isDarkMode: (Global.globalProvider.getBrightness() != null
                ? Global.globalProvider.getBrightness() == Brightness.dark
                : true),
          ),
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
              AndroidBackDesktopChannel.backToDesktop();
              return false;
            },
            child: const MainScreen(),
          ),
          // builder: (context, widget) {
          //   return MediaQuery(
          //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          //     child: widget!,
          //   );
          // },
          routes: {
            TTSScreen.routeName: (context) => const TTSScreen(),
            ArticleScreen.routeName: (context) =>
                ArticleScreen(ScrollTopNotifier()),
            StarScreen.routeName: (context) => const StarScreen(),
            StatisticsScreen.routeName: (context) => const StatisticsScreen(),
            HighlightsScreen.routeName: (context) => const HighlightsScreen(),
            ExploreScreen.routeName: (context) => const ExploreScreen(),
            PinChangeScreen.routeName: (context) => const PinChangeScreen(),
            ReadLaterScreen.routeName: (context) => const ReadLaterScreen(),
            NavSettingScreen.routeName: (context) => const NavSettingScreen(),
            SelectThemeScreen.routeName: (context) => const SelectThemeScreen(),
            ArticleDetailScreen.routeName: (context) => ArticleDetailScreen(),
            ExperimentSettingScreen.routeName: (context) =>
                const ExperimentSettingScreen(),
            FeedScreen.routeName: (context) => const FeedScreen(),
            AboutSettingScreen.routeName: (context) =>
                const AboutSettingScreen(),
            OperationSettingScreen.routeName: (context) =>
                const OperationSettingScreen(),
            BackupSettingScreen.routeName: (context) =>
                const BackupSettingScreen(),
            BackupServiceSettingScreen.routeName: (context) =>
                const BackupServiceSettingScreen(),
            ServiceSettingScreen.routeName: (context) =>
                const ServiceSettingScreen(),
            GeneralSettingScreen.routeName: (context) =>
                const GeneralSettingScreen(),
            AppearanceSettingScreen.routeName: (context) =>
                const AppearanceSettingScreen(),
            ExtensionSettingScreen.routeName: (context) =>
                const ExtensionSettingScreen(),
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
