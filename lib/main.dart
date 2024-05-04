import 'dart:io';

import 'package:afar/Providers/global_provider.dart';
import 'package:afar/Screens/Content/article_detail_screen.dart';
import 'package:afar/Screens/Lock/pin_change_screen.dart';
import 'package:afar/Screens/Navigation/explore_screen.dart';
import 'package:afar/Screens/Navigation/read_later_screen.dart';
import 'package:afar/Screens/Navigation/star_screen.dart';
import 'package:afar/Screens/Navigation/tts_screen.dart';
import 'package:afar/Screens/Setting/backup_setting_screen.dart';
import 'package:afar/Screens/Setting/entry_setting_screen.dart';
import 'package:afar/Screens/Setting/experiment_setting_screen.dart';
import 'package:afar/Screens/Setting/extension_setting_screen.dart';
import 'package:afar/Screens/Setting/operation_setting_screen.dart';
import 'package:afar/Screens/Setting/select_theme_screen.dart';
import 'package:afar/Screens/Setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Providers/provider_manager.dart';
import 'Screens/Lock/pin_verify_screen.dart';
import 'Screens/Navigation/article_screen.dart';
import 'Screens/Navigation/feed_screen.dart';
import 'Screens/Navigation/library_screen.dart';
import 'Screens/Setting/about_setting_screen.dart';
import 'Screens/Setting/backup_service_setting_screen.dart';
import 'Screens/Setting/general_setting_screen.dart';
import 'Screens/Setting/global_setting_screen.dart';
import 'Screens/Setting/service_setting_screen.dart';
import 'Screens/main_screen.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProviderManager.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProviderManager.globalProvider),
        ChangeNotifierProvider.value(value: ProviderManager.rssProvider),
      ],
      child: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) => MaterialApp(
          title: 'Afar',
          theme: globalProvider.getBrightness() == null ||
                  globalProvider.getBrightness() == Brightness.light
              ? globalProvider.lightTheme
              : globalProvider.darkTheme,
          darkTheme: globalProvider.getBrightness() == null ||
                  globalProvider.getBrightness() == Brightness.dark
              ? globalProvider.darkTheme
              : globalProvider.lightTheme,
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
              return Localizations.localeOf(context);
            }
          },
          home: const MainScreen(),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: widget!,
            );
          },
          routes: {
            TTSScreen.routeName: (context) => const TTSScreen(),
            ArticleScreen.routeName: (context) => const ArticleScreen(),
            SettingScreen.routeName: (context) => const SettingScreen(),
            StarScreen.routeName: (context) => const StarScreen(),
            LibraryScreen.routeName: (context) => const LibraryScreen(),
            ExploreScreen.routeName: (context) => const ExploreScreen(),
            PinChangeScreen.routeName: (context) => const PinChangeScreen(),
            ReadLaterScreen.routeName: (context) => const ReadLaterScreen(),
            EntrySettingScreen.routeName: (context) =>
                const EntrySettingScreen(),
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
            GlobalSettingScreen.routeName: (context) =>
                const GlobalSettingScreen(),
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
