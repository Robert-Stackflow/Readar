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
  int createTime;
  int editTime;
  int lastFetchTime;
  int lastBackupTime;
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
    this.createTime = 0,
    this.editTime = 0,
    this.lastFetchTime = 0,
    this.lastBackupTime = 0,
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
    this.createTime,
    this.editTime,
    this.lastFetchTime,
    this.lastBackupTime,
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
      createTime,
      editTime,
      lastFetchTime,
      lastBackupTime,
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
        'createTime': createTime,
        'editTime': editTime,
        'lastFetchTime': lastFetchTime,
        'lastBackupTime': lastBackupTime,
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
        createTime: map['createTime'] as int,
        editTime: map['editTime'] as int,
        lastFetchTime: map['lastFetchTime'] as int,
        lastBackupTime: map['lastBackupTime'] as int,
        lastFetchStatus: SyncStatus.values[map['lastFetchStatus'] as int],
        lastBackupStatus: SyncStatus.values[map['lastBackupStatus'] as int],
        params: jsonDecode(map['params'] as String),
      );
}
