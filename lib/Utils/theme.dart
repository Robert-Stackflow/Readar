import 'package:flutter/material.dart';

import '../Resources/colors.dart';
import '../Resources/styles.dart';

class AppTheme {
  AppTheme._();

  static const Color gradientColor = Color(0xFFB2C18A);

  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);

  static const Color nearlyBlue = Color(0xFF00B6F0);

  static const Color darkerText = Color(0xFF17262A);
  static const Color spacer = Color(0xFFF2F2F2);

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static ThemeData getTheme({required bool isDarkMode}) {
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? MyColors.dark_app_main : MyColors.app_main,
      hintColor: isDarkMode ? MyColors.dark_app_main : MyColors.app_main,
      indicatorColor: isDarkMode ? MyColors.dark_app_main : MyColors.app_main,
      scaffoldBackgroundColor:
          isDarkMode ? MyColors.dark_bg_color : MyColors.bg_color,
      canvasColor:
          isDarkMode ? MyColors.dark_material_bg : MyColors.material_bg,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: MyColors.app_main.withAlpha(70),
        selectionHandleColor: MyColors.app_main,
      ),
      textTheme: TextTheme(
        titleSmall: isDarkMode ? MyStyles.titleDark : MyStyles.title,
        bodySmall: isDarkMode ? MyStyles.captionDark : MyStyles.caption,
        bodyLarge: isDarkMode ? MyStyles.textDark : MyStyles.text,
        titleMedium: isDarkMode ? MyStyles.textDarkGray12 : MyStyles.textGray12,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? MyStyles.textHint14 : MyStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? MyColors.dark_bg_color : Colors.white,
      ),
      iconTheme: IconThemeData(
        size: 25,
        color: isDarkMode ? MyColors.dark_text : MyColors.text,
      ),
      dividerTheme: DividerThemeData(
          color: isDarkMode ? MyColors.dark_line : MyColors.line,
          space: 0.6,
          thickness: 0.6),
    );
  }

  static const TextTheme textTheme = TextTheme(
    headlineMedium: display1,
    headlineSmall: headline,
    titleLarge: title,
    titleSmall: subtitle,
    bodyMedium: body2,
    bodyLarge: body1,
    bodySmall: caption,
  );
  static const TextStyle display1 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
  );

  static const TextStyle headline = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
  );

  static const TextStyle title = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
  );

  static const TextStyle itemTitle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.1,
  );

  static const TextStyle itemTitleLittle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    letterSpacing: 0.1,
  );

  static const TextStyle itemTip = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    letterSpacing: 0.1,
  );

  static const TextStyle itemTipLittle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 11,
    letterSpacing: 0.1,
  );

  static const TextStyle subtitle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
  );

  static const TextStyle body2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
  );

  static const TextStyle body1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
  );

  static const TextStyle caption = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
  );
}
