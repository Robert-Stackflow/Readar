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

  /// `Readar`
  String get appName {
    return Intl.message(
      'Readar',
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

  /// `All Articles`
  String get allArticle {
    return Intl.message(
      'All Articles',
      name: 'allArticle',
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

  /// `Library`
  String get library {
    return Intl.message(
      'Library',
      name: 'library',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get saved {
    return Intl.message(
      'Saved',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Hot Links`
  String get hotLinks {
    return Intl.message(
      'Hot Links',
      name: 'hotLinks',
      desc: '',
      args: [],
    );
  }

  /// `Calm Feeds`
  String get calmFeeds {
    return Intl.message(
      'Calm Feeds',
      name: 'calmFeeds',
      desc: '',
      args: [],
    );
  }

  /// `Linked List`
  String get linkedList {
    return Intl.message(
      'Linked List',
      name: 'linkedList',
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

  /// `Basic Setting`
  String get basicSetting {
    return Intl.message(
      'Basic Setting',
      name: 'basicSetting',
      desc: '',
      args: [],
    );
  }

  /// `Advanced Setting`
  String get advancedSetting {
    return Intl.message(
      'Advanced Setting',
      name: 'advancedSetting',
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

  /// `Global`
  String get globalSetting {
    return Intl.message(
      'Global',
      name: 'globalSetting',
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

  /// `侧边栏入口设置`
  String get sideBarEntriesSetting {
    return Intl.message(
      '侧边栏入口设置',
      name: 'sideBarEntriesSetting',
      desc: '',
      args: [],
    );
  }

  /// `显示的入口`
  String get shownEntries {
    return Intl.message(
      '显示的入口',
      name: 'shownEntries',
      desc: '',
      args: [],
    );
  }

  /// `隐藏的入口（将被移动到{library}页面中）`
  String hiddenEntries(Object library) {
    return Intl.message(
      '隐藏的入口（将被移动到$library页面中）',
      name: 'hiddenEntries',
      desc: '',
      args: [library],
    );
  }

  /// `已显示所有入口`
  String get allEntriesShownTip {
    return Intl.message(
      '已显示所有入口',
      name: 'allEntriesShownTip',
      desc: '',
      args: [],
    );
  }

  /// `已隐藏所有入口`
  String get allEntriesHiddenTip {
    return Intl.message(
      '已隐藏所有入口',
      name: 'allEntriesHiddenTip',
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

  /// `Article Crawl option`
  String get crawlType {
    return Intl.message(
      'Article Crawl option',
      name: 'crawlType',
      desc: '',
      args: [],
    );
  }

  /// `Article list layout`
  String get articleListLayoutType {
    return Intl.message(
      'Article list layout',
      name: 'articleListLayoutType',
      desc: '',
      args: [],
    );
  }

  /// `Article detail layout`
  String get articleDetailLayoutType {
    return Intl.message(
      'Article detail layout',
      name: 'articleDetailLayoutType',
      desc: '',
      args: [],
    );
  }

  /// `Header image option`
  String get articleDetailHeaderImageViewType {
    return Intl.message(
      'Header image option',
      name: 'articleDetailHeaderImageViewType',
      desc: '',
      args: [],
    );
  }

  /// `Video option`
  String get articleDetailVideoViewType {
    return Intl.message(
      'Video option',
      name: 'articleDetailVideoViewType',
      desc: '',
      args: [],
    );
  }

  /// `Show related articles`
  String get articleDetailShowRelatedArticles {
    return Intl.message(
      'Show related articles',
      name: 'articleDetailShowRelatedArticles',
      desc: '',
      args: [],
    );
  }

  /// `Show image title`
  String get articleDetailShowImageAlt {
    return Intl.message(
      'Show image title',
      name: 'articleDetailShowImageAlt',
      desc: '',
      args: [],
    );
  }

  /// `Remove duplicate articles`
  String get removeDuplicateArticles {
    return Intl.message(
      'Remove duplicate articles',
      name: 'removeDuplicateArticles',
      desc: '',
      args: [],
    );
  }

  /// `Mobilizer`
  String get mobilizerType {
    return Intl.message(
      'Mobilizer',
      name: 'mobilizerType',
      desc: '',
      args: [],
    );
  }

  /// `Pull articles when starting`
  String get pullWhenStartUp {
    return Intl.message(
      'Pull articles when starting',
      name: 'pullWhenStartUp',
      desc: '',
      args: [],
    );
  }

  /// `Automatically mark as read when scrolling`
  String get autoReadWhenScrolling {
    return Intl.message(
      'Automatically mark as read when scrolling',
      name: 'autoReadWhenScrolling',
      desc: '',
      args: [],
    );
  }

  /// `Cache images when pulling`
  String get cacheImageWhenPull {
    return Intl.message(
      'Cache images when pulling',
      name: 'cacheImageWhenPull',
      desc: '',
      args: [],
    );
  }

  /// `Cache articles when pulling`
  String get cacheWebPageWhenPull {
    return Intl.message(
      'Cache articles when pulling',
      name: 'cacheWebPageWhenPull',
      desc: '',
      args: [],
    );
  }

  /// `Cache articles when reading`
  String get cacheWebPageWhenReading {
    return Intl.message(
      'Cache articles when reading',
      name: 'cacheWebPageWhenReading',
      desc: '',
      args: [],
    );
  }

  /// `Pull Strategy`
  String get pullStrategy {
    return Intl.message(
      'Pull Strategy',
      name: 'pullStrategy',
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
