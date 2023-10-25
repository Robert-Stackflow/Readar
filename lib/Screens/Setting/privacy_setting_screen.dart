import 'package:cloudreader/Configs/hive_config.dart';
import 'package:cloudreader/Models/auto_lock.dart';
import 'package:cloudreader/Screens/Lock/pin_change_screen.dart';
import 'package:cloudreader/Themes/icon.dart';
import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:cloudreader/Widgets/BottomSheet/bottom_sheet_builder.dart'
    as bottom_sheet_builder;
import 'package:cloudreader/Widgets/BottomSheet/list_bottom_sheet.dart';
import 'package:cloudreader/Widgets/item_builder.dart';
import 'package:cloudreader/Widgets/no_shadow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:local_auth/local_auth.dart';

import '../Lock/pin_verify_screen.dart';

class PrivacySettingScreen extends StatefulWidget {
  const PrivacySettingScreen({super.key});

  static const String routeName = "/setting/privacy";

  @override
  State<PrivacySettingScreen> createState() => _PrivacySettingScreenState();
}

class _PrivacySettingScreenState extends State<PrivacySettingScreen>
    with TickerProviderStateMixin {
  bool _lock = HiveConfig.getBool(key: HiveConfig.lockEnableKey);
  bool _autoLock = HiveConfig.getBool(key: HiveConfig.autoLockKey);
  bool _biometricLock = HiveConfig.getBool(key: HiveConfig.biometricEnableKey);
  bool _safeMode =
      HiveConfig.getBool(key: HiveConfig.safeModeKey, defaultValue: false);
  int _autoLockOption = HiveConfig.getInt(key: HiveConfig.autoLockTimeKey);
  String _availableBiometricString = "";
  bool _isBiometricAvailable = false;
  bool _existPin = HiveConfig.getString(key: HiveConfig.lockPinKey)!.isNotEmpty;

  getAuth() async {
    LocalAuthentication localAuth = LocalAuthentication();
    bool available = await localAuth.canCheckBiometrics;
    setState(() {
      _isBiometricAvailable = available;
    });
    if (!_isBiometricAvailable) {
      return;
    }
    final List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        setState(() {
          _availableBiometricString += "指纹识别";
        });
      }
      if (availableBiometrics.contains(BiometricType.face)) {
        setState(() {
          _availableBiometricString += "面容识别";
        });
      }
      setState(() {
        if (_availableBiometricString != "") {
          _availableBiometricString = "可用生物识别：$_availableBiometricString";
        }
      });
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    getAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 40,
          elevation: 0.2,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.darkerText,
              size: 23,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "隐私",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: AppTheme.darkerText,
                fontSize: 17),
          ),
          backgroundColor: AppTheme.background,
        ),
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
                ItemBuilder.buildRadioItem(
                  value: _lock,
                  title: "手势密码",
                  topRadius: true,
                  bottomRadius: !_lock,
                  description: "关闭手势密码后，后台自动锁定将无法使用",
                  onTap: () {
                    setState(() {
                      if (_lock) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PinVerifyScreen(
                              onSuccess: () {
                                IToast.showTop(context, text: "关闭手势密码成功");
                                HiveConfig.delete(key: HiveConfig.lockPinKey);
                                setState(() {
                                  _lock = !_lock;
                                  HiveConfig.put(
                                      key: HiveConfig.lockEnableKey,
                                      value: _lock);
                                  _existPin = HiveConfig.getString(
                                          key: HiveConfig.lockPinKey)!
                                      .isNotEmpty;
                                });
                              },
                              isModal: false,
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          _lock = !_lock;
                          HiveConfig.put(
                              key: HiveConfig.lockEnableKey, value: _lock);
                          _existPin =
                              HiveConfig.getString(key: HiveConfig.lockPinKey)!
                                  .isNotEmpty;
                        });
                      }
                    });
                  },
                  leading: Iconfont.shezhi,
                ),
                Visibility(
                  visible: _lock,
                  child: ItemBuilder.buildEntryItem(
                    title: _existPin ? "更改手势密码" : "设置手势密码",
                    description: _existPin ? "" : "设置手势密码后才能使用锁定功能",
                    bottomRadius: true,
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PinChangeScreen())).then((value) {
                          setState(() {
                            _existPin = HiveConfig.getString(
                                    key: HiveConfig.lockPinKey)!
                                .isNotEmpty;
                          });
                        });
                      });
                    },
                    leading: Iconfont.shezhi,
                  ),
                ),
                Visibility(
                  visible: _lock && _isBiometricAvailable && _existPin,
                  child: const SizedBox(height: 10),
                ),
                Visibility(
                  visible: _lock && _isBiometricAvailable && _existPin,
                  child: ItemBuilder.buildRadioItem(
                    value: _biometricLock,
                    title: "生物识别",
                    topRadius: true,
                    bottomRadius: true,
                    description: _availableBiometricString.isNotEmpty
                        ? _availableBiometricString
                        : "关闭后无法使用指纹、面容等方式解锁",
                    onTap: () {
                      if (!_biometricLock) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PinVerifyScreen(
                              onSuccess: () {
                                IToast.showTop(context, text: "生物识别开启成功");
                                setState(() {
                                  _biometricLock = !_biometricLock;
                                  HiveConfig.put(
                                      key: HiveConfig.biometricEnableKey,
                                      value: _biometricLock);
                                });
                              },
                              isModal: false,
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          _biometricLock = !_biometricLock;
                          HiveConfig.put(
                              key: HiveConfig.biometricEnableKey,
                              value: _biometricLock);
                        });
                      }
                    },
                    leading: Iconfont.shezhi,
                  ),
                ),
                Visibility(
                  visible: _lock && _existPin,
                  child: const SizedBox(height: 10),
                ),
                Visibility(
                  visible: _lock && _existPin,
                  child: ItemBuilder.buildRadioItem(
                    value: _autoLock,
                    title: "处于后台自动锁定",
                    topRadius: true,
                    bottomRadius: !(_lock && _autoLock && _existPin),
                    description: "当软件处于后台时，自动锁定应用",
                    onTap: () {
                      setState(() {
                        _autoLock = !_autoLock;
                        HiveConfig.put(
                            key: HiveConfig.autoLockKey, value: _autoLock);
                      });
                    },
                    leading: Iconfont.shezhi,
                  ),
                ),
                Visibility(
                  visible: _lock && _autoLock && _existPin,
                  child: ItemBuilder.buildEntryItem(
                    title: "自动锁定时机",
                    bottomRadius: true,
                    tip: AutoLock.optionLabels[_autoLockOption],
                    onTap: () {
                      bottom_sheet_builder.showModalBottomSheet(
                        backgroundColor: Colors.white.withOpacity(0),
                        context: context,
                        builder: (context) => ListBottomSheet(
                          currentIndex: _autoLockOption,
                          title: "选择自动锁定时机",
                          labels: AutoLock.optionLabels,
                          onChanged: (int index) {
                            setState(() {
                              _autoLockOption = index;
                              HiveConfig.put(
                                  key: HiveConfig.autoLockTimeKey,
                                  value: index);
                            });
                          },
                        ),
                      );
                    },
                    leading: Iconfont.shezhi,
                  ),
                ),
                const SizedBox(height: 10),
                ItemBuilder.buildRadioItem(
                  value: _safeMode,
                  title: "安全模式",
                  topRadius: true,
                  bottomRadius: true,
                  description: "当软件进入最近任务列表页面，隐藏页面内容；同时禁用应用内截图",
                  onTap: () {
                    setState(() {
                      _safeMode = !_safeMode;
                      if (_safeMode) {
                        FlutterWindowManager.addFlags(
                            FlutterWindowManager.FLAG_SECURE);
                      } else {
                        FlutterWindowManager.clearFlags(
                            FlutterWindowManager.FLAG_SECURE);
                      }
                      HiveConfig.put(
                          key: HiveConfig.safeModeKey, value: _safeMode);
                    });
                  },
                  leading: Iconfont.jiju,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
