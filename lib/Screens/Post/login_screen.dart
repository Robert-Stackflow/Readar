import 'package:cloudreader/Themes/icon.dart';
import 'package:cloudreader/Utils/itoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Configs/hive_config.dart';
import '../../Themes/theme.dart';
import '../../Widgets/Wave/wave_container.dart';
import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.isLogin = true});

  final bool isLogin;

  static const String routeName = "/login";

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late bool isLogin = widget.isLogin;
  late TextEditingController mobileController;
  late TextEditingController passwordController;
  late bool isHide = false;

  @override
  void initState() {
    mobileController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  handleConfirm() {
    if (mobileController.text.isEmpty || passwordController.text.isEmpty) {
      IToast.showTop(context, text: "手机号或密码不能为空");
      return;
    }
    if (isLogin) {
      // UserRequest.signin(mobileController.text, passwordController.text)
      //     .then((value) {
      //   if (JWT.tryDecode(value) == null) {
      //     IToast.showTop(context, text: value);
      //   } else {
      //     IToast.showTop(context, text: "登录成功");
      //     if (HiveConfig.isFirstLogin()) {
      //       Navigator.pop(context);
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => MainScreen(key: drawerKey)));
      //       HiveConfig.put(key: HiveConfig.firstLoginKey, value: false);
      //     } else {
      //       Navigator.pop(context);
      //     }
      //   }
      // });
    } else {
      // UserRequest.signup(mobileController.text, passwordController.text)
      //     .then((value) {
      //   if (JWT.tryDecode(value) == null) {
      //     IToast.showTop(context, text: value);
      //   } else {
      //     IToast.showTop(context, text: "注册成功，将自动登录");
      //     if (HiveConfig.isFirstLogin()) {
      //       Navigator.pop(context);
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => MainScreen(key: drawerKey)));
      //       HiveConfig.put(key: HiveConfig.firstLoginKey, value: false);
      //     } else {
      //       Navigator.pop(context);
      //     }
      //   }
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.themeColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            const _WaveBg(marginTop: 80),
            Container(
              padding: const EdgeInsets.only(top: 12, right: 24, left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  header(),
                  const SizedBox(height: 65),
                  Column(
                    children: [
                      input(
                        controller: mobileController,
                        hint: "手机号码",
                        inputFormatter: [
                          LengthLimitingTextInputFormatter(11),
                          // InputFormatter(
                          //     r"^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      input(
                          controller: passwordController,
                          hint: "密码",
                          inputFormatter: [
                            LengthLimitingTextInputFormatter(16),
                          ],
                          keyboardType: TextInputType.visiblePassword),
                      const SizedBox(height: 100),
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: AppTheme.themeColor,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            handleConfirm();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(),
                  Container(),
                  // GestureDetector(
                  //   onTap: () {
                  //     if (isLogin) {}
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       isLogin ? "忘记密码" : "",
                  //       style: const TextStyle(color: AppTheme.themeColor),
                  //     ),
                  //   ),
                  // ),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget input({
    String hint = "",
    String regex = "",
    List<TextInputFormatter>? inputFormatter,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(1.0, 1.0),
              blurRadius: 4.0),
        ],
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: 1,
              obscureText:
                  keyboardType == TextInputType.visiblePassword && isHide,
              inputFormatters: inputFormatter,
              minLines: 1,
              autofocus: true,
              cursorColor: AppTheme.themeColor,
              cursorHeight: 22,
              cursorRadius: const Radius.circular(3),
              style: const TextStyle(
                letterSpacing: 1.2,
              ),
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          keyboardType == TextInputType.visiblePassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isHide = !isHide;
                    });
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      Iconfont.yanjing,
                      color: AppTheme.themeColor,
                      size: 24,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              isLogin ? '登录' : "注册",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              '欢迎来到噬云',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            )
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: CircleAvatar(
                backgroundColor: AppTheme.darkerText.withOpacity(0.1),
                child: const Icon(Icons.link_rounded, color: AppTheme.white),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                if (HiveConfig.isFirstLogin()) {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(key: drawerKey)));
                  HiveConfig.put(key: HiveConfig.firstLoginKey, value: false);
                } else {
                  Navigator.pop(context);
                }
              },
              child: CircleAvatar(
                backgroundColor: AppTheme.darkerText.withOpacity(0.1),
                child: const Icon(Icons.close_rounded, color: AppTheme.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class InputFormatter extends TextInputFormatter {
  final String regExp;

  InputFormatter(this.regExp);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (RegExp(regExp).firstMatch(newValue.text) != null) {
        return newValue;
      }
      return oldValue;
    }
    return newValue;
  }
}

class _WaveBg extends StatelessWidget {
  final double marginTop;

  const _WaveBg({
    required this.marginTop,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.2,
          child: WaveContainer(
            width: 200,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: marginTop),
            yOffset: -10,
            xOffset: 50,
            color: Colors.grey,
            duration: const Duration(seconds: 2, milliseconds: 800),
          ),
        ),
        Opacity(
          opacity: 0.3,
          child: WaveContainer(
            width: 200,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: marginTop),
            yOffset: -10,
            xOffset: 100,
            color: Colors.grey,
            duration: const Duration(seconds: 2, milliseconds: 200),
          ),
        ),
        WaveContainer(
          width: 200,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: marginTop),
          yOffset: 0,
          xOffset: 0,
          color: Colors.white,
          duration: const Duration(seconds: 2, milliseconds: 900),
        ),
      ],
    );
  }
}
