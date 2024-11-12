import 'package:flutter/cupertino.dart';

import '../Models/other/cloud_control.dart';

ReadarControlProvider controlProvider = ReadarControlProvider();

class ReadarControlProvider with ChangeNotifier {
  ReadarControl? _cloudControl;

  ReadarControl get originalCloudControl =>
      (_cloudControl ?? ReadarControl.defaultCloudControl);

  set originalCloudControl(ReadarControl? value) {
    _cloudControl = value;
    notifyListeners();
  }

  ReadarControl? _globalControl;

  ReadarControl get globalControl =>
      (_globalControl ?? ReadarControl.defaultCloudControl);

  set globalControl(ReadarControl? value) {
    _globalControl = value;
    notifyListeners();
  }
}
