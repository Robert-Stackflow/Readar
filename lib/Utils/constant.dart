import 'package:flutter/cupertino.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:readar/Utils/responsive_util.dart';

import '../generated/l10n.dart';

const defaultPhone = "";
const defaultPassword = "";
const defaultLofterID = "";
const defaultMail = "";

const double maxMediaOrQuoteWidth = 480;

const double searchBarWidth = 400;

const defaultFilenameFormat = "{original_name}";

const double kLoadExtentOffset = 1000;

const Widget emptyWidget = SizedBox.shrink();

const defaultWindowSize = Size(1120, 740);

const minimumSize = Size(630, 700);

const bool defaultEnableSafeMode = true;

const String shareText = "Readar - 简洁的RSS客户端\n$officialWebsite";
const String feedbackEmail = "2014027378@qq.com";
const String feedbackSubject = "Readar反馈";
const windowsKeyPath = r'SOFTWARE\Cloudchewie\Readar';
const String feedbackBody = "";
const String downloadPkgsUrl = "https://pkgs.cloudchewie.com/Readar";
const String officialWebsite = "https://apps.cloudchewie.com/readar";
const String telegramGroupUrl = "https://t.me/Readar_official";
const String qqGroupUrl = "https://qm.qq.com/q/2HJ8PC1XcQ";
const String repoUrl = "https://github.com/Robert-Stackflow/Readar";
const String releaseUrl =
    "https://github.com/Robert-Stackflow/Readar/releases";
const String issueUrl = "https://github.com/Robert-Stackflow/Readar/issues";

const String cloudControlUrl =
    "https://apps.cloudchewie.com/readar/control.json";
const String fontsUrl = "https://apps.cloudchewie.com/readar/fonts.json";

AndroidAuthMessages androidAuthMessages = AndroidAuthMessages(
  cancelButton: S.current.biometricCancelButton,
  goToSettingsButton: S.current.biometricGoToSettingsButton,
  biometricNotRecognized: S.current.biometricNotRecognized,
  goToSettingsDescription: S.current.biometricGoToSettingsDescription,
  biometricHint: ResponsiveUtil.isWindows()
      ? S.current.biometricReasonWindows("Readar")
      : S.current.biometricReason("Readar"),
  biometricSuccess: S.current.biometricSuccess,
  signInTitle: S.current.biometricSignInTitle,
  deviceCredentialsRequiredTitle:
      S.current.biometricDeviceCredentialsRequiredTitle,
);
