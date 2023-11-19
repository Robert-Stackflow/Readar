import 'package:flutter/material.dart';

class MyColors {
  static const Color default_primary_color = Color(0xFF2196F3);
  static const Color dark_default_primary_color = Color(0xFF2196F3);

  static const Color appbar = bg_color;
  static const Color dark_appbar = dark_bg_color;

  static const Color bg_color = Color(0xFFF7F8F9);
  static const Color dark_bg_color = Color(0xFF121212);

  static const Color splash_color = Color(0xFFF1F1F1);
  static const Color dark_splash_color = Color(0x20cccccc);

  static const Color highlight_color = Color(0xFFF1F1F1);
  static const Color dark_highlight_color = Color(0x20cccccc);

  static const Color icon_color = Color(0xFF333333);
  static const Color dark_icon_color = Color(0xFFB8B8B8);

  static const Color shadow_color = Color(0xFF666666);
  static const Color dark_shadow_color = Color(0xFFFFFFFF);

  static const Color material_bg = Color(0xFFFFFFFF);
  static const Color dark_material_bg = Color(0xFF252525);

  static const Color text = Color(0xFF333333);
  static const Color dark_text = Color(0xFFB8B8B8);

  static const Color text_gray = Color(0xFF999999);
  static const Color text_gray_c = Color(0xFFcccccc);
  static const Color dark_text_gray = Color(0xFF666666);

  static const Color button_text = Color(0xFFF2F2F2);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  static const Color bg_gray = Color(0xFFF6F6F6);
  static const Color dark_bg_gray = Color(0xFF1F1F1F);

  static const Color divider = Color(0xFFF5F6F7);
  static const Color dark_divider = Color(0xFF393939);

  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);

  static const Color text_disabled = Color(0xFFD4E2FA);
  static const Color dark_text_disabled = Color(0xFFCEDBF2);

  static const Color button_disabled = Color(0xFF96BBFA);
  static const Color dark_button_disabled = Color(0xFF83A5E0);

  static const Color unselected_item_color = Color(0xffbfbfbf);
  static const Color dark_unselected_item_color = Color(0xFF4D4D4D);

  static const Color bg_gray_ = Color(0xFFFAFAFA);
  static const Color dark_bg_gray_ = Color(0xFF242526);

  static const Color gradient_blue = Color(0xFF5793FA);
  static const Color shadow_blue = Color(0x805793FA);
  static const Color orange = Color(0xFFFF8547);

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
