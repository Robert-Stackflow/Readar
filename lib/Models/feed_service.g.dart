// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedService _$FeedServiceFromJson(Map<String, dynamic> json) => FeedService(
      json['endpoint'] as String,
      $enumDecode(_$FeedServiceTypeEnumMap, json['feedServiceType']),
      id: json['id'] as int?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      appId: json['appId'] as String?,
      appKey: json['appKey'] as String?,
      authorization: json['authorization'] as String?,
      fetchLimit: json['fetchLimit'] as int? ?? 500,
      pullOnStartUp: json['pullOnStartUp'] as bool? ?? false,
      lastSyncStatus:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['lastSyncStatus']),
      lastSyncTime: json['lastSyncTime'] == null
          ? null
          : DateTime.parse(json['lastSyncTime'] as String),
      lastedFetchedId: json['lastedFetchedId'] as String?,
      latestFetchedTime: json['latestFetchedTime'] == null
          ? null
          : DateTime.parse(json['latestFetchedTime'] as String),
      params: json['params'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$FeedServiceToJson(FeedService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'endpoint': instance.endpoint,
      'feedServiceType': _$FeedServiceTypeEnumMap[instance.feedServiceType]!,
      'username': instance.username,
      'password': instance.password,
      'appId': instance.appId,
      'appKey': instance.appKey,
      'authorization': instance.authorization,
      'fetchLimit': instance.fetchLimit,
      'pullOnStartUp': instance.pullOnStartUp,
      'lastSyncStatus': _$SyncStatusEnumMap[instance.lastSyncStatus],
      'lastSyncTime': instance.lastSyncTime?.toIso8601String(),
      'latestFetchedTime': instance.latestFetchedTime?.toIso8601String(),
      'lastedFetchedId': instance.lastedFetchedId,
      'params': instance.params,
    };

const _$FeedServiceTypeEnumMap = {
  FeedServiceType.Inoreader: 'Inoreader',
  FeedServiceType.Feedbin: 'Feedbin',
  FeedServiceType.FeedHQ: 'FeedHQ',
  FeedServiceType.TheOldReader: 'TheOldReader',
  FeedServiceType.BazQuxReader: 'BazQuxReader',
  FeedServiceType.FeedWrangler: 'FeedWrangler',
  FeedServiceType.NewsBlur: 'NewsBlur',
  FeedServiceType.FeverAPI: 'FeverAPI',
  FeedServiceType.FreshRssAPI: 'FreshRssAPI',
  FeedServiceType.GoogleReaderAPI: 'GoogleReaderAPI',
  FeedServiceType.Miniflux: 'Miniflux',
  FeedServiceType.NextcloudNewsAPI: 'NextcloudNewsAPI',
};

const _$SyncStatusEnumMap = {
  SyncStatus.unspecified: 'unspecified',
  SyncStatus.success: 'success',
  SyncStatus.fail: 'fail',
};
