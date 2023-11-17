import 'package:flutter/foundation.dart';

/// DropdownMenuController use to show and hide drop-down menus.
/// Used for DropdownHeader and DropdownMenu passing[dropDownMenuTop], [menuIndex], [isShow] and [isShowHideAnimation].
class DropdownMenuController extends ChangeNotifier {
  /// [dropDownMenuTop] that the DropDownMenu top edge is inset from the top of the stack.
  ///
  /// Since the DropDownMenu actually returns a Positioned widget, the DropDownMenu must be inside the Stack
  /// vertically.
  double? dropDownMenuTop;

  /// Current or last dropdown menu index, default is 0.
  int menuIndex = 0;

  /// Whether to display a dropdown menu.
  bool isShow = false;

  /// Whether to display animations when hiding dropdown menu.
  bool isShowHideAnimation = false;

  /// Use to display DropdownMenu specified dropdown menu index.
  void show(int index) {
    isShow = true;
    menuIndex = index;
    notifyListeners();
  }

  /// Use to hide DropdownMenu. If you don't need to show the hidden animation, [isShowHideAnimation] pass in false, Like when you click on another DropdownHeaderItem.
  void hide({bool isShowHideAnimation = true}) {
    this.isShowHideAnimation = isShowHideAnimation;
    isShow = false;
    notifyListeners();
  }
}
