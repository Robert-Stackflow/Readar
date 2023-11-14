import 'package:app_settings/app_settings.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../Providers/global_provider.dart';
import '../../Providers/provider_manager.dart';
import '../../Utils/hive_util.dart';
import '../../Utils/itoast.dart';
import '../../Widgets/BottomSheet/bottom_sheet_builder.dart';
import '../../Widgets/BottomSheet/list_bottom_sheet.dart';
import '../../Widgets/Item/item_builder.dart';
import '../../generated/l10n.dart';
import '../Lock/pin_change_screen.dart';
import '../Lock/pin_verify_screen.dart';

class ExperimentSettingScreen extends StatefulWidget {
  const ExperimentSettingScreen({super.key});

  static const String routeName = "/setting/experiment";

  @override
  State<ExperimentSettingScreen> createState() =>
      _ExperimentSettingScreenState();
}

class _ExperimentSettingScreenState extends State<ExperimentSettingScreen>
    with TickerProviderStateMixin {
  bool _enableGuesturePasswd =
      HiveUtil.getBool(key: HiveUtil.enableGuesturePasswdKey);
  bool _hasGuesturePasswd =
      HiveUtil.getString(key: HiveUtil.guesturePasswdKey) != null &&
          HiveUtil.getString(key: HiveUtil.guesturePasswdKey)!.isNotEmpty;
  bool _autoLock = HiveUtil.getBool(key: HiveUtil.autoLockKey);
  bool _enableSafeMode =
      HiveUtil.getBool(key: HiveUtil.enableSafeModeKey, defaultValue: false);
  bool _enableBiometric = HiveUtil.getBool(key: HiveUtil.enableBiometricKey);
  bool _biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    initBiometricAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: ItemBuilder.buildSimpleAppBar(
            title: S.current.experimentSetting, context: context),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ScrollConfiguration(
            behavior: NoShadowScrollBehavior(),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: S.current.ttsSetting),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.ttsEnable,
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.ttsEngine,
                  tip: "默认引擎",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.ttsSpeed,
                  tip: "1.0x",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: S.current.ttsSystemSetting,
                  onTap: () {
                    AppSettings.openAppSettings(
                        type: AppSettingsType.tts, asAnotherTask: true);
                  },
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.ttsSpot,
                  value: true,
                  description: S.current.ttsSpotTip,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.ttsAutoHaveRead,
                  value: true,
                  description: S.current.ttsAutoHaveReadTip,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: S.current.ttsWakeLock,
                  value: true,
                  description: S.current.ttsWakeLockTip,
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "AI摘要"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "AI摘要",
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "启用Cloud Reader AI",
                  description: "官方提供的AI服务，我们承诺不会泄露您的隐私",
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "第三方AI服务管理",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "内容发送模板",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "内容发送字数上限",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "聊天室",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "翻译"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "启用翻译",
                  value: true,
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "第三方翻译服务管理",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "源语言",
                  description: "当文章为何种语言时自动翻译",
                  onTap: () {},
                ),
                ItemBuilder.buildEntryItem(
                  context: context,
                  title: "目标语言",
                  description: "将文章自动翻译为目标语言",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(
                    context: context, title: S.current.privacySetting),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: _enableGuesturePasswd,
                  title: "启用手势密码",
                  onTap: onEnablePinTapped,
                ),
                Visibility(
                  visible: _enableGuesturePasswd,
                  child: ItemBuilder.buildEntryItem(
                    context: context,
                    title: _hasGuesturePasswd ? "更改手势密码" : "设置手势密码",
                    description: _hasGuesturePasswd ? "" : "设置手势密码后才能使用锁定功能",
                    onTap: onChangePinTapped,
                  ),
                ),
                Visibility(
                  visible: _enableGuesturePasswd &&
                      _hasGuesturePasswd &&
                      _biometricAvailable,
                  child: ItemBuilder.buildRadioItem(
                    context: context,
                    value: _enableBiometric,
                    title: "生物识别",
                    onTap: onBiometricTapped,
                  ),
                ),
                Visibility(
                  visible: _enableGuesturePasswd && _hasGuesturePasswd,
                  child: ItemBuilder.buildRadioItem(
                    context: context,
                    value: _autoLock,
                    title: "处于后台自动锁定",
                    onTap: onEnableAutoLockTapped,
                  ),
                ),
                Visibility(
                  visible:
                      _enableGuesturePasswd && _hasGuesturePasswd && _autoLock,
                  child: Selector<GlobalProvider, int>(
                    selector: (context, globalProvider) =>
                        globalProvider.autoLockTime,
                    builder: (context, autoLockTime, child) =>
                        ItemBuilder.buildEntryItem(
                      context: context,
                      title: "自动锁定时机",
                      tip: GlobalProvider.getAutoLockOptionLabel(autoLockTime),
                      onTap: () {
                        BottomSheetBuilder.showListBottomSheet(
                          context,
                          (context) => TileList.fromOptions(
                            GlobalProvider.getAutoLockOptions(),
                            autoLockTime,
                            (item2) {
                              ProviderManager.globalProvider.autoLockTime =
                                  item2;
                              Navigator.pop(context);
                            },
                            context: context,
                            title: "选择自动锁定时机",
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ItemBuilder.buildRadioItem(
                  context: context,
                  value: _enableSafeMode,
                  title: "安全模式",
                  bottomRadius: true,
                  description: "当软件进入最近任务列表页面，隐藏页面内容；同时禁用应用内截图",
                  onTap: onSafeModeTapped,
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildCaptionItem(context: context, title: "其他选项"),
                ItemBuilder.buildRadioItem(
                  context: context,
                  title: "硬件加速",
                  value: true,
                  description: "启用以提高软件运行流畅度，也可能会造成一些问题",
                  bottomRadius: true,
                  onTap: () {},
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  initBiometricAuthentication() async {
    LocalAuthentication localAuth = LocalAuthentication();
    bool available = await localAuth.canCheckBiometrics;
    setState(() {
      _biometricAvailable = available;
    });
  }

  onEnablePinTapped() {
    setState(() {
      if (_enableGuesturePasswd) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinVerifyScreen(
              onSuccess: () {
                IToast.showTop(context, text: "手势密码关闭成功");
                setState(() {
                  _enableGuesturePasswd = !_enableGuesturePasswd;
                  HiveUtil.put(
                      key: HiveUtil.enableGuesturePasswdKey,
                      value: _enableGuesturePasswd);
                  _hasGuesturePasswd =
                      HiveUtil.getString(key: HiveUtil.guesturePasswdKey) !=
                              null &&
                          HiveUtil.getString(key: HiveUtil.guesturePasswdKey)!
                              .isNotEmpty;
                });
              },
              isModal: false,
            ),
          ),
        );
      } else {
        setState(() {
          _enableGuesturePasswd = !_enableGuesturePasswd;
          HiveUtil.put(
              key: HiveUtil.enableGuesturePasswdKey,
              value: _enableGuesturePasswd);
          _hasGuesturePasswd =
              HiveUtil.getString(key: HiveUtil.guesturePasswdKey) != null &&
                  HiveUtil.getString(key: HiveUtil.guesturePasswdKey)!
                      .isNotEmpty;
        });
      }
    });
  }

  onBiometricTapped() {
    if (!_enableBiometric) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PinVerifyScreen(
            onSuccess: () {
              IToast.showTop(context, text: "生物识别开启成功");
              setState(() {
                _enableBiometric = !_enableBiometric;
                HiveUtil.put(
                    key: HiveUtil.enableBiometricKey, value: _enableBiometric);
              });
            },
            isModal: false,
          ),
        ),
      );
    } else {
      setState(() {
        _enableBiometric = !_enableBiometric;
        HiveUtil.put(key: HiveUtil.enableBiometricKey, value: _enableBiometric);
      });
    }
  }

  onChangePinTapped() {
    setState(() {
      Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PinChangeScreen()))
          .then((value) {
        setState(() {
          _hasGuesturePasswd =
              HiveUtil.getString(key: HiveUtil.guesturePasswdKey) != null &&
                  HiveUtil.getString(key: HiveUtil.guesturePasswdKey)!
                      .isNotEmpty;
        });
      });
    });
  }

  onEnableAutoLockTapped() {
    setState(() {
      _autoLock = !_autoLock;
      HiveUtil.put(key: HiveUtil.autoLockKey, value: _autoLock);
    });
  }

  onSafeModeTapped() {
    setState(() {
      _enableSafeMode = !_enableSafeMode;
      if (_enableSafeMode) {
        FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      } else {
        FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
      }
      HiveUtil.put(key: HiveUtil.enableSafeModeKey, value: _enableSafeMode);
    });
  }
}
