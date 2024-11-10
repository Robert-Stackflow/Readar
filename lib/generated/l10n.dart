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

  /// `全部`
  String get all {
    return Intl.message(
      '全部',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `保存`
  String get save {
    return Intl.message(
      '保存',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `保存成功`
  String get saveSuccess {
    return Intl.message(
      '保存成功',
      name: 'saveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `重置`
  String get reset {
    return Intl.message(
      '重置',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `重置成功`
  String get resetSuccess {
    return Intl.message(
      '重置成功',
      name: 'resetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `确认`
  String get confirm {
    return Intl.message(
      '确认',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `完成`
  String get complete {
    return Intl.message(
      '完成',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get cancel {
    return Intl.message(
      '取消',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `复制`
  String get copy {
    return Intl.message(
      '复制',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `复制成功`
  String get copySuccess {
    return Intl.message(
      '复制成功',
      name: 'copySuccess',
      desc: '',
      args: [],
    );
  }

  /// `剪切`
  String get cut {
    return Intl.message(
      '剪切',
      name: 'cut',
      desc: '',
      args: [],
    );
  }

  /// `粘贴`
  String get paste {
    return Intl.message(
      '粘贴',
      name: 'paste',
      desc: '',
      args: [],
    );
  }

  /// `全选`
  String get selectAll {
    return Intl.message(
      '全选',
      name: 'selectAll',
      desc: '',
      args: [],
    );
  }

  /// `选择`
  String get select {
    return Intl.message(
      '选择',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `删除`
  String get delete {
    return Intl.message(
      '删除',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `删除中...`
  String get deleting {
    return Intl.message(
      '删除中...',
      name: 'deleting',
      desc: '',
      args: [],
    );
  }

  /// `删除成功`
  String get deleteSuccess {
    return Intl.message(
      '删除成功',
      name: 'deleteSuccess',
      desc: '',
      args: [],
    );
  }

  /// `删除失败`
  String get deleteFailed {
    return Intl.message(
      '删除失败',
      name: 'deleteFailed',
      desc: '',
      args: [],
    );
  }

  /// `搜索`
  String get search {
    return Intl.message(
      '搜索',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `分享`
  String get share {
    return Intl.message(
      '分享',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `输入`
  String get input {
    return Intl.message(
      '输入',
      name: 'input',
      desc: '',
      args: [],
    );
  }

  /// `自定义`
  String get custom {
    return Intl.message(
      '自定义',
      name: 'custom',
      desc: '',
      args: [],
    );
  }

  /// `刷新`
  String get refresh {
    return Intl.message(
      '刷新',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `启用`
  String get enable {
    return Intl.message(
      '启用',
      name: 'enable',
      desc: '',
      args: [],
    );
  }

  /// `复制链接`
  String get copyLink {
    return Intl.message(
      '复制链接',
      name: 'copyLink',
      desc: '',
      args: [],
    );
  }

  /// `设置成功`
  String get setSuccess {
    return Intl.message(
      '设置成功',
      name: 'setSuccess',
      desc: '',
      args: [],
    );
  }

  /// `修改`
  String get edit {
    return Intl.message(
      '修改',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `修改成功`
  String get editSuccess {
    return Intl.message(
      '修改成功',
      name: 'editSuccess',
      desc: '',
      args: [],
    );
  }

  /// `修改失败`
  String get editFailed {
    return Intl.message(
      '修改失败',
      name: 'editFailed',
      desc: '',
      args: [],
    );
  }

  /// `跳转失败`
  String get jumpFailed {
    return Intl.message(
      '跳转失败',
      name: 'jumpFailed',
      desc: '',
      args: [],
    );
  }

  /// `在浏览器打开`
  String get openWithBrowser {
    return Intl.message(
      '在浏览器打开',
      name: 'openWithBrowser',
      desc: '',
      args: [],
    );
  }

  /// `分享到其他应用`
  String get shareToOtherApps {
    return Intl.message(
      '分享到其他应用',
      name: 'shareToOtherApps',
      desc: '',
      args: [],
    );
  }

  /// `即将跳转到浏览器下载`
  String get jumpToBrowserDownload {
    return Intl.message(
      '即将跳转到浏览器下载',
      name: 'jumpToBrowserDownload',
      desc: '',
      args: [],
    );
  }

  /// `加载失败`
  String get loadFailed {
    return Intl.message(
      '加载失败',
      name: 'loadFailed',
      desc: '',
      args: [],
    );
  }

  /// `重新加载`
  String get reload {
    return Intl.message(
      '重新加载',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `错误类型：{type}`
  String loadErrorType(Object type) {
    return Intl.message(
      '错误类型：$type',
      name: 'loadErrorType',
      desc: '',
      args: [type],
    );
  }

  /// `未知错误`
  String get loadUnkownError {
    return Intl.message(
      '未知错误',
      name: 'loadUnkownError',
      desc: '',
      args: [],
    );
  }

  /// `首页`
  String get home {
    return Intl.message(
      '首页',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `动态`
  String get dynamic {
    return Intl.message(
      '动态',
      name: 'dynamic',
      desc: '',
      args: [],
    );
  }

  /// `探索`
  String get explore {
    return Intl.message(
      '探索',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `布局`
  String get layoutSetting {
    return Intl.message(
      '布局',
      name: 'layoutSetting',
      desc: '',
      args: [],
    );
  }

  /// `图片`
  String get imageSetting {
    return Intl.message(
      '图片',
      name: 'imageSetting',
      desc: '',
      args: [],
    );
  }

  /// `操作`
  String get operationSetting {
    return Intl.message(
      '操作',
      name: 'operationSetting',
      desc: '',
      args: [],
    );
  }

  /// `隐私`
  String get privacySetting {
    return Intl.message(
      '隐私',
      name: 'privacySetting',
      desc: '',
      args: [],
    );
  }

  /// `备份`
  String get backupSetting {
    return Intl.message(
      '备份',
      name: 'backupSetting',
      desc: '',
      args: [],
    );
  }

  /// `备份服务`
  String get backupServiceSetting {
    return Intl.message(
      '备份服务',
      name: 'backupServiceSetting',
      desc: '',
      args: [],
    );
  }

  /// `RSS服务`
  String get rssServiceSetting {
    return Intl.message(
      'RSS服务',
      name: 'rssServiceSetting',
      desc: '',
      args: [],
    );
  }

  /// `扩展`
  String get extensionSetting {
    return Intl.message(
      '扩展',
      name: 'extensionSetting',
      desc: '',
      args: [],
    );
  }

  /// `实验室`
  String get experimentSetting {
    return Intl.message(
      '实验室',
      name: 'experimentSetting',
      desc: '',
      args: [],
    );
  }

  /// `全局`
  String get globalSetting {
    return Intl.message(
      '全局',
      name: 'globalSetting',
      desc: '',
      args: [],
    );
  }

  /// `AI`
  String get aiSetting {
    return Intl.message(
      'AI',
      name: 'aiSetting',
      desc: '',
      args: [],
    );
  }

  /// `我的`
  String get mine {
    return Intl.message(
      '我的',
      name: 'mine',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get setting {
    return Intl.message(
      '设置',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `基本设置`
  String get basicSetting {
    return Intl.message(
      '基本设置',
      name: 'basicSetting',
      desc: '',
      args: [],
    );
  }

  /// `进阶设置`
  String get advancedSetting {
    return Intl.message(
      '进阶设置',
      name: 'advancedSetting',
      desc: '',
      args: [],
    );
  }

  /// `通用`
  String get generalSetting {
    return Intl.message(
      '通用',
      name: 'generalSetting',
      desc: '',
      args: [],
    );
  }

  /// `语言`
  String get language {
    return Intl.message(
      '语言',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `选择语言`
  String get chooseLanguage {
    return Intl.message(
      '选择语言',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `跟随系统`
  String get followSystem {
    return Intl.message(
      '跟随系统',
      name: 'followSystem',
      desc: '',
      args: [],
    );
  }

  /// `检查更新`
  String get checkUpdates {
    return Intl.message(
      '检查更新',
      name: 'checkUpdates',
      desc: '',
      args: [],
    );
  }

  /// `检查更新中...`
  String get checkingUpdates {
    return Intl.message(
      '检查更新中...',
      name: 'checkingUpdates',
      desc: '',
      args: [],
    );
  }

  /// `检查更新失败`
  String get checkUpdatesFailed {
    return Intl.message(
      '检查更新失败',
      name: 'checkUpdatesFailed',
      desc: '',
      args: [],
    );
  }

  /// `检查更新失败，请重试`
  String get checkUpdatesFailedTip {
    return Intl.message(
      '检查更新失败，请重试',
      name: 'checkUpdatesFailedTip',
      desc: '',
      args: [],
    );
  }

  /// `自动检查更新`
  String get autoCheckUpdates {
    return Intl.message(
      '自动检查更新',
      name: 'autoCheckUpdates',
      desc: '',
      args: [],
    );
  }

  /// `新版本：{version}`
  String newVersion(Object version) {
    return Intl.message(
      '新版本：$version',
      name: 'newVersion',
      desc: '',
      args: [version],
    );
  }

  /// `发现新版本{version}`
  String getNewVersion(Object version) {
    return Intl.message(
      '发现新版本$version',
      name: 'getNewVersion',
      desc: '',
      args: [version],
    );
  }

  /// `是否立即更新？`
  String get doesImmediateUpdate {
    return Intl.message(
      '是否立即更新？',
      name: 'doesImmediateUpdate',
      desc: '',
      args: [],
    );
  }

  /// `更新日志如下：<br/>{log}`
  String changelogAsFollow(Object log) {
    return Intl.message(
      '更新日志如下：<br/>$log',
      name: 'changelogAsFollow',
      desc: '',
      args: [log],
    );
  }

  /// `前往更新`
  String get goToUpdate {
    return Intl.message(
      '前往更新',
      name: 'goToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `前往浏览器更新`
  String get goToBrowserUpdate {
    return Intl.message(
      '前往浏览器更新',
      name: 'goToBrowserUpdate',
      desc: '',
      args: [],
    );
  }

  /// `暂不更新`
  String get updateLater {
    return Intl.message(
      '暂不更新',
      name: 'updateLater',
      desc: '',
      args: [],
    );
  }

  /// `立即安装`
  String get immediatelyInstall {
    return Intl.message(
      '立即安装',
      name: 'immediatelyInstall',
      desc: '',
      args: [],
    );
  }

  /// `您当前正在使用便携版，请手动解压缩安装包并覆盖原有文件`
  String get installPortableTip {
    return Intl.message(
      '您当前正在使用便携版，请手动解压缩安装包并覆盖原有文件',
      name: 'installPortableTip',
      desc: '',
      args: [],
    );
  }

  /// `安装中...`
  String get installing {
    return Intl.message(
      '安装中...',
      name: 'installing',
      desc: '',
      args: [],
    );
  }

  /// `安装已取消`
  String get installCanceled {
    return Intl.message(
      '安装已取消',
      name: 'installCanceled',
      desc: '',
      args: [],
    );
  }

  /// `安装包{filepath}不存在`
  String installFileNotFound(Object filepath) {
    return Intl.message(
      '安装包$filepath不存在',
      name: 'installFileNotFound',
      desc: '',
      args: [filepath],
    );
  }

  /// `已下载{progress}%`
  String alreadyDownloadProgress(Object progress) {
    return Intl.message(
      '已下载$progress%',
      name: 'alreadyDownloadProgress',
      desc: '',
      args: [progress],
    );
  }

  /// `下载成功`
  String get downloadSuccess {
    return Intl.message(
      '下载成功',
      name: 'downloadSuccess',
      desc: '',
      args: [],
    );
  }

  /// `已下载`
  String get alreadyDownload {
    return Intl.message(
      '已下载',
      name: 'alreadyDownload',
      desc: '',
      args: [],
    );
  }

  /// `下载`
  String get download {
    return Intl.message(
      '下载',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `下载中...`
  String get downloading {
    return Intl.message(
      '下载中...',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `下载完成`
  String get downloadComplete {
    return Intl.message(
      '下载完成',
      name: 'downloadComplete',
      desc: '',
      args: [],
    );
  }

  /// `下载失败`
  String get downloadFailed {
    return Intl.message(
      '下载失败',
      name: 'downloadFailed',
      desc: '',
      args: [],
    );
  }

  /// `下载失败，请重试`
  String get downloadFailedAndRetry {
    return Intl.message(
      '下载失败，请重试',
      name: 'downloadFailedAndRetry',
      desc: '',
      args: [],
    );
  }

  /// `新版本安装包下载失败，请重试`
  String get downloadFailedAndRetryTip {
    return Intl.message(
      '新版本安装包下载失败，请重试',
      name: 'downloadFailedAndRetryTip',
      desc: '',
      args: [],
    );
  }

  /// `正在下载新版本安装包...`
  String get downloadingNewVersionPackage {
    return Intl.message(
      '正在下载新版本安装包...',
      name: 'downloadingNewVersionPackage',
      desc: '',
      args: [],
    );
  }

  /// `新版本安装包已经下载完成，点击立即安装`
  String get downloadSuccessClickToInstall {
    return Intl.message(
      '新版本安装包已经下载完成，点击立即安装',
      name: 'downloadSuccessClickToInstall',
      desc: '',
      args: [],
    );
  }

  /// `当前版本`
  String get currentVersion {
    return Intl.message(
      '当前版本',
      name: 'currentVersion',
      desc: '',
      args: [],
    );
  }

  /// `已经是最新版本`
  String get alreadyLatestVersion {
    return Intl.message(
      '已经是最新版本',
      name: 'alreadyLatestVersion',
      desc: '',
      args: [],
    );
  }

  /// `当前版本为{version}，已经是最新版本`
  String alreadyLatestVersionTip(Object version) {
    return Intl.message(
      '当前版本为$version，已经是最新版本',
      name: 'alreadyLatestVersionTip',
      desc: '',
      args: [version],
    );
  }

  /// `立即下载`
  String get immediatelyDownload {
    return Intl.message(
      '立即下载',
      name: 'immediatelyDownload',
      desc: '',
      args: [],
    );
  }

  /// `外观`
  String get appearanceSetting {
    return Intl.message(
      '外观',
      name: 'appearanceSetting',
      desc: '',
      args: [],
    );
  }

  /// `主题设置`
  String get themeSetting {
    return Intl.message(
      '主题设置',
      name: 'themeSetting',
      desc: '',
      args: [],
    );
  }

  /// `主题模式`
  String get themeMode {
    return Intl.message(
      '主题模式',
      name: 'themeMode',
      desc: '',
      args: [],
    );
  }

  /// `选择主题模式`
  String get chooseThemeMode {
    return Intl.message(
      '选择主题模式',
      name: 'chooseThemeMode',
      desc: '',
      args: [],
    );
  }

  /// `浅色模式`
  String get lightTheme {
    return Intl.message(
      '浅色模式',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `深色模式`
  String get darkTheme {
    return Intl.message(
      '深色模式',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `选择主题`
  String get selectTheme {
    return Intl.message(
      '选择主题',
      name: 'selectTheme',
      desc: '',
      args: [],
    );
  }

  /// `新建主题`
  String get newTheme {
    return Intl.message(
      '新建主题',
      name: 'newTheme',
      desc: '',
      args: [],
    );
  }

  /// `极简白`
  String get pureWhite {
    return Intl.message(
      '极简白',
      name: 'pureWhite',
      desc: '',
      args: [],
    );
  }

  /// `极简黑`
  String get pureBlack {
    return Intl.message(
      '极简黑',
      name: 'pureBlack',
      desc: '',
      args: [],
    );
  }

  /// `清新绿`
  String get freshGreen {
    return Intl.message(
      '清新绿',
      name: 'freshGreen',
      desc: '',
      args: [],
    );
  }

  /// `蓝铁`
  String get blueIron {
    return Intl.message(
      '蓝铁',
      name: 'blueIron',
      desc: '',
      args: [],
    );
  }

  /// `主色调`
  String get primaryColor {
    return Intl.message(
      '主色调',
      name: 'primaryColor',
      desc: '',
      args: [],
    );
  }

  /// `字体`
  String get fontFamily {
    return Intl.message(
      '字体',
      name: 'fontFamily',
      desc: '',
      args: [],
    );
  }

  /// `AaBbCc`
  String get fontItemCaptionLatin {
    return Intl.message(
      'AaBbCc',
      name: 'fontItemCaptionLatin',
      desc: '',
      args: [],
    );
  }

  /// `你好世界`
  String get fontItemCaptionNonLatin {
    return Intl.message(
      '你好世界',
      name: 'fontItemCaptionNonLatin',
      desc: '',
      args: [],
    );
  }

  /// `选择字体`
  String get chooseFontFamily {
    return Intl.message(
      '选择字体',
      name: 'chooseFontFamily',
      desc: '',
      args: [],
    );
  }

  /// `内置字体`
  String get defaultFontFamily {
    return Intl.message(
      '内置字体',
      name: 'defaultFontFamily',
      desc: '',
      args: [],
    );
  }

  /// `自定义字体`
  String get customFontFamily {
    return Intl.message(
      '自定义字体',
      name: 'customFontFamily',
      desc: '',
      args: [],
    );
  }

  /// `导入字体`
  String get loadFontFamily {
    return Intl.message(
      '导入字体',
      name: 'loadFontFamily',
      desc: '',
      args: [],
    );
  }

  /// `字体加载成功，重启后切换`
  String get fontFamlyLoadSuccess {
    return Intl.message(
      '字体加载成功，重启后切换',
      name: 'fontFamlyLoadSuccess',
      desc: '',
      args: [],
    );
  }

  /// `字体加载失败`
  String get fontFamlyLoadFailed {
    return Intl.message(
      '字体加载失败',
      name: 'fontFamlyLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `字体文件加载中...`
  String get fontFileLoading {
    return Intl.message(
      '字体文件加载中...',
      name: 'fontFileLoading',
      desc: '',
      args: [],
    );
  }

  /// `字体文件不存在，请尝试重新下载或导入`
  String get fontFileNotExist {
    return Intl.message(
      '字体文件不存在，请尝试重新下载或导入',
      name: 'fontFileNotExist',
      desc: '',
      args: [],
    );
  }

  /// `霞鹜文楷`
  String get lxgw {
    return Intl.message(
      '霞鹜文楷',
      name: 'lxgw',
      desc: '',
      args: [],
    );
  }

  /// `霞鹜文楷-GB`
  String get lxgwGB {
    return Intl.message(
      '霞鹜文楷-GB',
      name: 'lxgwGB',
      desc: '',
      args: [],
    );
  }

  /// `霞鹜文楷-Lite`
  String get lxgwLite {
    return Intl.message(
      '霞鹜文楷-Lite',
      name: 'lxgwLite',
      desc: '',
      args: [],
    );
  }

  /// `霞鹜文楷-Screen`
  String get lxgwScreen {
    return Intl.message(
      '霞鹜文楷-Screen',
      name: 'lxgwScreen',
      desc: '',
      args: [],
    );
  }

  /// `MiSans`
  String get miSans {
    return Intl.message(
      'MiSans',
      name: 'miSans',
      desc: '',
      args: [],
    );
  }

  /// `得意黑`
  String get smileySans {
    return Intl.message(
      '得意黑',
      name: 'smileySans',
      desc: '',
      args: [],
    );
  }

  /// `HarmonyOS Sans`
  String get harmonyOSSans {
    return Intl.message(
      'HarmonyOS Sans',
      name: 'harmonyOSSans',
      desc: '',
      args: [],
    );
  }

  /// `删除字体{fontFamily}`
  String deleteFont(Object fontFamily) {
    return Intl.message(
      '删除字体$fontFamily',
      name: 'deleteFont',
      desc: '',
      args: [fontFamily],
    );
  }

  /// `是否删除字体{fontFamily}？删除后该字体文件无法找回`
  String deleteFontMessage(Object fontFamily) {
    return Intl.message(
      '是否删除字体$fontFamily？删除后该字体文件无法找回',
      name: 'deleteFontMessage',
      desc: '',
      args: [fontFamily],
    );
  }

  /// `启用毛玻璃效果`
  String get enableFrostedGlassEffect {
    return Intl.message(
      '启用毛玻璃效果',
      name: 'enableFrostedGlassEffect',
      desc: '',
      args: [],
    );
  }

  /// `滚动时隐藏标题栏`
  String get hideAppbarWhenScrolling {
    return Intl.message(
      '滚动时隐藏标题栏',
      name: 'hideAppbarWhenScrolling',
      desc: '',
      args: [],
    );
  }

  /// `滚动时隐藏底栏`
  String get hideBottombarWhenScrolling {
    return Intl.message(
      '滚动时隐藏底栏',
      name: 'hideBottombarWhenScrolling',
      desc: '',
      args: [],
    );
  }

  /// `安全`
  String get safeSetting {
    return Intl.message(
      '安全',
      name: 'safeSetting',
      desc: '',
      args: [],
    );
  }

  /// `手势密码`
  String get gestureLock {
    return Intl.message(
      '手势密码',
      name: 'gestureLock',
      desc: '',
      args: [],
    );
  }

  /// `启用手势密码`
  String get enableGestureLock {
    return Intl.message(
      '启用手势密码',
      name: 'enableGestureLock',
      desc: '',
      args: [],
    );
  }

  /// `启用手势密码，保护你的Readar`
  String get enableGestureLockTip {
    return Intl.message(
      '启用手势密码，保护你的Readar',
      name: 'enableGestureLockTip',
      desc: '',
      args: [],
    );
  }

  /// `设置手势密码`
  String get setGestureLock {
    return Intl.message(
      '设置手势密码',
      name: 'setGestureLock',
      desc: '',
      args: [],
    );
  }

  /// `设置手势密码后才能使用锁定功能`
  String get haveToSetGestureLockTip {
    return Intl.message(
      '设置手势密码后才能使用锁定功能',
      name: 'haveToSetGestureLockTip',
      desc: '',
      args: [],
    );
  }

  /// `更改手势密码`
  String get changeGestureLock {
    return Intl.message(
      '更改手势密码',
      name: 'changeGestureLock',
      desc: '',
      args: [],
    );
  }

  /// `尚未设置手势密码`
  String get noGestureLock {
    return Intl.message(
      '尚未设置手势密码',
      name: 'noGestureLock',
      desc: '',
      args: [],
    );
  }

  /// `尚未设置手势密码，是否前往设置`
  String get noGestureLockTip {
    return Intl.message(
      '尚未设置手势密码，是否前往设置',
      name: 'noGestureLockTip',
      desc: '',
      args: [],
    );
  }

  /// `前往设置`
  String get goToSetGestureLock {
    return Intl.message(
      '前往设置',
      name: 'goToSetGestureLock',
      desc: '',
      args: [],
    );
  }

  /// `手势密码启用成功`
  String get enableGestureLockSuccess {
    return Intl.message(
      '手势密码启用成功',
      name: 'enableGestureLockSuccess',
      desc: '',
      args: [],
    );
  }

  /// `手势密码关闭成功`
  String get disableGestureLockSuccess {
    return Intl.message(
      '手势密码关闭成功',
      name: 'disableGestureLockSuccess',
      desc: '',
      args: [],
    );
  }

  /// `连接数不能小于4个，请重新设置`
  String get atLeast4Points {
    return Intl.message(
      '连接数不能小于4个，请重新设置',
      name: 'atLeast4Points',
      desc: '',
      args: [],
    );
  }

  /// `请再次绘制手势密码`
  String get drawGestureLockAgain {
    return Intl.message(
      '请再次绘制手势密码',
      name: 'drawGestureLockAgain',
      desc: '',
      args: [],
    );
  }

  /// `与上一次绘制不一致, 请重新绘制`
  String get gestureLockNotMatch {
    return Intl.message(
      '与上一次绘制不一致, 请重新绘制',
      name: 'gestureLockNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `手势密码设置成功`
  String get setGestureLockSuccess {
    return Intl.message(
      '手势密码设置成功',
      name: 'setGestureLockSuccess',
      desc: '',
      args: [],
    );
  }

  /// `密码错误, 请重新绘制`
  String get gestureLockWrong {
    return Intl.message(
      '密码错误, 请重新绘制',
      name: 'gestureLockWrong',
      desc: '',
      args: [],
    );
  }

  /// `验证手势密码`
  String get verifyGestureLock {
    return Intl.message(
      '验证手势密码',
      name: 'verifyGestureLock',
      desc: '',
      args: [],
    );
  }

  /// `生物识别开启成功`
  String get enableBiometricSuccess {
    return Intl.message(
      '生物识别开启成功',
      name: 'enableBiometricSuccess',
      desc: '',
      args: [],
    );
  }

  /// `生物识别`
  String get biometric {
    return Intl.message(
      '生物识别',
      name: 'biometric',
      desc: '',
      args: [],
    );
  }

  /// `使用生物识别解锁`
  String get biometricUnlock {
    return Intl.message(
      '使用生物识别解锁',
      name: 'biometricUnlock',
      desc: '',
      args: [],
    );
  }

  /// `仅通过生物识别进行身份验证；仅支持Android、IOS、Windows设备；Windows设备上仅支持PIN码验证`
  String get biometricUnlockTip {
    return Intl.message(
      '仅通过生物识别进行身份验证；仅支持Android、IOS、Windows设备；Windows设备上仅支持PIN码验证',
      name: 'biometricUnlockTip',
      desc: '',
      args: [],
    );
  }

  /// `当前设备的生物识别硬件不可用`
  String get biometricErrorHwUnavailable {
    return Intl.message(
      '当前设备的生物识别硬件不可用',
      name: 'biometricErrorHwUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `当前设备未录入生物识别`
  String get biometricErrorNoBiometricEnrolled {
    return Intl.message(
      '当前设备未录入生物识别',
      name: 'biometricErrorNoBiometricEnrolled',
      desc: '',
      args: [],
    );
  }

  /// `当前设备不支持生物识别`
  String get biometricErrorNoHardware {
    return Intl.message(
      '当前设备不支持生物识别',
      name: 'biometricErrorNoHardware',
      desc: '',
      args: [],
    );
  }

  /// `当前设备未设置锁屏密码`
  String get biometricErrorPasscodeNotSet {
    return Intl.message(
      '当前设备未设置锁屏密码',
      name: 'biometricErrorPasscodeNotSet',
      desc: '',
      args: [],
    );
  }

  /// `未知错误`
  String get biometricErrorUnkown {
    return Intl.message(
      '未知错误',
      name: 'biometricErrorUnkown',
      desc: '',
      args: [],
    );
  }

  /// `当前平台不支持生物识别`
  String get biometricErrorUnsupported {
    return Intl.message(
      '当前平台不支持生物识别',
      name: 'biometricErrorUnsupported',
      desc: '',
      args: [],
    );
  }

  /// `验证PIN`
  String get biometricVerifyPin {
    return Intl.message(
      '验证PIN',
      name: 'biometricVerifyPin',
      desc: '',
      args: [],
    );
  }

  /// `验证成功`
  String get biometricVerifySuccess {
    return Intl.message(
      '验证成功',
      name: 'biometricVerifySuccess',
      desc: '',
      args: [],
    );
  }

  /// `进行指纹验证以使用{appName}`
  String biometricReason(Object appName) {
    return Intl.message(
      '进行指纹验证以使用$appName',
      name: 'biometricReason',
      desc: '',
      args: [appName],
    );
  }

  /// `验证PIN以使用{appName}`
  String biometricReasonWindows(Object appName) {
    return Intl.message(
      '验证PIN以使用$appName',
      name: 'biometricReasonWindows',
      desc: '',
      args: [appName],
    );
  }

  /// `取消`
  String get biometricCancelButton {
    return Intl.message(
      '取消',
      name: 'biometricCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `去设置`
  String get biometricGoToSettingsButton {
    return Intl.message(
      '去设置',
      name: 'biometricGoToSettingsButton',
      desc: '',
      args: [],
    );
  }

  /// `指纹识别失败`
  String get biometricNotRecognized {
    return Intl.message(
      '指纹识别失败',
      name: 'biometricNotRecognized',
      desc: '',
      args: [],
    );
  }

  /// `请设置指纹`
  String get biometricGoToSettingsDescription {
    return Intl.message(
      '请设置指纹',
      name: 'biometricGoToSettingsDescription',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get biometricHint {
    return Intl.message(
      '',
      name: 'biometricHint',
      desc: '',
      args: [],
    );
  }

  /// `用户取消操作`
  String get biometricUserCanceled {
    return Intl.message(
      '用户取消操作',
      name: 'biometricUserCanceled',
      desc: '',
      args: [],
    );
  }

  /// `操作超时`
  String get biometricTimeout {
    return Intl.message(
      '操作超时',
      name: 'biometricTimeout',
      desc: '',
      args: [],
    );
  }

  /// `验证失败，可能是尝试次数过多`
  String get biometricUnknown {
    return Intl.message(
      '验证失败，可能是尝试次数过多',
      name: 'biometricUnknown',
      desc: '',
      args: [],
    );
  }

  /// `验证失败`
  String get biometricError {
    return Intl.message(
      '验证失败',
      name: 'biometricError',
      desc: '',
      args: [],
    );
  }

  /// `指纹识别成功`
  String get biometricSuccess {
    return Intl.message(
      '指纹识别成功',
      name: 'biometricSuccess',
      desc: '',
      args: [],
    );
  }

  /// `指纹验证`
  String get biometricSignInTitle {
    return Intl.message(
      '指纹验证',
      name: 'biometricSignInTitle',
      desc: '',
      args: [],
    );
  }

  /// `请先录入指纹!`
  String get biometricDeviceCredentialsRequiredTitle {
    return Intl.message(
      '请先录入指纹!',
      name: 'biometricDeviceCredentialsRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `您的设备不支持生物识别`
  String get biometricNotAvailable {
    return Intl.message(
      '您的设备不支持生物识别',
      name: 'biometricNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `您的设备未录入生物识别`
  String get biometricNotEnrolled {
    return Intl.message(
      '您的设备未录入生物识别',
      name: 'biometricNotEnrolled',
      desc: '',
      args: [],
    );
  }

  /// `生物识别功能已被锁定，请稍后再试`
  String get biometricLockout {
    return Intl.message(
      '生物识别功能已被锁定，请稍后再试',
      name: 'biometricLockout',
      desc: '',
      args: [],
    );
  }

  /// `生物识别功能已被永久锁定，请使用其他方式解锁`
  String get biometricLockoutPermanent {
    return Intl.message(
      '生物识别功能已被永久锁定，请使用其他方式解锁',
      name: 'biometricLockoutPermanent',
      desc: '',
      args: [],
    );
  }

  /// `未知原因：{reason}`
  String biometricOtherReason(Object reason) {
    return Intl.message(
      '未知原因：$reason',
      name: 'biometricOtherReason',
      desc: '',
      args: [reason],
    );
  }

  /// `请绘制旧手势密码`
  String get drawOldGestureLock {
    return Intl.message(
      '请绘制旧手势密码',
      name: 'drawOldGestureLock',
      desc: '',
      args: [],
    );
  }

  /// `绘制新手势密码`
  String get drawNewGestureLock {
    return Intl.message(
      '绘制新手势密码',
      name: 'drawNewGestureLock',
      desc: '',
      args: [],
    );
  }

  /// `处于后台自动锁定`
  String get autoLock {
    return Intl.message(
      '处于后台自动锁定',
      name: 'autoLock',
      desc: '',
      args: [],
    );
  }

  /// `在Windows、Linux、MacOS设备中，窗口最小化或最小化至托盘时即表示处于后台`
  String get autoLockTip {
    return Intl.message(
      '在Windows、Linux、MacOS设备中，窗口最小化或最小化至托盘时即表示处于后台',
      name: 'autoLockTip',
      desc: '',
      args: [],
    );
  }

  /// `自动锁定时机`
  String get autoLockDelay {
    return Intl.message(
      '自动锁定时机',
      name: 'autoLockDelay',
      desc: '',
      args: [],
    );
  }

  /// `选择自动锁定时机`
  String get chooseAutoLockDelay {
    return Intl.message(
      '选择自动锁定时机',
      name: 'chooseAutoLockDelay',
      desc: '',
      args: [],
    );
  }

  /// `立即锁定`
  String get immediatelyLock {
    return Intl.message(
      '立即锁定',
      name: 'immediatelyLock',
      desc: '',
      args: [],
    );
  }

  /// `处于后台30秒后锁定`
  String get after30SecondsLock {
    return Intl.message(
      '处于后台30秒后锁定',
      name: 'after30SecondsLock',
      desc: '',
      args: [],
    );
  }

  /// `处于后台1分钟后锁定`
  String get after1MinuteLock {
    return Intl.message(
      '处于后台1分钟后锁定',
      name: 'after1MinuteLock',
      desc: '',
      args: [],
    );
  }

  /// `处于后台3分钟后锁定`
  String get after3MinutesLock {
    return Intl.message(
      '处于后台3分钟后锁定',
      name: 'after3MinutesLock',
      desc: '',
      args: [],
    );
  }

  /// `处于后台5分钟后锁定`
  String get after5MinutesLock {
    return Intl.message(
      '处于后台5分钟后锁定',
      name: 'after5MinutesLock',
      desc: '',
      args: [],
    );
  }

  /// `处于后台10分钟后锁定`
  String get after10MinutesLock {
    return Intl.message(
      '处于后台10分钟后锁定',
      name: 'after10MinutesLock',
      desc: '',
      args: [],
    );
  }

  /// `安全模式`
  String get safeMode {
    return Intl.message(
      '安全模式',
      name: 'safeMode',
      desc: '',
      args: [],
    );
  }

  /// `仅支持Android、IOS设备；当软件进入最近任务列表页面，隐藏页面内容；同时禁用应用内截图`
  String get safeModeTip {
    return Intl.message(
      '仅支持Android、IOS设备；当软件进入最近任务列表页面，隐藏页面内容；同时禁用应用内截图',
      name: 'safeModeTip',
      desc: '',
      args: [],
    );
  }

  /// `清空缓存`
  String get clearCache {
    return Intl.message(
      '清空缓存',
      name: 'clearCache',
      desc: '',
      args: [],
    );
  }

  /// `平台适配设置`
  String get platformSetting {
    return Intl.message(
      '平台适配设置',
      name: 'platformSetting',
      desc: '',
      args: [],
    );
  }

  /// `桌面端设置`
  String get desktopSetting {
    return Intl.message(
      '桌面端设置',
      name: 'desktopSetting',
      desc: '',
      args: [],
    );
  }

  /// `关闭主界面时`
  String get closeWindowOption {
    return Intl.message(
      '关闭主界面时',
      name: 'closeWindowOption',
      desc: '',
      args: [],
    );
  }

  /// `选择关闭主界面时`
  String get chooseCloseWindowOption {
    return Intl.message(
      '选择关闭主界面时',
      name: 'chooseCloseWindowOption',
      desc: '',
      args: [],
    );
  }

  /// `最小化至系统托盘`
  String get minimizeToTray {
    return Intl.message(
      '最小化至系统托盘',
      name: 'minimizeToTray',
      desc: '',
      args: [],
    );
  }

  /// `显示系统托盘`
  String get showTray {
    return Intl.message(
      '显示系统托盘',
      name: 'showTray',
      desc: '',
      args: [],
    );
  }

  /// `退出Readar`
  String get exitApp {
    return Intl.message(
      '退出Readar',
      name: 'exitApp',
      desc: '',
      args: [],
    );
  }

  /// `显示主窗口`
  String get displayAppTray {
    return Intl.message(
      '显示主窗口',
      name: 'displayAppTray',
      desc: '',
      args: [],
    );
  }

  /// `锁定`
  String get lockAppTray {
    return Intl.message(
      '锁定',
      name: 'lockAppTray',
      desc: '',
      args: [],
    );
  }

  /// `官网`
  String get officialWebsiteTray {
    return Intl.message(
      '官网',
      name: 'officialWebsiteTray',
      desc: '',
      args: [],
    );
  }

  /// `GitHub`
  String get repoTray {
    return Intl.message(
      'GitHub',
      name: 'repoTray',
      desc: '',
      args: [],
    );
  }

  /// `退出`
  String get exitAppTray {
    return Intl.message(
      '退出',
      name: 'exitAppTray',
      desc: '',
      args: [],
    );
  }

  /// `开机自启动`
  String get launchAtStartup {
    return Intl.message(
      '开机自启动',
      name: 'launchAtStartup',
      desc: '',
      args: [],
    );
  }

  /// `记忆窗口位置和大小`
  String get autoMemoryWindowPositionAndSize {
    return Intl.message(
      '记忆窗口位置和大小',
      name: 'autoMemoryWindowPositionAndSize',
      desc: '',
      args: [],
    );
  }

  /// `关闭后，每次打开Readar都会居中显示且具有默认窗口大小`
  String get autoMemoryWindowPositionAndSizeTip {
    return Intl.message(
      '关闭后，每次打开Readar都会居中显示且具有默认窗口大小',
      name: 'autoMemoryWindowPositionAndSizeTip',
      desc: '',
      args: [],
    );
  }

  /// `移动端设置`
  String get mobileSetting {
    return Intl.message(
      '移动端设置',
      name: 'mobileSetting',
      desc: '',
      args: [],
    );
  }

  /// `横屏时启用桌面端布局`
  String get useDesktopLayoutWhenLandscape {
    return Intl.message(
      '横屏时启用桌面端布局',
      name: 'useDesktopLayoutWhenLandscape',
      desc: '',
      args: [],
    );
  }

  /// `更改后需要重启`
  String get haveToRestartWhenChange {
    return Intl.message(
      '更改后需要重启',
      name: 'haveToRestartWhenChange',
      desc: '',
      args: [],
    );
  }

  /// `内置浏览器`
  String get inAppBrowser {
    return Intl.message(
      '内置浏览器',
      name: 'inAppBrowser',
      desc: '',
      args: [],
    );
  }

  /// `清空缓存中...`
  String get clearingCache {
    return Intl.message(
      '清空缓存中...',
      name: 'clearingCache',
      desc: '',
      args: [],
    );
  }

  /// `清空缓存成功`
  String get clearCacheSuccess {
    return Intl.message(
      '清空缓存成功',
      name: 'clearCacheSuccess',
      desc: '',
      args: [],
    );
  }

  /// `清空日志中...`
  String get clearingLog {
    return Intl.message(
      '清空日志中...',
      name: 'clearingLog',
      desc: '',
      args: [],
    );
  }

  /// `清空日志成功`
  String get clearLogSuccess {
    return Intl.message(
      '清空日志成功',
      name: 'clearLogSuccess',
      desc: '',
      args: [],
    );
  }

  /// `清空日志失败`
  String get clearLogFailed {
    return Intl.message(
      '清空日志失败',
      name: 'clearLogFailed',
      desc: '',
      args: [],
    );
  }

  /// `导出日志`
  String get exportLog {
    return Intl.message(
      '导出日志',
      name: 'exportLog',
      desc: '',
      args: [],
    );
  }

  /// `暂无日志可导出`
  String get noLog {
    return Intl.message(
      '暂无日志可导出',
      name: 'noLog',
      desc: '',
      args: [],
    );
  }

  /// `当您在使用软件的过程中遇到问题时，导出日志提供给开发者以方便溯源`
  String get exportLogHint {
    return Intl.message(
      '当您在使用软件的过程中遇到问题时，导出日志提供给开发者以方便溯源',
      name: 'exportLogHint',
      desc: '',
      args: [],
    );
  }

  /// `导出路径不能在日志目录中`
  String get exportPathCannotInLogDir {
    return Intl.message(
      '导出路径不能在日志目录中',
      name: 'exportPathCannotInLogDir',
      desc: '',
      args: [],
    );
  }

  /// `清空日志`
  String get clearLog {
    return Intl.message(
      '清空日志',
      name: 'clearLog',
      desc: '',
      args: [],
    );
  }

  /// `导出中...`
  String get exporting {
    return Intl.message(
      '导出中...',
      name: 'exporting',
      desc: '',
      args: [],
    );
  }

  /// `导出成功`
  String get exportSuccess {
    return Intl.message(
      '导出成功',
      name: 'exportSuccess',
      desc: '',
      args: [],
    );
  }

  /// `导出失败`
  String get exportFailed {
    return Intl.message(
      '导出失败',
      name: 'exportFailed',
      desc: '',
      args: [],
    );
  }

  /// `确认清空日志`
  String get clearLogTitle {
    return Intl.message(
      '确认清空日志',
      name: 'clearLogTitle',
      desc: '',
      args: [],
    );
  }

  /// `是否清空日志？当您在使用软件的过程中遇到问题时，我们建议您导出日志后再清空日志`
  String get clearLogHint {
    return Intl.message(
      '是否清空日志？当您在使用软件的过程中遇到问题时，我们建议您导出日志后再清空日志',
      name: 'clearLogHint',
      desc: '',
      args: [],
    );
  }

  /// `关于`
  String get about {
    return Intl.message(
      '关于',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `更新日志`
  String get changelog {
    return Intl.message(
      '更新日志',
      name: 'changelog',
      desc: '',
      args: [],
    );
  }

  /// `获取更新日志失败`
  String get failedToGetChangelog {
    return Intl.message(
      '获取更新日志失败',
      name: 'failedToGetChangelog',
      desc: '',
      args: [],
    );
  }

  /// `报告BUG`
  String get bugReport {
    return Intl.message(
      '报告BUG',
      name: 'bugReport',
      desc: '',
      args: [],
    );
  }

  /// `GitHub仓库`
  String get githubRepo {
    return Intl.message(
      'GitHub仓库',
      name: 'githubRepo',
      desc: '',
      args: [],
    );
  }

  /// `隐私政策`
  String get privacyPolicy {
    return Intl.message(
      '隐私政策',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `服务条款`
  String get serviceTerm {
    return Intl.message(
      '服务条款',
      name: 'serviceTerm',
      desc: '',
      args: [],
    );
  }

  /// `评个分吧`
  String get rate {
    return Intl.message(
      '评个分吧',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `为Readar评个分吧`
  String get rateTitle {
    return Intl.message(
      '为Readar评个分吧',
      name: 'rateTitle',
      desc: '',
      args: [],
    );
  }

  /// `请评分`
  String get pleaseRate {
    return Intl.message(
      '请评分',
      name: 'pleaseRate',
      desc: '',
      args: [],
    );
  }

  /// `感谢您的评分`
  String get rateSuccess {
    return Intl.message(
      '感谢您的评分',
      name: 'rateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `请点击评分`
  String get pleaseClickToRate {
    return Intl.message(
      '请点击评分',
      name: 'pleaseClickToRate',
      desc: '',
      args: [],
    );
  }

  /// `暂不评分`
  String get rateLater {
    return Intl.message(
      '暂不评分',
      name: 'rateLater',
      desc: '',
      args: [],
    );
  }

  /// `提交评分`
  String get submitRate {
    return Intl.message(
      '提交评分',
      name: 'submitRate',
      desc: '',
      args: [],
    );
  }

  /// `革命仍需努力`
  String get rate1Star {
    return Intl.message(
      '革命仍需努力',
      name: 'rate1Star',
      desc: '',
      args: [],
    );
  }

  /// `期待您的反馈和建议`
  String get rate2Star {
    return Intl.message(
      '期待您的反馈和建议',
      name: 'rate2Star',
      desc: '',
      args: [],
    );
  }

  /// `我会继续进步的！`
  String get rate3Star {
    return Intl.message(
      '我会继续进步的！',
      name: 'rate3Star',
      desc: '',
      args: [],
    );
  }

  /// `收下你的认可啦`
  String get rate4Star {
    return Intl.message(
      '收下你的认可啦',
      name: 'rate4Star',
      desc: '',
      args: [],
    );
  }

  /// `啾咪~~`
  String get rate5Star {
    return Intl.message(
      '啾咪~~',
      name: 'rate5Star',
      desc: '',
      args: [],
    );
  }

  /// `分享APP`
  String get shareApp {
    return Intl.message(
      '分享APP',
      name: 'shareApp',
      desc: '',
      args: [],
    );
  }

  /// `Readar - 简洁的双因素身份验证器\n{officialWebsite}`
  String shareAppText(Object officialWebsite) {
    return Intl.message(
      'Readar - 简洁的双因素身份验证器\\n$officialWebsite',
      name: 'shareAppText',
      desc: '',
      args: [officialWebsite],
    );
  }

  /// `Readar反馈`
  String get feedbackSubject {
    return Intl.message(
      'Readar反馈',
      name: 'feedbackSubject',
      desc: '',
      args: [],
    );
  }

  /// `联系我们`
  String get contact {
    return Intl.message(
      '联系我们',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `官方网站`
  String get officialWebsite {
    return Intl.message(
      '官方网站',
      name: 'officialWebsite',
      desc: '',
      args: [],
    );
  }

  /// `QQ群聊`
  String get qqGroup {
    return Intl.message(
      'QQ群聊',
      name: 'qqGroup',
      desc: '',
      args: [],
    );
  }

  /// `Telegram频道`
  String get telegramGroup {
    return Intl.message(
      'Telegram频道',
      name: 'telegramGroup',
      desc: '',
      args: [],
    );
  }

  /// `&emsp;&emsp;恭喜你发现了我藏在Readar中的<strong>小彩蛋</strong>！`
  String get eggEssay {
    return Intl.message(
      '&emsp;&emsp;恭喜你发现了我藏在Readar中的<strong>小彩蛋</strong>！',
      name: 'eggEssay',
      desc: '',
      args: [],
    );
  }

  /// `尚未安装邮箱程序，已复制Email地址到剪贴板`
  String get noEmailClient {
    return Intl.message(
      '尚未安装邮箱程序，已复制Email地址到剪贴板',
      name: 'noEmailClient',
      desc: '',
      args: [],
    );
  }

  /// `分享成功`
  String get shareSuccess {
    return Intl.message(
      '分享成功',
      name: 'shareSuccess',
      desc: '',
      args: [],
    );
  }

  /// `分享失败`
  String get shareFailed {
    return Intl.message(
      '分享失败',
      name: 'shareFailed',
      desc: '',
      args: [],
    );
  }

  /// `取消分享`
  String get cancelShare {
    return Intl.message(
      '取消分享',
      name: 'cancelShare',
      desc: '',
      args: [],
    );
  }

  /// `加载中...`
  String get loading {
    return Intl.message(
      '加载中...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `不支持的URI：{uri}`
  String notSupportedUri(Object uri) {
    return Intl.message(
      '不支持的URI：$uri',
      name: 'notSupportedUri',
      desc: '',
      args: [uri],
    );
  }

  /// `请授予文件存储权限`
  String get pleaseGrantFilePermission {
    return Intl.message(
      '请授予文件存储权限',
      name: 'pleaseGrantFilePermission',
      desc: '',
      args: [],
    );
  }

  /// `已拒绝文件存储权限，将跳转到浏览器下载`
  String get hasRejectedFilePermission {
    return Intl.message(
      '已拒绝文件存储权限，将跳转到浏览器下载',
      name: 'hasRejectedFilePermission',
      desc: '',
      args: [],
    );
  }

  /// `快捷键`
  String get shortcut {
    return Intl.message(
      '快捷键',
      name: 'shortcut',
      desc: '',
      args: [],
    );
  }

  /// `快捷键帮助`
  String get shortcutHelp {
    return Intl.message(
      '快捷键帮助',
      name: 'shortcutHelp',
      desc: '',
      args: [],
    );
  }

  /// `返回`
  String get back {
    return Intl.message(
      '返回',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `返回首页`
  String get backToHome {
    return Intl.message(
      '返回首页',
      name: 'backToHome',
      desc: '',
      args: [],
    );
  }

  /// `退出`
  String get escape {
    return Intl.message(
      '退出',
      name: 'escape',
      desc: '',
      args: [],
    );
  }

  /// `锁定软件`
  String get lock {
    return Intl.message(
      '锁定软件',
      name: 'lock',
      desc: '',
      args: [],
    );
  }

  /// `{day}天前`
  String dayAgo(Object day) {
    return Intl.message(
      '$day天前',
      name: 'dayAgo',
      desc: '',
      args: [day],
    );
  }

  /// `{hour}小时前`
  String hourAgo(Object hour) {
    return Intl.message(
      '$hour小时前',
      name: 'hourAgo',
      desc: '',
      args: [hour],
    );
  }

  /// `{minute}分钟前`
  String minuteAgo(Object minute) {
    return Intl.message(
      '$minute分钟前',
      name: 'minuteAgo',
      desc: '',
      args: [minute],
    );
  }

  /// `{second}秒前`
  String secondAgo(Object second) {
    return Intl.message(
      '$second秒前',
      name: 'secondAgo',
      desc: '',
      args: [second],
    );
  }

  /// `刚刚`
  String get rightnow {
    return Intl.message(
      '刚刚',
      name: 'rightnow',
      desc: '',
      args: [],
    );
  }

  /// `切换深浅色模式`
  String get changeDayNightMode {
    return Intl.message(
      '切换深浅色模式',
      name: 'changeDayNightMode',
      desc: '',
      args: [],
    );
  }

  /// `二维码构建失败`
  String get errorQrCode {
    return Intl.message(
      '二维码构建失败',
      name: 'errorQrCode',
      desc: '',
      args: [],
    );
  }

  /// `&emsp;&emsp;恭喜你发现了我藏在Readar中的<strong>小彩蛋</strong>！<br/>&emsp;&emsp;相信发现这个彩蛋的你已经很熟悉Readar了，那么我先做个自我介绍吧。我呢，是一个喜欢用开发来方便自己的人，并经常乐此不疲地投入时间和精力去打磨自己的作品。由于实在无法忍受Lofter中烦人的广告，我在机缘巧合下重新拾起了Flutter开发Readar，并适配了平板设备和Windows系统。<br/>&emsp;&emsp;在Readar之前，我用原生安卓开发过一个完整的小项目CloudOTP，这款简洁的双因素身份验证器受到我室友的青睐，甚至他的同事还询问有没有IOS版本的，这是我第一次体会到自己的作品被他人认可的那种奇妙的感觉。在闲暇的时候，我已经用Flutter全面重构了CloudOTP，并支持了更多新特性。在未来我也会将自己的作品呈现给更多喜欢它的人们。<br/>&emsp;&emsp;我总喜欢在我的作品中埋藏彩蛋，然而却都不够精彩和独一无二。这个彩蛋的灵感呢，来源于Android 14系统，是我设计过的彩蛋中唯一差强人意的一个，以此献给使用Readar的你，希望你喜欢这个彩蛋，也希望你能喜欢Readar💕💕。`
  String get eggMessage {
    return Intl.message(
      '&emsp;&emsp;恭喜你发现了我藏在Readar中的<strong>小彩蛋</strong>！<br/>&emsp;&emsp;相信发现这个彩蛋的你已经很熟悉Readar了，那么我先做个自我介绍吧。我呢，是一个喜欢用开发来方便自己的人，并经常乐此不疲地投入时间和精力去打磨自己的作品。由于实在无法忍受Lofter中烦人的广告，我在机缘巧合下重新拾起了Flutter开发Readar，并适配了平板设备和Windows系统。<br/>&emsp;&emsp;在Readar之前，我用原生安卓开发过一个完整的小项目CloudOTP，这款简洁的双因素身份验证器受到我室友的青睐，甚至他的同事还询问有没有IOS版本的，这是我第一次体会到自己的作品被他人认可的那种奇妙的感觉。在闲暇的时候，我已经用Flutter全面重构了CloudOTP，并支持了更多新特性。在未来我也会将自己的作品呈现给更多喜欢它的人们。<br/>&emsp;&emsp;我总喜欢在我的作品中埋藏彩蛋，然而却都不够精彩和独一无二。这个彩蛋的灵感呢，来源于Android 14系统，是我设计过的彩蛋中唯一差强人意的一个，以此献给使用Readar的你，希望你喜欢这个彩蛋，也希望你能喜欢Readar💕💕。',
      name: 'eggMessage',
      desc: '',
      args: [],
    );
  }

  /// `覆盖云控`
  String get overrideCloudControl {
    return Intl.message(
      '覆盖云控',
      name: 'overrideCloudControl',
      desc: '',
      args: [],
    );
  }

  /// `覆盖云控值，使Readar的功能更加丰富`
  String get overrideCloudControlDescription {
    return Intl.message(
      '覆盖云控值，使Readar的功能更加丰富',
      name: 'overrideCloudControlDescription',
      desc: '',
      args: [],
    );
  }

  /// `刷新率`
  String get refreshRate {
    return Intl.message(
      '刷新率',
      name: 'refreshRate',
      desc: '',
      args: [],
    );
  }

  /// `选择刷新率`
  String get chooseRefreshRate {
    return Intl.message(
      '选择刷新率',
      name: 'chooseRefreshRate',
      desc: '',
      args: [],
    );
  }

  /// `意在解决部分机型高刷失效的问题，如无问题，请不要修改\n如果您的设备支持LTPO，可能会设置失败\n已选模式: {selected}\n首选模式: {preferred}\n活动模式: {active}`
  String refreshRateDescription(
      Object selected, Object preferred, Object active) {
    return Intl.message(
      '意在解决部分机型高刷失效的问题，如无问题，请不要修改\n如果您的设备支持LTPO，可能会设置失败\n已选模式: $selected\n首选模式: $preferred\n活动模式: $active',
      name: 'refreshRateDescription',
      desc: '',
      args: [selected, preferred, active],
    );
  }

  /// `刷新率设置成功`
  String get setRefreshRateSuccess {
    return Intl.message(
      '刷新率设置成功',
      name: 'setRefreshRateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `刷新率设置失败`
  String get setRefreshRateFailed {
    return Intl.message(
      '刷新率设置失败',
      name: 'setRefreshRateFailed',
      desc: '',
      args: [],
    );
  }

  /// `刷新率设置失败: {error}`
  String setRefreshRateFailedWithError(Object error) {
    return Intl.message(
      '刷新率设置失败: $error',
      name: 'setRefreshRateFailedWithError',
      desc: '',
      args: [error],
    );
  }

  /// `刷新率设置成功，但当前显示模式未改变`
  String get setRefreshRateSuccessWithDisplayModeNotChanged {
    return Intl.message(
      '刷新率设置成功，但当前显示模式未改变',
      name: 'setRefreshRateSuccessWithDisplayModeNotChanged',
      desc: '',
      args: [],
    );
  }

  /// `字段`
  String get field {
    return Intl.message(
      '字段',
      name: 'field',
      desc: '',
      args: [],
    );
  }

  /// `描述`
  String get description {
    return Intl.message(
      '描述',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `示例`
  String get example {
    return Intl.message(
      '示例',
      name: 'example',
      desc: '',
      args: [],
    );
  }

  /// `根据{license}许可证开源`
  String licenseDetail(Object license) {
    return Intl.message(
      '根据$license许可证开源',
      name: 'licenseDetail',
      desc: '',
      args: [license],
    );
  }

  /// `进入`
  String get enter {
    return Intl.message(
      '进入',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `应用内搜索`
  String get searchInApp {
    return Intl.message(
      '应用内搜索',
      name: 'searchInApp',
      desc: '',
      args: [],
    );
  }

  /// `重试`
  String get retry {
    return Intl.message(
      '重试',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `万`
  String get tenThousand {
    return Intl.message(
      '万',
      name: 'tenThousand',
      desc: '',
      args: [],
    );
  }

  /// `欢迎反馈`
  String get feedbackWelcome {
    return Intl.message(
      '欢迎反馈',
      name: 'feedbackWelcome',
      desc: '',
      args: [],
    );
  }

  /// `加入QQ群，反馈BUG、建议和想法，欢迎你的加入！`
  String get feedbackWelcomeMessage {
    return Intl.message(
      '加入QQ群，反馈BUG、建议和想法，欢迎你的加入！',
      name: 'feedbackWelcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `跳转至QQ`
  String get goToQQ {
    return Intl.message(
      '跳转至QQ',
      name: 'goToQQ',
      desc: '',
      args: [],
    );
  }

  /// `暂不加入`
  String get joinLater {
    return Intl.message(
      '暂不加入',
      name: 'joinLater',
      desc: '',
      args: [],
    );
  }

  /// `文章抓取方式`
  String get crawlType {
    return Intl.message(
      '文章抓取方式',
      name: 'crawlType',
      desc: '',
      args: [],
    );
  }

  /// `文章列表布局`
  String get articleListLayoutType {
    return Intl.message(
      '文章列表布局',
      name: 'articleListLayoutType',
      desc: '',
      args: [],
    );
  }

  /// `文章详情布局`
  String get articleDetailLayoutType {
    return Intl.message(
      '文章详情布局',
      name: 'articleDetailLayoutType',
      desc: '',
      args: [],
    );
  }

  /// `头图显示方式`
  String get articleDetailHeaderImageViewType {
    return Intl.message(
      '头图显示方式',
      name: 'articleDetailHeaderImageViewType',
      desc: '',
      args: [],
    );
  }

  /// `视频显示方式`
  String get articleDetailVideoViewType {
    return Intl.message(
      '视频显示方式',
      name: 'articleDetailVideoViewType',
      desc: '',
      args: [],
    );
  }

  /// `显示相关文章`
  String get articleDetailShowRelatedArticles {
    return Intl.message(
      '显示相关文章',
      name: 'articleDetailShowRelatedArticles',
      desc: '',
      args: [],
    );
  }

  /// `显示图片标题`
  String get articleDetailShowImageAlt {
    return Intl.message(
      '显示图片标题',
      name: 'articleDetailShowImageAlt',
      desc: '',
      args: [],
    );
  }

  /// `移除重复文章`
  String get removeDuplicateArticles {
    return Intl.message(
      '移除重复文章',
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

  /// `软件启动时拉取文章`
  String get pullWhenStartUp {
    return Intl.message(
      '软件启动时拉取文章',
      name: 'pullWhenStartUp',
      desc: '',
      args: [],
    );
  }

  /// `滚动时自动标记为已读`
  String get autoReadWhenScrolling {
    return Intl.message(
      '滚动时自动标记为已读',
      name: 'autoReadWhenScrolling',
      desc: '',
      args: [],
    );
  }

  /// `拉取时缓存图片`
  String get cacheImageWhenPull {
    return Intl.message(
      '拉取时缓存图片',
      name: 'cacheImageWhenPull',
      desc: '',
      args: [],
    );
  }

  /// `拉取时缓存文章`
  String get cacheWebPageWhenPull {
    return Intl.message(
      '拉取时缓存文章',
      name: 'cacheWebPageWhenPull',
      desc: '',
      args: [],
    );
  }

  /// `阅读时缓存文章`
  String get cacheWebPageWhenReading {
    return Intl.message(
      '阅读时缓存文章',
      name: 'cacheWebPageWhenReading',
      desc: '',
      args: [],
    );
  }

  /// `拉取策略`
  String get pullStrategy {
    return Intl.message(
      '拉取策略',
      name: 'pullStrategy',
      desc: '',
      args: [],
    );
  }

  /// `TTS设置`
  String get ttsSetting {
    return Intl.message(
      'TTS设置',
      name: 'ttsSetting',
      desc: '',
      args: [],
    );
  }

  /// `启用TTS`
  String get ttsEnable {
    return Intl.message(
      '启用TTS',
      name: 'ttsEnable',
      desc: '',
      args: [],
    );
  }

  /// `TTS引擎`
  String get ttsEngine {
    return Intl.message(
      'TTS引擎',
      name: 'ttsEngine',
      desc: '',
      args: [],
    );
  }

  /// `默认朗读速度`
  String get ttsSpeed {
    return Intl.message(
      '默认朗读速度',
      name: 'ttsSpeed',
      desc: '',
      args: [],
    );
  }

  /// `忽略音频焦点`
  String get ttsSpot {
    return Intl.message(
      '忽略音频焦点',
      name: 'ttsSpot',
      desc: '',
      args: [],
    );
  }

  /// `允许与其他应用同时播放音频`
  String get ttsSpotTip {
    return Intl.message(
      '允许与其他应用同时播放音频',
      name: 'ttsSpotTip',
      desc: '',
      args: [],
    );
  }

  /// `自动标记为已读`
  String get ttsAutoHaveRead {
    return Intl.message(
      '自动标记为已读',
      name: 'ttsAutoHaveRead',
      desc: '',
      args: [],
    );
  }

  /// `文章朗读完毕后自动标记为已读`
  String get ttsAutoHaveReadTip {
    return Intl.message(
      '文章朗读完毕后自动标记为已读',
      name: 'ttsAutoHaveReadTip',
      desc: '',
      args: [],
    );
  }

  /// `唤醒锁`
  String get ttsWakeLock {
    return Intl.message(
      '唤醒锁',
      name: 'ttsWakeLock',
      desc: '',
      args: [],
    );
  }

  /// `朗读时启用唤醒锁(可能会被杀后台)`
  String get ttsWakeLockTip {
    return Intl.message(
      '朗读时启用唤醒锁(可能会被杀后台)',
      name: 'ttsWakeLockTip',
      desc: '',
      args: [],
    );
  }

  /// `系统TTS设置`
  String get ttsSystemSetting {
    return Intl.message(
      '系统TTS设置',
      name: 'ttsSystemSetting',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
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
