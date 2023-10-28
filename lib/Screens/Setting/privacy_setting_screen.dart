import 'package:cloudreader/Models/auto_lock.dart';
import 'package:cloudreader/Screens/Lock/pin_change_screen.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:cloudreader/Widgets/BottomSheet/list_bottom_sheet.dart';
import 'package:cloudreader/Widgets/Custom/no_shadow_scroll_behavior.dart';
import 'package:cloudreader/Widgets/Item/item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:local_auth/local_auth.dart';

import '../../Utils/hive_util.dart';
import '../../generated/l10n.dart';
import '../Lock/pin_verify_screen.dart';

class PrivacySettingScreen extends StatefulWidget {
  const PrivacySettingScreen({super.key});

  static const String routeName = "/setting/privacy";

  @override
  State<PrivacySettingScreen> createState() => _PrivacySettingScreenState();
}

class _PrivacySettingScreenState extends State<PrivacySettingScreen>
    with TickerProviderStateMixin {
  bool _lock = HiveUtil.getBool(key: HiveUtil.lockEnableKey);
  bool _autoLock = HiveUtil.getBool(key: HiveUtil.autoLockKey);
  bool _biometricLock = HiveUtil.getBool(key: HiveUtil.biometricEnableKey);
  bool _safeMode =
      HiveUtil.getBool(key: HiveUtil.safeModeKey, defaultValue: false);
  int _autoLockOption = HiveUtil.getInt(key: HiveUtil.autoLockTimeKey);
  String _availableBiometricString = "";
  bool _isBiometricAvailable = false;
  bool _existPin = HiveUtil.getString(key: HiveUtil.lockPinKey) != null &&
      HiveUtil.getString(key: HiveUtil.lockPinKey)!.isNotEmpty;

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
        appBar: ItemBuilder.buildAppBar(
            title: S.current.privacySetting, context: context),
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
                                HiveUtil.delete(key: HiveUtil.lockPinKey);
                                setState(() {
                                  _lock = !_lock;
                                  HiveUtil.put(
                                      key: HiveUtil.lockEnableKey,
                                      value: _lock);
                                  _existPin = HiveUtil.getString(
                                          key: HiveUtil.lockPinKey)!
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
                          HiveUtil.put(
                              key: HiveUtil.lockEnableKey, value: _lock);
                          _existPin =
                              HiveUtil.getString(key: HiveUtil.lockPinKey)!
                                  .isNotEmpty;
                        });
                      }
                    });
                  },
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
                            _existPin =
                                HiveUtil.getString(key: HiveUtil.lockPinKey)!
                                    .isNotEmpty;
                          });
                        });
                      });
                    },
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
                                  HiveUtil.put(
                                      key: HiveUtil.biometricEnableKey,
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
                          HiveUtil.put(
                              key: HiveUtil.biometricEnableKey,
                              value: _biometricLock);
                        });
                      }
                    },
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
                        HiveUtil.put(
                            key: HiveUtil.autoLockKey, value: _autoLock);
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: _lock && _autoLock && _existPin,
                  child: ItemBuilder.buildEntryItem(
                    title: "自动锁定时机",
                    bottomRadius: true,
                    tip: AutoLock.optionLabels[_autoLockOption],
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white.withOpacity(0),
                        context: context,
                        builder: (context) => ListBottomSheet(
                          currentIndex: _autoLockOption,
                          title: "选择自动锁定时机",
                          labels: AutoLock.optionLabels,
                          onChanged: (int index) {
                            setState(() {
                              _autoLockOption = index;
                              HiveUtil.put(
                                  key: HiveUtil.autoLockTimeKey, value: index);
                            });
                          },
                        ),
                      );
                    },
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
                      HiveUtil.put(key: HiveUtil.safeModeKey, value: _safeMode);
                    });
                  },
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
