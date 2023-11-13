// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feed _$FeedFromJson(Map<String, dynamic> json) => Feed(
      json['sid'] as String,
      json['url'] as String,
      json['name'] as String,
      id: json['id'] as int,
      serviceId: json['serviceId'] as int,
      feedSetting: json['feedSetting'] == null
          ? null
          : FeedSetting.fromJson(json['feedSetting'] as Map<String, dynamic>),
      lastPullTime: json['lastPullTime'] == null
          ? null
          : DateTime.parse(json['lastPullTime'] as String),
      lastPullStatus:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['lastPullStatus']),
      iconUrl: json['iconUrl'] as String?,
      latestArticleTime: json['latestArticleTime'] == null
          ? null
          : DateTime.parse(json['latestArticleTime'] as String),
      latestArticleTitle: json['latestArticleTitle'] as String?,
      params: json['params'] as String?,
    );

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
      'id': instance.id,
      'serviceId': instance.serviceId,
      'sid': instance.sid,
      'url': instance.url,
      'iconUrl': instance.iconUrl,
      'name': instance.name,
      'feedSetting': instance.feedSetting,
      'lastPullStatus': _$SyncStatusEnumMap[instance.lastPullStatus],
      'lastPullTime': instance.lastPullTime?.toIso8601String(),
      'latestArticleTime': instance.latestArticleTime?.toIso8601String(),
      'latestArticleTitle': instance.latestArticleTitle,
      'params': instance.params,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.unspecified: 'unspecified',
  SyncStatus.success: 'success',
  SyncStatus.fail: 'fail',
};
