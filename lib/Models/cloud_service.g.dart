// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloudService _$CloudServiceFromJson(Map<String, dynamic> json) => CloudService(
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
      lastPushStatus:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['lastPushStatus']),
      lastPushTime: json['lastPushTime'] == null
          ? null
          : DateTime.parse(json['lastPushTime'] as String),
      params: json['params'] as String?,
    );

Map<String, dynamic> _$CloudServiceToJson(CloudService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'endpoint': instance.endpoint,
      'username': instance.username,
      'password': instance.password,
      'appId': instance.appId,
      'appKey': instance.appKey,
      'lastPullStatus': _$SyncStatusEnumMap[instance.lastPullStatus],
      'lastPullTime': instance.lastPullTime?.toIso8601String(),
      'lastPushStatus': _$SyncStatusEnumMap[instance.lastPushStatus],
      'lastPushTime': instance.lastPushTime?.toIso8601String(),
      'params': instance.params,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.unspecified: 'unspecified',
  SyncStatus.success: 'success',
  SyncStatus.fail: 'fail',
};
