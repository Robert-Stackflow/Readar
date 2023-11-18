import 'dart:convert';

import 'feed_setting.dart';

///
/// 云盘备份服务
///
class BackupService {
  int id;
  String endpoint;
  String? username;
  String? password;
  String? appId;
  String? appKey;
  SyncStatus? lastPullStatus;
  DateTime? lastPullTime;
  SyncStatus? lastPushStatus;
  DateTime? lastPushTime;
  Map<String, Object?>? params;

  BackupService(
    this.endpoint, {
    required this.id,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.lastPullStatus,
    this.lastPullTime,
    this.lastPushStatus,
    this.lastPushTime,
    this.params,
  });

  BackupService._privateConstructor(
    this.id,
    this.endpoint,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.lastPullStatus,
    this.lastPullTime,
    this.lastPushStatus,
    this.lastPushTime,
    this.params,
  );

  BackupService clone() {
    return BackupService._privateConstructor(
      id,
      endpoint,
      username,
      password,
      appId,
      appKey,
      lastPullStatus,
      lastPullTime,
      lastPushStatus,
      lastPushTime,
      params,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'endpoint': endpoint,
        'username': username,
        'password': password,
        'appId': appId,
        'appKey': appKey,
        'lastPullStatus': lastPullStatus?.index,
        'lastPullTime': lastPullTime?.millisecondsSinceEpoch,
        'lastPushStatus': lastPullStatus?.index,
        'lastPushTime': lastPushTime?.millisecondsSinceEpoch,
        'params': jsonEncode(params),
      };

  factory BackupService.fromJson(Map<String, dynamic> map) => BackupService(
        map['endpoint'] as String,
        id: map['id'] as int,
        username: map['username'] as String?,
        password: map['password'] as String?,
        appId: map['appId'] as String?,
        appKey: map['appKey'] as String?,
        lastPullStatus: map['lastPullStatus'] == null
            ? null
            : SyncStatus.values[map['lastPullStatus']],
        lastPullTime: map['lastPullTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['lastPullTime']),
        lastPushStatus: map['lastPushStatus'] == null
            ? null
            : SyncStatus.values[map['lastPushStatus']],
        lastPushTime: map['lastPushTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['lastPushTime']),
        params: jsonDecode(map['params']),
      );
}
