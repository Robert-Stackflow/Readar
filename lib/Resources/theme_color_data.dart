import 'package:cloudreader/Resources/colors.dart';
import 'package:flutter/material.dart';

class ThemeColorData {
  bool isDarkMode;

  String name;

  String? description;

  Color primaryColor;

  Color background;

  Color appBarBackground;

  Color splashColor;

  Color highlightColor;

  Color iconColor;

  Color shadowColor;

  Color materialBackground;

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
    required this.appBarBackground,
    required this.splashColor,
    required this.highlightColor,
    required this.iconColor,
    required this.shadowColor,
    required this.materialBackground,
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
      primaryColor: const Color(0xFF009BFF),
      background: const Color(0xFFF7F8F9),
      appBarBackground: const Color(0xFFF7F8F9),
      splashColor: const Color(0x44c8c8c8),
      highlightColor: const Color(0x44bcbcbc),
      iconColor: const Color(0xFF333333),
      shadowColor: const Color(0xFF666666),
      materialBackground: const Color(0xFFFFFFFF),
      textColor: const Color(0xFF333333),
      textGrayColor: const Color(0xFF999999),
      textDisabledColor: const Color(0xFFD4E2FA),
      buttonTextColor: const Color(0xFFF2F2F2),
      buttonDisabledColor: const Color(0xFF96BBFA),
      dividerColor: const Color(0xFFF5F6F7),
    ),
    // ThemeColorData(
    //   name: "护眼",
    //   primaryColor: const Color(0xFF11b667),
    //   background: const Color(0xFFCCE8CF),
    //   appBarBackground: const Color(0xFFCCE8CF),
    //   splashColor: const Color(0x44c8c8c8),
    //   highlightColor: const Color(0x44bcbcbc),
    //   iconColor: const Color(0xFF333333),
    //   shadowColor: const Color(0xFF666666),
    //   materialBackground: const Color(0xFFFFFFFF),
    //   textColor: const Color(0xFF333333),
    //   textGrayColor: const Color(0xFF999999),
    //   textDisabledColor: const Color(0xFFD4E2FA),
    //   buttonTextColor: const Color(0xFFF2F2F2),
    //   buttonDisabledColor: const Color(0xFF96BBFA),
    //   dividerColor: const Color(0xFFF5F6F7),
    // ),
  ];

  static List<ThemeColorData> defaultDarkThemes = [
    ThemeColorData(
      name: "极简黑",
      primaryColor: const Color(0xFF009BFF),
      background: const Color(0xFF121212),
      appBarBackground: const Color(0xFF121212),
      splashColor: const Color(0x20cccccc),
      highlightColor: const Color(0x20cfcfcf),
      iconColor: const Color(0xFFB8B8B8),
      shadowColor: const Color(0xFFFFFFFF),
      materialBackground: const Color(0xFF252525),
      textColor: const Color(0xFFB8B8B8),
      textGrayColor: const Color(0xFF666666),
      textDisabledColor: const Color(0xFFCEDBF2),
      buttonTextColor: const Color(0xFFF2F2F2),
      buttonDisabledColor: const Color(0xFF83A5E0),
      dividerColor: const Color(0xFF393939),
    ),
    ThemeColorData(
      name: "蓝铁",
      primaryColor: const Color(0xFF61A3D7),
      background: const Color(0xFF1B242F),
      appBarBackground: const Color(0xFF23303f),
      splashColor: const Color(0x20cccccc),
      highlightColor: const Color(0x20cfcfcf),
      iconColor: const Color(0xFFB8B8B8),
      shadowColor: const Color(0xFFFFFFFF),
      materialBackground: const Color(0xFF242E39),
      textColor: const Color(0xFFB8B8B8),
      textGrayColor: const Color(0xFF666666),
      textDisabledColor: const Color(0xFFCEDBF2),
      buttonTextColor: const Color(0xFFF2F2F2),
      buttonDisabledColor: const Color(0xFF83A5E0),
      dividerColor: const Color(0xFF393939),
    ),
    ThemeColorData(
      name: "静谧之夜",
      primaryColor: const Color(0xFF50A5DC),
      background: const Color(0xFF181819),
      appBarBackground: const Color(0xFF232326),
      splashColor: const Color(0x20cccccc),
      highlightColor: const Color(0x20cfcfcf),
      iconColor: const Color(0xFFB8B8B8),
      shadowColor: const Color(0xFFFFFFFF),
      materialBackground: const Color(0xFF222223),
      textColor: const Color(0xFFB8B8B8),
      textGrayColor: const Color(0xFF666666),
      textDisabledColor: const Color(0xFFCEDBF2),
      buttonTextColor: const Color(0xFFF2F2F2),
      buttonDisabledColor: const Color(0xFF83A5E0),
      dividerColor: const Color(0xFF393939),
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
      canvasColor: materialBackground,
      dividerColor: dividerColor,
      shadowColor: shadowColor,
      splashColor: splashColor,
      highlightColor: highlightColor,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return materialBackground;
          } else {
            return textGrayColor;
          }
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          } else {
            return null;
          }
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          } else {
            return materialBackground;
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
        elevation: 0.0,
        backgroundColor: appBarBackground,
      ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "isDarkMode": isDarkMode ? 1 : 0,
        "name": name,
        "description": description,
        "primaryColor": primaryColor.toHex(),
        "background": background.toHex(),
        "appBarBackground": appBarBackground.toHex(),
        "splashColor": splashColor.toHex(),
        "highlightColor": highlightColor.toHex(),
        "iconColor": iconColor.toHex(),
        "shadowColor": shadowColor.toHex(),
        "materialBackground": materialBackground.toHex(),
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
        appBarBackground: HexColor.fromHex(map['appBarBackground'] as String),
        splashColor: HexColor.fromHex(map['splashColor'] as String),
        highlightColor: HexColor.fromHex(map['highlightColor'] as String),
        iconColor: HexColor.fromHex(map['iconColor'] as String),
        shadowColor: HexColor.fromHex(map['shadowColor'] as String),
        materialBackground:
            HexColor.fromHex(map['materialBackground'] as String),
        textColor: HexColor.fromHex(map['textColor'] as String),
        textGrayColor: HexColor.fromHex(map['textGrayColor'] as String),
        textDisabledColor: HexColor.fromHex(map['textDisabledColor'] as String),
        buttonTextColor: HexColor.fromHex(map['buttonTextColor'] as String),
        buttonDisabledColor:
            HexColor.fromHex(map['buttonDisabledColor'] as String),
        dividerColor: HexColor.fromHex(map['dividerColor'] as String),
      );
}
