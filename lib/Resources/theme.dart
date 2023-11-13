import 'package:flutter/material.dart';

import 'colors.dart';
import 'styles.dart';

class AppTheme {
  AppTheme._();

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static ThemeData getTheme({required bool isDarkMode}) {
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? MyColors.dark_app_main : MyColors.app_main,
      hintColor: isDarkMode ? MyColors.dark_app_main : MyColors.app_main,
      indicatorColor: isDarkMode ? MyColors.dark_app_main : MyColors.app_main,
      shadowColor:
          isDarkMode ? MyColors.dark_shadow_color : MyColors.shadow_color,
      scaffoldBackgroundColor:
          isDarkMode ? MyColors.dark_bg_color : MyColors.bg_color,
      canvasColor:
          isDarkMode ? MyColors.dark_material_bg : MyColors.material_bg,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: MyColors.app_main.withAlpha(70),
        selectionHandleColor: MyColors.app_main,
      ),
      textTheme: TextTheme(
        titleSmall: isDarkMode ? MyStyles.captionDark : MyStyles.caption,
        titleMedium: isDarkMode ? MyStyles.titleDark : MyStyles.title,
        bodySmall: isDarkMode ? MyStyles.bodySmallDark : MyStyles.bodySmall,
        bodyMedium: isDarkMode ? MyStyles.bodyMediumDark : MyStyles.bodyMedium,
        titleLarge: isDarkMode ? MyStyles.titleLargeDark : MyStyles.titleLarge,
        bodyLarge: isDarkMode ? MyStyles.textDark : MyStyles.text,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? MyStyles.textHint14 : MyStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: isDarkMode ? MyColors.dark_appbar : MyColors.appbar,
      ),
      errorColor: isDarkMode ? MyColors.dark_red : Colors.red,
      iconTheme: IconThemeData(
        size: 25,
        color: isDarkMode ? MyColors.dark_icon_color : MyColors.icon_color,
      ),
      dividerColor: isDarkMode ? MyColors.dark_divider : MyColors.divider,
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
