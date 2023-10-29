import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

class MyStyles {
  static const TextStyle textSize12 = TextStyle(
    fontSize: MyDimens.font_sp12,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: MyDimens.font_sp16,
  );
  static const TextStyle textBold14 =
      TextStyle(fontSize: MyDimens.font_sp14, fontWeight: FontWeight.bold);
  static const TextStyle textBold16 =
      TextStyle(fontSize: MyDimens.font_sp16, fontWeight: FontWeight.bold);
  static const TextStyle textBold18 =
      TextStyle(fontSize: MyDimens.font_sp18, fontWeight: FontWeight.bold);
  static const TextStyle textBold24 =
      TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  static const TextStyle textBold26 =
      TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold);

  static const TextStyle textGray14 = TextStyle(
    fontSize: MyDimens.font_sp14,
    color: MyColors.text_gray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: MyDimens.font_sp14,
    color: MyColors.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: MyDimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle text = TextStyle(
      fontSize: MyDimens.font_sp14,
      color: MyColors.text,
      textBaseline: TextBaseline.alphabetic);
  static const TextStyle textDark = TextStyle(
      fontSize: MyDimens.font_sp14,
      color: MyColors.dark_text,
      textBaseline: TextBaseline.alphabetic);

  static const TextStyle captionDark = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    letterSpacing: 0.1,
    color: Colors.grey,
  );

  static const TextStyle caption = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    letterSpacing: 0.1,
    color: Colors.grey,
  );

  static const TextStyle titleDark = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    letterSpacing: 0.1,
    color: MyColors.dark_text,
  );

  static const TextStyle title = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: MyColors.text,
  );

  static const TextStyle textGray12 = TextStyle(
      fontSize: MyDimens.font_sp12,
      color: MyColors.text_gray,
      fontWeight: FontWeight.normal);
  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: MyDimens.font_sp12,
      color: MyColors.dark_text_gray,
      fontWeight: FontWeight.normal);

  static const TextStyle textHint14 = TextStyle(
      fontSize: MyDimens.font_sp14, color: MyColors.dark_unselected_item_color);
}
