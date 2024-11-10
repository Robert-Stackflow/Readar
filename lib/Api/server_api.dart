import 'dart:io';

import 'package:dio/dio.dart';
import 'package:readar/Utils/app_provider.dart';
import 'package:readar/Utils/cloud_control_provider.dart';
import 'package:readar/Utils/constant.dart';
import 'package:readar/Utils/hive_util.dart';
import 'package:readar/Widgets/Dialog/dialog_builder.dart';

import '../Models/cloud_control.dart';
import '../Utils/ilogger.dart';
import '../Utils/utils.dart';

class ServerApi {
  static Future<ReadarControl?> getCloudControl() async {
    try {
      final response = await Dio().get(cloudControlUrl);
      if (response.statusCode == 200) {
        final data = response.data;
        var cloudControl = ReadarControl.fromJson(data);
        ILogger.info(
            "Loaded cloudControl from $cloudControlUrl: ${cloudControl.toJson()}");
        controlProvider.originalCloudControl = cloudControl;
        controlProvider.globalControl = cloudControl;
        if (cloudControl.enableAppNotNull) {
          if (HiveUtil.getBool(HiveUtil.overrideCloudControlKey,
              defaultValue: false)) {
            controlProvider.globalControl =
                ReadarControl.getOverridedCloudControl(cloudControl);
          }
        } else {
          Utils.initSimpleTray();
          DialogBuilder.showInfoDialog(
            rootContext,
            title: cloudControl.disableReasonTitle,
            message: cloudControl.disableReasonMessage,
            barrierDismissible: false,
            onTapDismiss: () {
              exit(0);
            },
          );
        }
      }
    } catch (e, t) {
      ILogger.error("Failed to load cloudControl from $cloudControlUrl", e, t);
    }
    return null;
  }
}
