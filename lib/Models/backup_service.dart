import 'dart:convert';

import 'feed_setting.dart';

///
/// 云盘备份服务
///
class BackupService {
  int id;
  String? endpoint;
  String? email; // email or region
  String? account; //account or bucket
  String? secret; //secret or secretKey
  String? token; //token or accessKey
  bool enabled;
  int totalSize;
  int usedSize;
  int remainingSize;
  int createTimestamp;
  int editTimestamp;
  int lastFetchTimestamp;
  int lastBackupTimestamp;
  SyncStatus lastFetchStatus;
  SyncStatus lastBackupStatus;
  Map<String, dynamic> params;

  BackupService({
    required this.id,
    this.endpoint,
    this.email,
    this.account,
    this.secret,
    this.token,
    this.enabled = true,
    this.totalSize = 0,
    this.usedSize = 0,
    this.remainingSize = 0,
    this.createTimestamp = 0,
    this.editTimestamp = 0,
    this.lastFetchTimestamp = 0,
    this.lastBackupTimestamp = 0,
    this.lastFetchStatus=SyncStatus.unspecified,
    this.lastBackupStatus=SyncStatus.unspecified,
    this.params = const {},
  });

  BackupService._privateConstructor(
    this.id,
    this.endpoint,
    this.email,
    this.account,
    this.secret,
    this.token,
    this.enabled,
    this.totalSize,
    this.usedSize,
    this.remainingSize,
    this.createTimestamp,
    this.editTimestamp,
    this.lastFetchTimestamp,
    this.lastBackupTimestamp,
    this.lastFetchStatus,
    this.lastBackupStatus,
    this.params,
  );

  BackupService clone() {
    return BackupService._privateConstructor(
      id,
      endpoint,
      email,
      account,
      secret,
      token,
      enabled,
      totalSize,
      usedSize,
      remainingSize,
      createTimestamp,
      editTimestamp,
      lastFetchTimestamp,
      lastBackupTimestamp,
      lastFetchStatus,
      lastBackupStatus,
      Map<String, dynamic>.from(params),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'endpoint': endpoint,
        'email': email,
        'account': account,
        'secret': secret,
        'token': token,
        'enabled': enabled,
        'totalSize': totalSize,
        'usedSize': usedSize,
        'remainingSize': remainingSize,
        'createTimestamp': createTimestamp,
        'editTimestamp': editTimestamp,
        'lastFetchTimestamp': lastFetchTimestamp,
        'lastBackupTimestamp': lastBackupTimestamp,
        'lastFetchStatus': lastFetchStatus.index,
        'lastBackupStatus': lastBackupStatus.index,
        'params': jsonEncode(params),
      };

  factory BackupService.fromJson(Map<String, dynamic> map) => BackupService(
        id: map['id'] as int,
        endpoint: map['endpoint'] as String?,
        email: map['email'] as String?,
        account: map['account'] as String?,
        secret: map['secret'] as String?,
        token: map['token'] as String?,
        enabled: map['enabled'] as bool,
        totalSize: map['totalSize'] as int,
        usedSize: map['usedSize'] as int,
        remainingSize: map['remainingSize'] as int,
        createTimestamp: map['createTimestamp'] as int,
        editTimestamp: map['editTimestamp'] as int,
        lastFetchTimestamp: map['lastFetchTimestamp'] as int,
        lastBackupTimestamp: map['lastBackupTimestamp'] as int,
        lastFetchStatus: SyncStatus.values[map['lastFetchStatus'] as int],
        lastBackupStatus: SyncStatus.values[map['lastBackupStatus'] as int],
        params: jsonDecode(map['params'] as String),
      );
}
