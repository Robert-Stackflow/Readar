import 'package:cloudreader/Resources/colors.dart';
import 'package:flutter/material.dart';

class ThemeColorData {
  bool isDarkMode;

  String name;

  String? description;

  Color primaryColor;

  Color background;

  Color appBarBackgroundColor;

  Color appBarSurfaceTintColor;

  Color appBarShadowColor;

  double appBarElevation;

  double appBarScrollUnderElevation;

  Color splashColor;

  Color highlightColor;

  Color iconColor;

  Color shadowColor;

  Color canvasBackground;

  Color textColor;

  Color textGrayColor;

  Color textDisabledColor;

  Color buttonTextColor;

  Color buttonDisabledColor;

  Color dividerColor;

  ThemeColorData({
    this.isDarkMode = false,
    required this.name,
    this.description,
    required this.primaryColor,
    required this.background,
    required this.appBarBackgroundColor,
    required this.appBarSurfaceTintColor,
    required this.appBarShadowColor,
    this.appBarElevation = 0.0,
    this.appBarScrollUnderElevation = 1.0,
    required this.splashColor,
    required this.highlightColor,
    required this.iconColor,
    required this.shadowColor,
    required this.canvasBackground,
    required this.textColor,
    required this.textGrayColor,
    required this.textDisabledColor,
    required this.buttonTextColor,
    required this.buttonDisabledColor,
    required this.dividerColor,
  });

  static List<ThemeColorData> defaultLightThemes = [
    ThemeColorData(
      name: "极简白",
      background: const Color(0xFFF7F8F9),
      canvasBackground: const Color(0xFFFFFFFF),
      primaryColor: const Color(0xFF444444),
      iconColor: const Color(0xFF333333),
      splashColor: const Color(0x44c8c8c8),
      highlightColor: const Color(0x44bcbcbc),
      shadowColor: const Color(0xFFF6F6F6),
      appBarShadowColor: const Color(0xFFF6F6F6),
      appBarBackgroundColor: const Color(0xFFF7F8F9),
      appBarSurfaceTintColor: const Color(0xFFF7F8F9),
      textColor: const Color(0xFF333333),
      textGrayColor: const Color(0xFF999999),
      textDisabledColor: const Color(0xFFD4E2FA),
      buttonTextColor: const Color(0xFFF2F2F2),
      buttonDisabledColor: const Color(0xFF96BBFA),
      dividerColor: const Color(0xFFF5F6F7),
    ),
    // ThemeColorData(
    //   name: "墨水屏",
    //   background: const Color(0xFFFFFFFF),
    //   canvasBackground: const Color(0xFFFFFFFF),
    //   primaryColor: const Color(0xFF444444),
    //   iconColor: const Color(0xFF333333),
    //   splashColor: const Color(0x44c8c8c8),
    //   highlightColor: const Color(0x44bcbcbc),
    //   shadowColor: const Color(0xFFF6F6F6),
    //   appBarShadowColor: const Color(0xFFF5F6F7),
    //   appBarBackgroundColor: const Color(0xFFFFFFFF),
    //   appBarSurfaceTintColor: const Color(0xFFFFFFFF),
    //   textColor: const Color(0xFF333333),
    //   textGrayColor: const Color(0xFF999999),
    //   textDisabledColor: const Color(0xFFD4E2FA),
    //   buttonTextColor: const Color(0xFFF2F2F2),
    //   buttonDisabledColor: const Color(0xFF96BBFA),
    //   dividerColor: const Color(0xFFF5F6F7),
    // ),
    ThemeColorData(
      name: "灰度",
      background: const Color(0xFFC6C6C5),
      canvasBackground: const Color(0xFFDADAD8),
      primaryColor: const Color(0xFF4A4A4A),
      iconColor: const Color(0xFF52524F),
      splashColor: const Color(0x44c1c1c1),
      highlightColor: const Color(0x44bcbcbc),
      shadowColor: const Color(0xFFF6F6F6),
      appBarShadowColor: const Color(0xFFF6F6F6),
      appBarBackgroundColor: const Color(0xFFDADAD8),
      appBarSurfaceTintColor: const Color(0xFFDADAD8),
      textColor: const Color(0xFF333333),
      textGrayColor: const Color(0xFF555555),
      textDisabledColor: const Color(0xFFD4E2FA),
      buttonTextColor: const Color(0xFFF2F2F2),
      buttonDisabledColor: const Color(0xFF96BBFA),
      dividerColor: const Color(0xFFCFCFCF),
    ),
  ];

  static List<ThemeColorData> defaultDarkThemes = [
    ThemeColorData(
      name: "极简黑",
      background: const Color(0xFF121212),
      canvasBackground: const Color(0xFF1A1A1A),
      primaryColor: const Color(0xFFBABABA),
      iconColor: const Color(0xFFB8B8B8),
      splashColor: const Color(0x12cccccc),
      highlightColor: const Color(0x12cfcfcf),
      shadowColor: const Color(0xFF1F1F1F),
      appBarShadowColor: const Color(0xFF1F1F1F),
      appBarBackgroundColor: const Color(0xFF121212),
      appBarSurfaceTintColor: const Color(0xFF121212),
      textColor: const Color(0xFFB8B8B8),
      textGrayColor: const Color(0xFF666666),
      textDisabledColor: const Color(0xFFCEDBF2),
      buttonTextColor: const Color(0xFFF2F2F2),
      buttonDisabledColor: const Color(0xFF83A5E0),
      dividerColor: const Color(0xFF222222),
    ),
    // ThemeColorData(
    //   name: "墨水屏",
    //   background: const Color(0xFF121212),
    //   canvasBackground: const Color(0xFF121212),
    //   primaryColor: const Color(0xFFBABABA),
    //   iconColor: const Color(0xFFB8B8B8),
    //   splashColor: const Color(0x12cccccc),
    //   highlightColor: const Color(0x12cfcfcf),
    //   shadowColor: const Color(0xFF1F1F1F),
    //   appBarShadowColor: const Color(0xFF1F1F1F),
    //   appBarBackgroundColor: const Color(0xFF121212),
    //   appBarSurfaceTintColor: const Color(0xFF121212),
    //   textColor: const Color(0xFFB8B8B8),
    //   textGrayColor: const Color(0xFF666666),
    //   textDisabledColor: const Color(0xFFCEDBF2),
    //   buttonTextColor: const Color(0xFFF2F2F2),
    //   buttonDisabledColor: const Color(0xFF83A5E0),
    //   dividerColor: const Color(0xFF222222),
    // ),
    ThemeColorData(
      name: "静谧之夜",
      background: const Color(0xFF181819),
      canvasBackground: const Color(0xFF232326),
      primaryColor: const Color(0xFF50A5DC),
      iconColor: const Color(0xFFB8B8B8),
      splashColor: const Color(0x12cccccc),
      highlightColor: const Color(0x12cfcfcf),
      shadowColor: const Color(0xFF1F1F1F),
      appBarShadowColor: const Color(0xFF1F1F1F),
      appBarBackgroundColor: const Color(0xFF232326),
      appBarSurfaceTintColor: const Color(0xFF232326),
      textColor: const Color(0xFFB8B8B8),
      textGrayColor: const Color(0xFF666666),
      textDisabledColor: const Color(0xFFCEDBF2),
      buttonTextColor: const Color(0xFFF2F2F2),
      buttonDisabledColor: const Color(0xFF83A5E0),
      dividerColor: const Color(0xFF303030),
    ),
    ThemeColorData(
      name: "蓝铁",
      background: const Color(0xFF1D2733),
      canvasBackground: const Color(0xFF242E39),
      primaryColor: const Color(0xFF61A3D7),
      iconColor: const Color(0xFFB8B8B8),
      splashColor: const Color(0x0Acccccc),
      highlightColor: const Color(0x0Acfcfcf),
      shadowColor: const Color(0xFF1B2530),
      appBarShadowColor: const Color(0xFF1B2530),
      appBarBackgroundColor: const Color(0xFF252E3A),
      appBarSurfaceTintColor: const Color(0xFF252E3A),
      textColor: const Color(0xFFB8B8B8),
      textGrayColor: const Color(0xFF6B7783),
      textDisabledColor: const Color(0xFFCEDBF2),
      buttonTextColor: const Color(0xFFF2F2F2),
      buttonDisabledColor: const Color(0xFF83A5E0),
      dividerColor: const Color(0xFF2D3743),
    ),
  ];

  ThemeData toThemeData() {
    TextStyle text = TextStyle(
      fontSize: 14,
      color: textColor,
      textBaseline: TextBaseline.alphabetic,
    );

    TextStyle labelSmall = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      letterSpacing: 0.1,
      color: textGrayColor,
    );

    TextStyle caption = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 13,
      letterSpacing: 0.1,
      color: textGrayColor,
    );

    TextStyle title = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      letterSpacing: 0.1,
      color: textColor,
    );

    TextStyle titleLarge = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 17,
      letterSpacing: 0.18,
      color: textColor,
    );

    TextStyle bodySmall = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 13,
      letterSpacing: 0.1,
      color: textColor,
    );

    TextStyle bodyMedium = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      letterSpacing: 0.1,
      color: textColor,
    );
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: primaryColor,
      hintColor: primaryColor,
      indicatorColor: primaryColor,
      scaffoldBackgroundColor: background,
      canvasColor: canvasBackground,
      dividerColor: dividerColor,
      shadowColor: shadowColor,
      splashColor: splashColor,
      highlightColor: highlightColor,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return canvasBackground;
          } else {
            return textGrayColor.withAlpha(200);
          }
        }),
        trackOutlineColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          } else {
            return textGrayColor.withAlpha(40);
          }
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          } else {
            return canvasBackground;
          }
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          } else {
            return canvasBackground;
          }
        }),
      ),
      iconTheme: IconThemeData(
        size: 24,
        color: iconColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: primaryColor.withAlpha(70),
        selectionHandleColor: primaryColor,
      ),
      textTheme: TextTheme(
        labelSmall: labelSmall,
        titleSmall: caption,
        titleMedium: title,
        bodySmall: bodySmall,
        bodyMedium: bodyMedium,
        titleLarge: titleLarge,
        bodyLarge: text,
      ),
      appBarTheme: AppBarTheme(
        elevation: appBarElevation,
        scrolledUnderElevation: appBarScrollUnderElevation,
        shadowColor: appBarShadowColor,
        backgroundColor: appBarBackgroundColor,
        surfaceTintColor: appBarSurfaceTintColor,
      ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "isDarkMode": isDarkMode ? 1 : 0,
        "name": name,
        "description": description,
        "primaryColor": primaryColor.toHex(),
        "background": background.toHex(),
        "appBarBackground": appBarBackgroundColor.toHex(),
        "appBarSurfaceTintColor": appBarSurfaceTintColor.toHex(),
        "appBarShadowColor": appBarShadowColor.toHex(),
        "appBarElevation": appBarElevation,
        "appBarScrollUnderElevation": appBarScrollUnderElevation,
        "splashColor": splashColor.toHex(),
        "highlightColor": highlightColor.toHex(),
        "iconColor": iconColor.toHex(),
        "shadowColor": shadowColor.toHex(),
        "materialBackground": canvasBackground.toHex(),
        "textColor": textColor.toHex(),
        "textGrayColor": textGrayColor.toHex(),
        "textDisabledColor": textDisabledColor.toHex(),
        "buttonTextColor": buttonTextColor.toHex(),
        "buttonDisabledColor": buttonDisabledColor.toHex(),
        "dividerColor": dividerColor.toHex(),
      };

  factory ThemeColorData.fromJson(Map<String, dynamic> map) => ThemeColorData(
        isDarkMode: map['isDarkMode'] == 0 ? false : true,
        name: map['name'] as String,
        description: map['description'] as String,
        primaryColor: HexColor.fromHex(map['primaryColor'] as String),
        background: HexColor.fromHex(map['background'] as String),
        appBarShadowColor: HexColor.fromHex(map['appBarShadowColor'] as String),
        appBarBackgroundColor:
            HexColor.fromHex(map['appBarBackground'] as String),
        appBarSurfaceTintColor:
            HexColor.fromHex(map['appBarSurfaceTintColor'] as String),
        appBarElevation: map['appBarElevation'] as double,
        appBarScrollUnderElevation: map['appBarScrollUnderElevation'] as double,
        splashColor: HexColor.fromHex(map['splashColor'] as String),
        highlightColor: HexColor.fromHex(map['highlightColor'] as String),
        iconColor: HexColor.fromHex(map['iconColor'] as String),
        shadowColor: HexColor.fromHex(map['shadowColor'] as String),
        canvasBackground: HexColor.fromHex(map['materialBackground'] as String),
        textColor: HexColor.fromHex(map['textColor'] as String),
        textGrayColor: HexColor.fromHex(map['textGrayColor'] as String),
        textDisabledColor: HexColor.fromHex(map['textDisabledColor'] as String),
        buttonTextColor: HexColor.fromHex(map['buttonTextColor'] as String),
        buttonDisabledColor:
            HexColor.fromHex(map['buttonDisabledColor'] as String),
        dividerColor: HexColor.fromHex(map['dividerColor'] as String),
      );

  static bool isImmersive(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor ==
        Theme.of(context).canvasColor;
  }
}
