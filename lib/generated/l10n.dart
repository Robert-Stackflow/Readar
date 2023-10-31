// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Cloud Reader`
  String get appName {
    return Intl.message(
      'Cloud Reader',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message(
      'Content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `Articles`
  String get article {
    return Intl.message(
      'Articles',
      name: 'article',
      desc: '',
      args: [],
    );
  }

  /// `Feed`
  String get feed {
    return Intl.message(
      'Feed',
      name: 'feed',
      desc: '',
      args: [],
    );
  }

  /// `Star`
  String get star {
    return Intl.message(
      'Star',
      name: 'star',
      desc: '',
      args: [],
    );
  }

  /// `Read Later`
  String get readLater {
    return Intl.message(
      'Read Later',
      name: 'readLater',
      desc: '',
      args: [],
    );
  }

  /// `Highlights`
  String get highlights {
    return Intl.message(
      'Highlights',
      name: 'highlights',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `TTS`
  String get tts {
    return Intl.message(
      'TTS',
      name: 'tts',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get generalSetting {
    return Intl.message(
      'General',
      name: 'generalSetting',
      desc: '',
      args: [],
    );
  }

  /// `Apprearance`
  String get apprearanceSetting {
    return Intl.message(
      'Apprearance',
      name: 'apprearanceSetting',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get serviceSetting {
    return Intl.message(
      'Service',
      name: 'serviceSetting',
      desc: '',
      args: [],
    );
  }

  /// `Extension`
  String get extensionSetting {
    return Intl.message(
      'Extension',
      name: 'extensionSetting',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get backupSetting {
    return Intl.message(
      'Backup',
      name: 'backupSetting',
      desc: '',
      args: [],
    );
  }

  /// `Operation`
  String get operationSetting {
    return Intl.message(
      'Operation',
      name: 'operationSetting',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacySetting {
    return Intl.message(
      'Privacy',
      name: 'privacySetting',
      desc: '',
      args: [],
    );
  }

  /// `Experiment`
  String get experimentSetting {
    return Intl.message(
      'Experiment',
      name: 'experimentSetting',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Contributor`
  String get contributor {
    return Intl.message(
      'Contributor',
      name: 'contributor',
      desc: '',
      args: [],
    );
  }

  /// `Change Log`
  String get changeLog {
    return Intl.message(
      'Change Log',
      name: 'changeLog',
      desc: '',
      args: [],
    );
  }

  /// `Participate In Translation`
  String get participateInTranslation {
    return Intl.message(
      'Participate In Translation',
      name: 'participateInTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Bug Report`
  String get bugReport {
    return Intl.message(
      'Bug Report',
      name: 'bugReport',
      desc: '',
      args: [],
    );
  }

  /// `Github Repo`
  String get githubRepo {
    return Intl.message(
      'Github Repo',
      name: 'githubRepo',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get license {
    return Intl.message(
      'License',
      name: 'license',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Rate Us`
  String get rate {
    return Intl.message(
      'Rate Us',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact {
    return Intl.message(
      'Contact Us',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get officialWebsite {
    return Intl.message(
      'Website',
      name: 'officialWebsite',
      desc: '',
      args: [],
    );
  }

  /// `Telegram Group`
  String get telegramGroup {
    return Intl.message(
      'Telegram Group',
      name: 'telegramGroup',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get chooseLanguage {
    return Intl.message(
      'Choose Language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Choose Theme Mode`
  String get chooseThemeMode {
    return Intl.message(
      'Choose Theme Mode',
      name: 'chooseThemeMode',
      desc: '',
      args: [],
    );
  }

  /// `Follow System`
  String get followSystem {
    return Intl.message(
      'Follow System',
      name: 'followSystem',
      desc: '',
      args: [],
    );
  }

  /// `Theme Setting`
  String get themeSetting {
    return Intl.message(
      'Theme Setting',
      name: 'themeSetting',
      desc: '',
      args: [],
    );
  }

  /// `Select Theme`
  String get selectTheme {
    return Intl.message(
      'Select Theme',
      name: 'selectTheme',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get themeMode {
    return Intl.message(
      'Theme Mode',
      name: 'themeMode',
      desc: '',
      args: [],
    );
  }

  /// `Primary Color`
  String get primaryColor {
    return Intl.message(
      'Primary Color',
      name: 'primaryColor',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message(
      'Light Theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Navigation Bar Setting`
  String get bottomNavigationBarSetting {
    return Intl.message(
      'Navigation Bar Setting',
      name: 'bottomNavigationBarSetting',
      desc: '',
      args: [],
    );
  }

  /// `Show Navigation Bar`
  String get showNavigationBar {
    return Intl.message(
      'Show Navigation Bar',
      name: 'showNavigationBar',
      desc: '',
      args: [],
    );
  }

  /// `Entries displayed in navigation bar`
  String get navigationBarEntries {
    return Intl.message(
      'Entries displayed in navigation bar',
      name: 'navigationBarEntries',
      desc: '',
      args: [],
    );
  }

  /// `Entries displayed in sidebar`
  String get sidebarEntries {
    return Intl.message(
      'Entries displayed in sidebar',
      name: 'sidebarEntries',
      desc: '',
      args: [],
    );
  }

  /// `Navigation Bar Preview`
  String get navigationBarPreview {
    return Intl.message(
      'Navigation Bar Preview',
      name: 'navigationBarPreview',
      desc: '',
      args: [],
    );
  }

  /// `The navigation bar can display at most {maxShown} entries.`
  String navigationBarMaxEntriesTip(Object maxShown) {
    return Intl.message(
      'The navigation bar can display at most $maxShown entries.',
      name: 'navigationBarMaxEntriesTip',
      desc: '',
      args: [maxShown],
    );
  }

  /// `All entries have been moved to the sidebar, and the navigation bar will no longer be displayed.`
  String get allEntriesHidddenTip {
    return Intl.message(
      'All entries have been moved to the sidebar, and the navigation bar will no longer be displayed.',
      name: 'allEntriesHidddenTip',
      desc: '',
      args: [],
    );
  }

  /// `Long press and drag an item here to move it to the end of the list.`
  String get dragTip {
    return Intl.message(
      'Long press and drag an item here to move it to the end of the list.',
      name: 'dragTip',
      desc: '',
      args: [],
    );
  }

  /// `Article Detail Setting`
  String get articleDetailSetting {
    return Intl.message(
      'Article Detail Setting',
      name: 'articleDetailSetting',
      desc: '',
      args: [],
    );
  }

  /// `View Option`
  String get articleDetailViewOption {
    return Intl.message(
      'View Option',
      name: 'articleDetailViewOption',
      desc: '',
      args: [],
    );
  }

  /// `Header Image Display Mode`
  String get articleDetailHeaderImageDisplayMode {
    return Intl.message(
      'Header Image Display Mode',
      name: 'articleDetailHeaderImageDisplayMode',
      desc: '',
      args: [],
    );
  }

  /// `Video Display Mode`
  String get articleDetailVideoDisplayMode {
    return Intl.message(
      'Video Display Mode',
      name: 'articleDetailVideoDisplayMode',
      desc: '',
      args: [],
    );
  }

  /// `Meta Setting`
  String get articleDetailMetaSetting {
    return Intl.message(
      'Meta Setting',
      name: 'articleDetailMetaSetting',
      desc: '',
      args: [],
    );
  }

  /// `Show Related Articles`
  String get articleDetailShowRelated {
    return Intl.message(
      'Show Related Articles',
      name: 'articleDetailShowRelated',
      desc: '',
      args: [],
    );
  }

  /// `TTS Setting`
  String get ttsSetting {
    return Intl.message(
      'TTS Setting',
      name: 'ttsSetting',
      desc: '',
      args: [],
    );
  }

  /// `Enable TTS`
  String get ttsEnable {
    return Intl.message(
      'Enable TTS',
      name: 'ttsEnable',
      desc: '',
      args: [],
    );
  }

  /// `TTS Engine`
  String get ttsEngine {
    return Intl.message(
      'TTS Engine',
      name: 'ttsEngine',
      desc: '',
      args: [],
    );
  }

  /// `Reading Speed`
  String get ttsSpeed {
    return Intl.message(
      'Reading Speed',
      name: 'ttsSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Ignore audio focus`
  String get ttsSpot {
    return Intl.message(
      'Ignore audio focus',
      name: 'ttsSpot',
      desc: '',
      args: [],
    );
  }

  /// `Allow simultaneous audio playback with other applications`
  String get ttsSpotTip {
    return Intl.message(
      'Allow simultaneous audio playback with other applications',
      name: 'ttsSpotTip',
      desc: '',
      args: [],
    );
  }

  /// `Automatically mark as read`
  String get ttsAutoHaveRead {
    return Intl.message(
      'Automatically mark as read',
      name: 'ttsAutoHaveRead',
      desc: '',
      args: [],
    );
  }

  /// `The article will be automatically marked as read after it is read aloud`
  String get ttsAutoHaveReadTip {
    return Intl.message(
      'The article will be automatically marked as read after it is read aloud',
      name: 'ttsAutoHaveReadTip',
      desc: '',
      args: [],
    );
  }

  /// `Wake Lock`
  String get ttsWakeLock {
    return Intl.message(
      'Wake Lock',
      name: 'ttsWakeLock',
      desc: '',
      args: [],
    );
  }

  /// `Enable wake lock when reading (may be killed in the background)`
  String get ttsWakeLockTip {
    return Intl.message(
      'Enable wake lock when reading (may be killed in the background)',
      name: 'ttsWakeLockTip',
      desc: '',
      args: [],
    );
  }

  /// `System TTS settings`
  String get ttsSystemSetting {
    return Intl.message(
      'System TTS settings',
      name: 'ttsSystemSetting',
      desc: '',
      args: [],
    );
  }

  /// `Check for Updates`
  String get checkUpdates {
    return Intl.message(
      'Check for Updates',
      name: 'checkUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Last checked:`
  String get checkUpdatesTip {
    return Intl.message(
      'Last checked:',
      name: 'checkUpdatesTip',
      desc: '',
      args: [],
    );
  }

  /// `Already the latest version`
  String get checkUpdatesAlreadyLatest {
    return Intl.message(
      'Already the latest version',
      name: 'checkUpdatesAlreadyLatest',
      desc: '',
      args: [],
    );
  }

  /// `Clear Cache`
  String get clearCache {
    return Intl.message(
      'Clear Cache',
      name: 'clearCache',
      desc: '',
      args: [],
    );
  }

  /// `Clear cache successfully`
  String get clearCacheSuccess {
    return Intl.message(
      'Clear cache successfully',
      name: 'clearCacheSuccess',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
