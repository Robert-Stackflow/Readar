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

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `Feed Hub`
  String get feedHub {
    return Intl.message(
      'Feed Hub',
      name: 'feedHub',
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

  /// `Change log`
  String get changeLog {
    return Intl.message(
      'Change log',
      name: 'changeLog',
      desc: '',
      args: [],
    );
  }

  /// `Participate in translation`
  String get participateInTranslation {
    return Intl.message(
      'Participate in translation',
      name: 'participateInTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Bug report`
  String get bugReport {
    return Intl.message(
      'Bug report',
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

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Rate us`
  String get rate {
    return Intl.message(
      'Rate us',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact {
    return Intl.message(
      'Contact us',
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

  /// `Telegram group`
  String get telegramGroup {
    return Intl.message(
      'Telegram group',
      name: 'telegramGroup',
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
