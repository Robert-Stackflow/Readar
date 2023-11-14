// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extension_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtensionService _$ExtensionServiceFromJson(Map<String, dynamic> json) =>
    ExtensionService(
      json['endpoint'] as String,
      id: json['id'] as int,
      username: json['username'] as String?,
      password: json['password'] as String?,
      appId: json['appId'] as String?,
      appKey: json['appKey'] as String?,
      lastPullStatus:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['lastPullStatus']),
      lastPullTime: json['lastPullTime'] == null
          ? null
          : DateTime.parse(json['lastPullTime'] as String),
      articleCount: json['articleCount'] as int? ?? 0,
      params: json['params'] as String?,
    );

Map<String, dynamic> _$ExtensionServiceToJson(ExtensionService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'endpoint': instance.endpoint,
      'username': instance.username,
      'password': instance.password,
      'appId': instance.appId,
      'appKey': instance.appKey,
      'articleCount': instance.articleCount,
      'lastPullStatus': _$SyncStatusEnumMap[instance.lastPullStatus],
      'lastPullTime': instance.lastPullTime?.toIso8601String(),
      'params': instance.params,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.unspecified: 'unspecified',
  SyncStatus.success: 'success',
  SyncStatus.fail: 'fail',
};
