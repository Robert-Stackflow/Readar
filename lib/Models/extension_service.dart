import 'dart:convert';

import 'feed_setting.dart';

///
/// 插件服务
///
class ExtensionService {
  int id;
  String endpoint;
  String? username;
  String? password;
  String? appId;
  String? appKey;
  int articleCount;
  int lastPullTime;
  SyncStatus lastPullStatus;
  Map<String, dynamic> params;

  ExtensionService(
    this.endpoint, {
    required this.id,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.lastPullStatus = SyncStatus.unspecified,
    this.lastPullTime = 0,
    this.articleCount = 0,
    this.params = const {},
  });

  ExtensionService._privateConstructor(
    this.id,
    this.endpoint,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.lastPullStatus,
    this.lastPullTime,
    this.articleCount,
    this.params,
  );

  ExtensionService clone() {
    return ExtensionService._privateConstructor(
      id,
      endpoint,
      username,
      password,
      appId,
      appKey,
      lastPullStatus,
      lastPullTime,
      articleCount,
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
        'articleCount': articleCount,
        'lastPullStatus': lastPullStatus.index,
        'lastPullTime': lastPullTime,
        'params': jsonEncode(params),
      };

  factory ExtensionService.fromJson(Map<String, dynamic> map) =>
      ExtensionService(
        map['endpoint'] as String,
        id: map['id'] as int,
        username: map['username'] as String?,
        password: map['password'] as String?,
        appId: map['appId'] as String?,
        appKey: map['appKey'] as String?,
        lastPullStatus: SyncStatus.values[map['lastPullStatus'] as int],
        lastPullTime: map['lastPullTime'] as int? ?? 0,
        articleCount: map['articleCount'] as int? ?? 0,
        params: jsonDecode(map['params']),
      );
}
