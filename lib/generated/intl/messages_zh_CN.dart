// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(progress) => "已下载${progress}%";

  static String m1(version) => "当前版本为${version}，已经是最新版本";

  static String m2(reason) => "未知原因：${reason}";

  static String m3(appName) => "进行指纹验证以使用${appName}";

  static String m4(appName) => "验证PIN以使用${appName}";

  static String m5(log) => "更新日志如下：<br/>${log}";

  static String m6(day) => "${day}天前";

  static String m7(fontFamily) => "删除字体${fontFamily}";

  static String m8(fontFamily) => "是否删除字体${fontFamily}？删除后该字体文件无法找回";

  static String m9(version) => "发现新版本${version}";

  static String m10(hour) => "${hour}小时前";

  static String m11(filepath) => "安装包${filepath}不存在";

  static String m12(license) => "根据${license}许可证开源";

  static String m13(type) => "错误类型：${type}";

  static String m14(minute) => "${minute}分钟前";

  static String m15(version) => "新版本：${version}";

  static String m16(uri) => "不支持的URI：${uri}";

  static String m17(selected, preferred, active) =>
      "意在解决部分机型高刷失效的问题，如无问题，请不要修改\n如果您的设备支持LTPO，可能会设置失败\n已选模式: ${selected}\n首选模式: ${preferred}\n活动模式: ${active}";

  static String m18(second) => "${second}秒前";

  static String m19(error) => "刷新率设置失败: ${error}";

  static String m20(officialWebsite) =>
      "Readar - 简洁的双因素身份验证器\\n${officialWebsite}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "advancedSetting": MessageLookupByLibrary.simpleMessage("进阶设置"),
        "after10MinutesLock":
            MessageLookupByLibrary.simpleMessage("处于后台10分钟后锁定"),
        "after1MinuteLock": MessageLookupByLibrary.simpleMessage("处于后台1分钟后锁定"),
        "after30SecondsLock":
            MessageLookupByLibrary.simpleMessage("处于后台30秒后锁定"),
        "after3MinutesLock": MessageLookupByLibrary.simpleMessage("处于后台3分钟后锁定"),
        "after5MinutesLock": MessageLookupByLibrary.simpleMessage("处于后台5分钟后锁定"),
        "aiSetting": MessageLookupByLibrary.simpleMessage("AI"),
        "all": MessageLookupByLibrary.simpleMessage("全部"),
        "alreadyDownload": MessageLookupByLibrary.simpleMessage("已下载"),
        "alreadyDownloadProgress": m0,
        "alreadyLatestVersion": MessageLookupByLibrary.simpleMessage("已经是最新版本"),
        "alreadyLatestVersionTip": m1,
        "appName": MessageLookupByLibrary.simpleMessage("Readar"),
        "appearanceSetting": MessageLookupByLibrary.simpleMessage("外观"),
        "articleDetailHeaderImageViewType":
            MessageLookupByLibrary.simpleMessage("头图显示方式"),
        "articleDetailLayoutType":
            MessageLookupByLibrary.simpleMessage("文章详情布局"),
        "articleDetailShowImageAlt":
            MessageLookupByLibrary.simpleMessage("显示图片标题"),
        "articleDetailShowRelatedArticles":
            MessageLookupByLibrary.simpleMessage("显示相关文章"),
        "articleDetailVideoViewType":
            MessageLookupByLibrary.simpleMessage("视频显示方式"),
        "articleListLayoutType": MessageLookupByLibrary.simpleMessage("文章列表布局"),
        "atLeast4Points":
            MessageLookupByLibrary.simpleMessage("连接数不能小于4个，请重新设置"),
        "autoCheckUpdates": MessageLookupByLibrary.simpleMessage("自动检查更新"),
        "autoLock": MessageLookupByLibrary.simpleMessage("处于后台自动锁定"),
        "autoLockDelay": MessageLookupByLibrary.simpleMessage("自动锁定时机"),
        "autoLockTip": MessageLookupByLibrary.simpleMessage(
            "在Windows、Linux、MacOS设备中，窗口最小化或最小化至托盘时即表示处于后台"),
        "autoMemoryWindowPositionAndSize":
            MessageLookupByLibrary.simpleMessage("记忆窗口位置和大小"),
        "autoMemoryWindowPositionAndSizeTip":
            MessageLookupByLibrary.simpleMessage(
                "关闭后，每次打开Readar都会居中显示且具有默认窗口大小"),
        "autoReadWhenScrolling":
            MessageLookupByLibrary.simpleMessage("滚动时自动标记为已读"),
        "back": MessageLookupByLibrary.simpleMessage("返回"),
        "backToHome": MessageLookupByLibrary.simpleMessage("返回首页"),
        "backupServiceSetting": MessageLookupByLibrary.simpleMessage("备份服务"),
        "backupSetting": MessageLookupByLibrary.simpleMessage("备份"),
        "basicSetting": MessageLookupByLibrary.simpleMessage("基本设置"),
        "biometric": MessageLookupByLibrary.simpleMessage("生物识别"),
        "biometricCancelButton": MessageLookupByLibrary.simpleMessage("取消"),
        "biometricDeviceCredentialsRequiredTitle":
            MessageLookupByLibrary.simpleMessage("请先录入指纹!"),
        "biometricError": MessageLookupByLibrary.simpleMessage("验证失败"),
        "biometricErrorHwUnavailable":
            MessageLookupByLibrary.simpleMessage("当前设备的生物识别硬件不可用"),
        "biometricErrorNoBiometricEnrolled":
            MessageLookupByLibrary.simpleMessage("当前设备未录入生物识别"),
        "biometricErrorNoHardware":
            MessageLookupByLibrary.simpleMessage("当前设备不支持生物识别"),
        "biometricErrorPasscodeNotSet":
            MessageLookupByLibrary.simpleMessage("当前设备未设置锁屏密码"),
        "biometricErrorUnkown": MessageLookupByLibrary.simpleMessage("未知错误"),
        "biometricErrorUnsupported":
            MessageLookupByLibrary.simpleMessage("当前平台不支持生物识别"),
        "biometricGoToSettingsButton":
            MessageLookupByLibrary.simpleMessage("去设置"),
        "biometricGoToSettingsDescription":
            MessageLookupByLibrary.simpleMessage("请设置指纹"),
        "biometricHint": MessageLookupByLibrary.simpleMessage(""),
        "biometricLockout":
            MessageLookupByLibrary.simpleMessage("生物识别功能已被锁定，请稍后再试"),
        "biometricLockoutPermanent":
            MessageLookupByLibrary.simpleMessage("生物识别功能已被永久锁定，请使用其他方式解锁"),
        "biometricNotAvailable":
            MessageLookupByLibrary.simpleMessage("您的设备不支持生物识别"),
        "biometricNotEnrolled":
            MessageLookupByLibrary.simpleMessage("您的设备未录入生物识别"),
        "biometricNotRecognized":
            MessageLookupByLibrary.simpleMessage("指纹识别失败"),
        "biometricOtherReason": m2,
        "biometricReason": m3,
        "biometricReasonWindows": m4,
        "biometricSignInTitle": MessageLookupByLibrary.simpleMessage("指纹验证"),
        "biometricSuccess": MessageLookupByLibrary.simpleMessage("指纹识别成功"),
        "biometricTimeout": MessageLookupByLibrary.simpleMessage("操作超时"),
        "biometricUnknown":
            MessageLookupByLibrary.simpleMessage("验证失败，可能是尝试次数过多"),
        "biometricUnlock": MessageLookupByLibrary.simpleMessage("使用生物识别解锁"),
        "biometricUnlockTip": MessageLookupByLibrary.simpleMessage(
            "仅通过生物识别进行身份验证；仅支持Android、IOS、Windows设备；Windows设备上仅支持PIN码验证"),
        "biometricUserCanceled": MessageLookupByLibrary.simpleMessage("用户取消操作"),
        "biometricVerifyPin": MessageLookupByLibrary.simpleMessage("验证PIN"),
        "biometricVerifySuccess": MessageLookupByLibrary.simpleMessage("验证成功"),
        "blueIron": MessageLookupByLibrary.simpleMessage("蓝铁"),
        "bugReport": MessageLookupByLibrary.simpleMessage("报告BUG"),
        "cacheImageWhenPull": MessageLookupByLibrary.simpleMessage("拉取时缓存图片"),
        "cacheWebPageWhenPull": MessageLookupByLibrary.simpleMessage("拉取时缓存文章"),
        "cacheWebPageWhenReading":
            MessageLookupByLibrary.simpleMessage("阅读时缓存文章"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "cancelShare": MessageLookupByLibrary.simpleMessage("取消分享"),
        "changeDayNightMode": MessageLookupByLibrary.simpleMessage("切换深浅色模式"),
        "changeGestureLock": MessageLookupByLibrary.simpleMessage("更改手势密码"),
        "changelog": MessageLookupByLibrary.simpleMessage("更新日志"),
        "changelogAsFollow": m5,
        "checkUpdates": MessageLookupByLibrary.simpleMessage("检查更新"),
        "checkUpdatesFailed": MessageLookupByLibrary.simpleMessage("检查更新失败"),
        "checkUpdatesFailedTip":
            MessageLookupByLibrary.simpleMessage("检查更新失败，请重试"),
        "checkingUpdates": MessageLookupByLibrary.simpleMessage("检查更新中..."),
        "chooseAutoLockDelay": MessageLookupByLibrary.simpleMessage("选择自动锁定时机"),
        "chooseCloseWindowOption":
            MessageLookupByLibrary.simpleMessage("选择关闭主界面时"),
        "chooseFontFamily": MessageLookupByLibrary.simpleMessage("选择字体"),
        "chooseLanguage": MessageLookupByLibrary.simpleMessage("选择语言"),
        "chooseRefreshRate": MessageLookupByLibrary.simpleMessage("选择刷新率"),
        "chooseThemeMode": MessageLookupByLibrary.simpleMessage("选择主题模式"),
        "clearCache": MessageLookupByLibrary.simpleMessage("清空缓存"),
        "clearCacheSuccess": MessageLookupByLibrary.simpleMessage("清空缓存成功"),
        "clearLog": MessageLookupByLibrary.simpleMessage("清空日志"),
        "clearLogFailed": MessageLookupByLibrary.simpleMessage("清空日志失败"),
        "clearLogHint": MessageLookupByLibrary.simpleMessage(
            "是否清空日志？当您在使用软件的过程中遇到问题时，我们建议您导出日志后再清空日志"),
        "clearLogSuccess": MessageLookupByLibrary.simpleMessage("清空日志成功"),
        "clearLogTitle": MessageLookupByLibrary.simpleMessage("确认清空日志"),
        "clearingCache": MessageLookupByLibrary.simpleMessage("清空缓存中..."),
        "clearingLog": MessageLookupByLibrary.simpleMessage("清空日志中..."),
        "closeWindowOption": MessageLookupByLibrary.simpleMessage("关闭主界面时"),
        "complete": MessageLookupByLibrary.simpleMessage("完成"),
        "confirm": MessageLookupByLibrary.simpleMessage("确认"),
        "contact": MessageLookupByLibrary.simpleMessage("联系我们"),
        "copy": MessageLookupByLibrary.simpleMessage("复制"),
        "copyLink": MessageLookupByLibrary.simpleMessage("复制链接"),
        "copySuccess": MessageLookupByLibrary.simpleMessage("复制成功"),
        "crawlType": MessageLookupByLibrary.simpleMessage("文章抓取方式"),
        "currentVersion": MessageLookupByLibrary.simpleMessage("当前版本"),
        "custom": MessageLookupByLibrary.simpleMessage("自定义"),
        "customFontFamily": MessageLookupByLibrary.simpleMessage("自定义字体"),
        "cut": MessageLookupByLibrary.simpleMessage("剪切"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("深色模式"),
        "dayAgo": m6,
        "defaultFontFamily": MessageLookupByLibrary.simpleMessage("内置字体"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "deleteFailed": MessageLookupByLibrary.simpleMessage("删除失败"),
        "deleteFont": m7,
        "deleteFontMessage": m8,
        "deleteSuccess": MessageLookupByLibrary.simpleMessage("删除成功"),
        "deleting": MessageLookupByLibrary.simpleMessage("删除中..."),
        "description": MessageLookupByLibrary.simpleMessage("描述"),
        "desktopSetting": MessageLookupByLibrary.simpleMessage("桌面端设置"),
        "disableGestureLockSuccess":
            MessageLookupByLibrary.simpleMessage("手势密码关闭成功"),
        "displayAppTray": MessageLookupByLibrary.simpleMessage("显示主窗口"),
        "doesImmediateUpdate": MessageLookupByLibrary.simpleMessage("是否立即更新？"),
        "download": MessageLookupByLibrary.simpleMessage("下载"),
        "downloadComplete": MessageLookupByLibrary.simpleMessage("下载完成"),
        "downloadFailed": MessageLookupByLibrary.simpleMessage("下载失败"),
        "downloadFailedAndRetry":
            MessageLookupByLibrary.simpleMessage("下载失败，请重试"),
        "downloadFailedAndRetryTip":
            MessageLookupByLibrary.simpleMessage("新版本安装包下载失败，请重试"),
        "downloadSuccess": MessageLookupByLibrary.simpleMessage("下载成功"),
        "downloadSuccessClickToInstall":
            MessageLookupByLibrary.simpleMessage("新版本安装包已经下载完成，点击立即安装"),
        "downloading": MessageLookupByLibrary.simpleMessage("下载中..."),
        "downloadingNewVersionPackage":
            MessageLookupByLibrary.simpleMessage("正在下载新版本安装包..."),
        "drawGestureLockAgain":
            MessageLookupByLibrary.simpleMessage("请再次绘制手势密码"),
        "drawNewGestureLock": MessageLookupByLibrary.simpleMessage("绘制新手势密码"),
        "drawOldGestureLock": MessageLookupByLibrary.simpleMessage("请绘制旧手势密码"),
        "dynamic": MessageLookupByLibrary.simpleMessage("动态"),
        "edit": MessageLookupByLibrary.simpleMessage("修改"),
        "editFailed": MessageLookupByLibrary.simpleMessage("修改失败"),
        "editSuccess": MessageLookupByLibrary.simpleMessage("修改成功"),
        "eggEssay": MessageLookupByLibrary.simpleMessage(
            "&emsp;&emsp;恭喜你发现了我藏在Readar中的<strong>小彩蛋</strong>！"),
        "eggMessage": MessageLookupByLibrary.simpleMessage(
            "&emsp;&emsp;恭喜你发现了我藏在Readar中的<strong>小彩蛋</strong>！<br/>&emsp;&emsp;相信发现这个彩蛋的你已经很熟悉Readar了，那么我先做个自我介绍吧。我呢，是一个喜欢用开发来方便自己的人，并经常乐此不疲地投入时间和精力去打磨自己的作品。由于实在无法忍受Lofter中烦人的广告，我在机缘巧合下重新拾起了Flutter开发Readar，并适配了平板设备和Windows系统。<br/>&emsp;&emsp;在Readar之前，我用原生安卓开发过一个完整的小项目CloudOTP，这款简洁的双因素身份验证器受到我室友的青睐，甚至他的同事还询问有没有IOS版本的，这是我第一次体会到自己的作品被他人认可的那种奇妙的感觉。在闲暇的时候，我已经用Flutter全面重构了CloudOTP，并支持了更多新特性。在未来我也会将自己的作品呈现给更多喜欢它的人们。<br/>&emsp;&emsp;我总喜欢在我的作品中埋藏彩蛋，然而却都不够精彩和独一无二。这个彩蛋的灵感呢，来源于Android 14系统，是我设计过的彩蛋中唯一差强人意的一个，以此献给使用Readar的你，希望你喜欢这个彩蛋，也希望你能喜欢Readar💕💕。"),
        "enable": MessageLookupByLibrary.simpleMessage("启用"),
        "enableBiometricSuccess":
            MessageLookupByLibrary.simpleMessage("生物识别开启成功"),
        "enableFrostedGlassEffect":
            MessageLookupByLibrary.simpleMessage("启用毛玻璃效果"),
        "enableGestureLock": MessageLookupByLibrary.simpleMessage("启用手势密码"),
        "enableGestureLockSuccess":
            MessageLookupByLibrary.simpleMessage("手势密码启用成功"),
        "enableGestureLockTip":
            MessageLookupByLibrary.simpleMessage("启用手势密码，保护你的Readar"),
        "enter": MessageLookupByLibrary.simpleMessage("进入"),
        "errorQrCode": MessageLookupByLibrary.simpleMessage("二维码构建失败"),
        "escape": MessageLookupByLibrary.simpleMessage("退出"),
        "example": MessageLookupByLibrary.simpleMessage("示例"),
        "exitApp": MessageLookupByLibrary.simpleMessage("退出Readar"),
        "exitAppTray": MessageLookupByLibrary.simpleMessage("退出"),
        "experimentSetting": MessageLookupByLibrary.simpleMessage("实验室"),
        "explore": MessageLookupByLibrary.simpleMessage("探索"),
        "exportFailed": MessageLookupByLibrary.simpleMessage("导出失败"),
        "exportLog": MessageLookupByLibrary.simpleMessage("导出日志"),
        "exportLogHint": MessageLookupByLibrary.simpleMessage(
            "当您在使用软件的过程中遇到问题时，导出日志提供给开发者以方便溯源"),
        "exportPathCannotInLogDir":
            MessageLookupByLibrary.simpleMessage("导出路径不能在日志目录中"),
        "exportSuccess": MessageLookupByLibrary.simpleMessage("导出成功"),
        "exporting": MessageLookupByLibrary.simpleMessage("导出中..."),
        "extensionSetting": MessageLookupByLibrary.simpleMessage("扩展"),
        "failedToGetChangelog":
            MessageLookupByLibrary.simpleMessage("获取更新日志失败"),
        "feedbackSubject": MessageLookupByLibrary.simpleMessage("Readar反馈"),
        "feedbackWelcome": MessageLookupByLibrary.simpleMessage("欢迎反馈"),
        "feedbackWelcomeMessage":
            MessageLookupByLibrary.simpleMessage("加入QQ群，反馈BUG、建议和想法，欢迎你的加入！"),
        "field": MessageLookupByLibrary.simpleMessage("字段"),
        "followSystem": MessageLookupByLibrary.simpleMessage("跟随系统"),
        "fontFamily": MessageLookupByLibrary.simpleMessage("字体"),
        "fontFamlyLoadFailed": MessageLookupByLibrary.simpleMessage("字体加载失败"),
        "fontFamlyLoadSuccess":
            MessageLookupByLibrary.simpleMessage("字体加载成功，重启后切换"),
        "fontFileLoading": MessageLookupByLibrary.simpleMessage("字体文件加载中..."),
        "fontFileNotExist":
            MessageLookupByLibrary.simpleMessage("字体文件不存在，请尝试重新下载或导入"),
        "fontItemCaptionLatin": MessageLookupByLibrary.simpleMessage("AaBbCc"),
        "fontItemCaptionNonLatin": MessageLookupByLibrary.simpleMessage("你好世界"),
        "freshGreen": MessageLookupByLibrary.simpleMessage("清新绿"),
        "generalSetting": MessageLookupByLibrary.simpleMessage("通用"),
        "gestureLock": MessageLookupByLibrary.simpleMessage("手势密码"),
        "gestureLockNotMatch":
            MessageLookupByLibrary.simpleMessage("与上一次绘制不一致, 请重新绘制"),
        "gestureLockWrong": MessageLookupByLibrary.simpleMessage("密码错误, 请重新绘制"),
        "getNewVersion": m9,
        "githubRepo": MessageLookupByLibrary.simpleMessage("GitHub仓库"),
        "globalSetting": MessageLookupByLibrary.simpleMessage("全局"),
        "goToBrowserUpdate": MessageLookupByLibrary.simpleMessage("前往浏览器更新"),
        "goToQQ": MessageLookupByLibrary.simpleMessage("跳转至QQ"),
        "goToSetGestureLock": MessageLookupByLibrary.simpleMessage("前往设置"),
        "goToUpdate": MessageLookupByLibrary.simpleMessage("前往更新"),
        "harmonyOSSans": MessageLookupByLibrary.simpleMessage("HarmonyOS Sans"),
        "hasRejectedFilePermission":
            MessageLookupByLibrary.simpleMessage("已拒绝文件存储权限，将跳转到浏览器下载"),
        "haveToRestartWhenChange":
            MessageLookupByLibrary.simpleMessage("更改后需要重启"),
        "haveToSetGestureLockTip":
            MessageLookupByLibrary.simpleMessage("设置手势密码后才能使用锁定功能"),
        "hideAppbarWhenScrolling":
            MessageLookupByLibrary.simpleMessage("滚动时隐藏标题栏"),
        "hideBottombarWhenScrolling":
            MessageLookupByLibrary.simpleMessage("滚动时隐藏底栏"),
        "home": MessageLookupByLibrary.simpleMessage("首页"),
        "hourAgo": m10,
        "imageSetting": MessageLookupByLibrary.simpleMessage("图片"),
        "immediatelyDownload": MessageLookupByLibrary.simpleMessage("立即下载"),
        "immediatelyInstall": MessageLookupByLibrary.simpleMessage("立即安装"),
        "immediatelyLock": MessageLookupByLibrary.simpleMessage("立即锁定"),
        "inAppBrowser": MessageLookupByLibrary.simpleMessage("内置浏览器"),
        "input": MessageLookupByLibrary.simpleMessage("输入"),
        "installCanceled": MessageLookupByLibrary.simpleMessage("安装已取消"),
        "installFileNotFound": m11,
        "installPortableTip":
            MessageLookupByLibrary.simpleMessage("您当前正在使用便携版，请手动解压缩安装包并覆盖原有文件"),
        "installing": MessageLookupByLibrary.simpleMessage("安装中..."),
        "joinLater": MessageLookupByLibrary.simpleMessage("暂不加入"),
        "jumpFailed": MessageLookupByLibrary.simpleMessage("跳转失败"),
        "jumpToBrowserDownload":
            MessageLookupByLibrary.simpleMessage("即将跳转到浏览器下载"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "launchAtStartup": MessageLookupByLibrary.simpleMessage("开机自启动"),
        "layoutSetting": MessageLookupByLibrary.simpleMessage("布局"),
        "licenseDetail": m12,
        "lightTheme": MessageLookupByLibrary.simpleMessage("浅色模式"),
        "loadErrorType": m13,
        "loadFailed": MessageLookupByLibrary.simpleMessage("加载失败"),
        "loadFontFamily": MessageLookupByLibrary.simpleMessage("导入字体"),
        "loadUnkownError": MessageLookupByLibrary.simpleMessage("未知错误"),
        "loading": MessageLookupByLibrary.simpleMessage("加载中..."),
        "lock": MessageLookupByLibrary.simpleMessage("锁定软件"),
        "lockAppTray": MessageLookupByLibrary.simpleMessage("锁定"),
        "lxgw": MessageLookupByLibrary.simpleMessage("霞鹜文楷"),
        "lxgwGB": MessageLookupByLibrary.simpleMessage("霞鹜文楷-GB"),
        "lxgwLite": MessageLookupByLibrary.simpleMessage("霞鹜文楷-Lite"),
        "lxgwScreen": MessageLookupByLibrary.simpleMessage("霞鹜文楷-Screen"),
        "miSans": MessageLookupByLibrary.simpleMessage("MiSans"),
        "mine": MessageLookupByLibrary.simpleMessage("我的"),
        "minimizeToTray": MessageLookupByLibrary.simpleMessage("最小化至系统托盘"),
        "minuteAgo": m14,
        "mobileSetting": MessageLookupByLibrary.simpleMessage("移动端设置"),
        "mobilizerType": MessageLookupByLibrary.simpleMessage("Mobilizer"),
        "newTheme": MessageLookupByLibrary.simpleMessage("新建主题"),
        "newVersion": m15,
        "noEmailClient":
            MessageLookupByLibrary.simpleMessage("尚未安装邮箱程序，已复制Email地址到剪贴板"),
        "noGestureLock": MessageLookupByLibrary.simpleMessage("尚未设置手势密码"),
        "noGestureLockTip":
            MessageLookupByLibrary.simpleMessage("尚未设置手势密码，是否前往设置"),
        "noLog": MessageLookupByLibrary.simpleMessage("暂无日志可导出"),
        "notSupportedUri": m16,
        "officialWebsite": MessageLookupByLibrary.simpleMessage("官方网站"),
        "officialWebsiteTray": MessageLookupByLibrary.simpleMessage("官网"),
        "openWithBrowser": MessageLookupByLibrary.simpleMessage("在浏览器打开"),
        "operationSetting": MessageLookupByLibrary.simpleMessage("操作"),
        "overrideCloudControl": MessageLookupByLibrary.simpleMessage("覆盖云控"),
        "overrideCloudControlDescription":
            MessageLookupByLibrary.simpleMessage("覆盖云控值，使Readar的功能更加丰富"),
        "paste": MessageLookupByLibrary.simpleMessage("粘贴"),
        "platformSetting": MessageLookupByLibrary.simpleMessage("平台适配设置"),
        "pleaseClickToRate": MessageLookupByLibrary.simpleMessage("请点击评分"),
        "pleaseGrantFilePermission":
            MessageLookupByLibrary.simpleMessage("请授予文件存储权限"),
        "pleaseRate": MessageLookupByLibrary.simpleMessage("请评分"),
        "primaryColor": MessageLookupByLibrary.simpleMessage("主色调"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("隐私政策"),
        "privacySetting": MessageLookupByLibrary.simpleMessage("隐私"),
        "pullStrategy": MessageLookupByLibrary.simpleMessage("拉取策略"),
        "pullWhenStartUp": MessageLookupByLibrary.simpleMessage("软件启动时拉取文章"),
        "pureBlack": MessageLookupByLibrary.simpleMessage("极简黑"),
        "pureWhite": MessageLookupByLibrary.simpleMessage("极简白"),
        "qqGroup": MessageLookupByLibrary.simpleMessage("QQ群聊"),
        "rate": MessageLookupByLibrary.simpleMessage("评个分吧"),
        "rate1Star": MessageLookupByLibrary.simpleMessage("革命仍需努力"),
        "rate2Star": MessageLookupByLibrary.simpleMessage("期待您的反馈和建议"),
        "rate3Star": MessageLookupByLibrary.simpleMessage("我会继续进步的！"),
        "rate4Star": MessageLookupByLibrary.simpleMessage("收下你的认可啦"),
        "rate5Star": MessageLookupByLibrary.simpleMessage("啾咪~~"),
        "rateLater": MessageLookupByLibrary.simpleMessage("暂不评分"),
        "rateSuccess": MessageLookupByLibrary.simpleMessage("感谢您的评分"),
        "rateTitle": MessageLookupByLibrary.simpleMessage("为Readar评个分吧"),
        "refresh": MessageLookupByLibrary.simpleMessage("刷新"),
        "refreshRate": MessageLookupByLibrary.simpleMessage("刷新率"),
        "refreshRateDescription": m17,
        "reload": MessageLookupByLibrary.simpleMessage("重新加载"),
        "removeDuplicateArticles":
            MessageLookupByLibrary.simpleMessage("移除重复文章"),
        "repoTray": MessageLookupByLibrary.simpleMessage("GitHub"),
        "reset": MessageLookupByLibrary.simpleMessage("重置"),
        "resetSuccess": MessageLookupByLibrary.simpleMessage("重置成功"),
        "retry": MessageLookupByLibrary.simpleMessage("重试"),
        "rightnow": MessageLookupByLibrary.simpleMessage("刚刚"),
        "rssServiceSetting": MessageLookupByLibrary.simpleMessage("RSS服务"),
        "safeMode": MessageLookupByLibrary.simpleMessage("安全模式"),
        "safeModeTip": MessageLookupByLibrary.simpleMessage(
            "仅支持Android、IOS设备；当软件进入最近任务列表页面，隐藏页面内容；同时禁用应用内截图"),
        "safeSetting": MessageLookupByLibrary.simpleMessage("安全"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "saveSuccess": MessageLookupByLibrary.simpleMessage("保存成功"),
        "search": MessageLookupByLibrary.simpleMessage("搜索"),
        "searchInApp": MessageLookupByLibrary.simpleMessage("应用内搜索"),
        "secondAgo": m18,
        "select": MessageLookupByLibrary.simpleMessage("选择"),
        "selectAll": MessageLookupByLibrary.simpleMessage("全选"),
        "selectTheme": MessageLookupByLibrary.simpleMessage("选择主题"),
        "serviceTerm": MessageLookupByLibrary.simpleMessage("服务条款"),
        "setGestureLock": MessageLookupByLibrary.simpleMessage("设置手势密码"),
        "setGestureLockSuccess":
            MessageLookupByLibrary.simpleMessage("手势密码设置成功"),
        "setRefreshRateFailed": MessageLookupByLibrary.simpleMessage("刷新率设置失败"),
        "setRefreshRateFailedWithError": m19,
        "setRefreshRateSuccess":
            MessageLookupByLibrary.simpleMessage("刷新率设置成功"),
        "setRefreshRateSuccessWithDisplayModeNotChanged":
            MessageLookupByLibrary.simpleMessage("刷新率设置成功，但当前显示模式未改变"),
        "setSuccess": MessageLookupByLibrary.simpleMessage("设置成功"),
        "setting": MessageLookupByLibrary.simpleMessage("设置"),
        "share": MessageLookupByLibrary.simpleMessage("分享"),
        "shareApp": MessageLookupByLibrary.simpleMessage("分享APP"),
        "shareAppText": m20,
        "shareFailed": MessageLookupByLibrary.simpleMessage("分享失败"),
        "shareSuccess": MessageLookupByLibrary.simpleMessage("分享成功"),
        "shareToOtherApps": MessageLookupByLibrary.simpleMessage("分享到其他应用"),
        "shortcut": MessageLookupByLibrary.simpleMessage("快捷键"),
        "shortcutHelp": MessageLookupByLibrary.simpleMessage("快捷键帮助"),
        "showTray": MessageLookupByLibrary.simpleMessage("显示系统托盘"),
        "smileySans": MessageLookupByLibrary.simpleMessage("得意黑"),
        "submitRate": MessageLookupByLibrary.simpleMessage("提交评分"),
        "telegramGroup": MessageLookupByLibrary.simpleMessage("Telegram频道"),
        "tenThousand": MessageLookupByLibrary.simpleMessage("万"),
        "themeMode": MessageLookupByLibrary.simpleMessage("主题模式"),
        "themeSetting": MessageLookupByLibrary.simpleMessage("主题设置"),
        "ttsAutoHaveRead": MessageLookupByLibrary.simpleMessage("自动标记为已读"),
        "ttsAutoHaveReadTip":
            MessageLookupByLibrary.simpleMessage("文章朗读完毕后自动标记为已读"),
        "ttsEnable": MessageLookupByLibrary.simpleMessage("启用TTS"),
        "ttsEngine": MessageLookupByLibrary.simpleMessage("TTS引擎"),
        "ttsSetting": MessageLookupByLibrary.simpleMessage("TTS设置"),
        "ttsSpeed": MessageLookupByLibrary.simpleMessage("默认朗读速度"),
        "ttsSpot": MessageLookupByLibrary.simpleMessage("忽略音频焦点"),
        "ttsSpotTip": MessageLookupByLibrary.simpleMessage("允许与其他应用同时播放音频"),
        "ttsSystemSetting": MessageLookupByLibrary.simpleMessage("系统TTS设置"),
        "ttsWakeLock": MessageLookupByLibrary.simpleMessage("唤醒锁"),
        "ttsWakeLockTip":
            MessageLookupByLibrary.simpleMessage("朗读时启用唤醒锁(可能会被杀后台)"),
        "updateLater": MessageLookupByLibrary.simpleMessage("暂不更新"),
        "useDesktopLayoutWhenLandscape":
            MessageLookupByLibrary.simpleMessage("横屏时启用桌面端布局"),
        "verifyGestureLock": MessageLookupByLibrary.simpleMessage("验证手势密码")
      };
}
