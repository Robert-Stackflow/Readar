import 'package:json_annotation/json_annotation.dart';

import 'feed_setting.dart';

part 'feed_service.g.dart';

enum FeedServiceType {
  Inoreader("Inoreader", [
    "https://www.inoreader.com",
    "https://www.innoreader.com",
    "https://jp.inoreader.com",
  ]),
  Feedbin("Feedbin", [
    "https://api.feedbin.me/v2",
    "https://api.feedbin.com/v2",
  ]),
  FeedHQ("FeedHQ", [""]),
  TheOldReader("TheOldReader", ["https://theoldreader.com"]),
  BazQuxReader("BazQuxReader", ["https://bazqux.com"]),
  FeedWrangler("FeedWrangler", [""]),
  NewsBlur("NewsBlur", [""]),
  FeverAPI("FeverAPI", [""]),
  FreshRssAPI("FreshRssAPI", [""]),
  GoogleReaderAPI("GoogleReaderAPI", [""]),
  Miniflux("Miniflux", [""]),
  NextcloudNewsAPI("NextcloudNewsAPI", [""]);

  const FeedServiceType(this.name, this.endpoint);

  final String name;
  final List<String> endpoint;
}

///
/// Feed Service class
///
@JsonSerializable()
class FeedService {
  int? id;
  String endpoint;
  FeedServiceType feedServiceType;
  String? username;
  String? password;
  String? appId;
  String? appKey;
  String? authorization;
  int fetchLimit;
  bool pullOnStartUp;
  SyncStatus? lastSyncStatus;
  DateTime? lastSyncTime;
  DateTime? latestFetchedTime;
  String? lastedFetchedId;
  Map<String, Object?>? params;

  FeedService(
    this.endpoint,
    this.feedServiceType, {
    this.id,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.authorization,
    this.fetchLimit = 500,
    this.pullOnStartUp = false,
    this.lastSyncStatus,
    this.lastSyncTime,
    this.lastedFetchedId,
    this.latestFetchedTime,
    this.params,
  });

  FeedService._privateConstructor(
    this.id,
    this.endpoint,
    this.feedServiceType,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.authorization,
    this.fetchLimit,
    this.pullOnStartUp,
    this.lastSyncStatus,
    this.lastSyncTime,
    this.lastedFetchedId,
    this.latestFetchedTime,
    this.params,
  );

  FeedService clone() {
    return FeedService._privateConstructor(
      id,
      endpoint,
      feedServiceType,
      username,
      password,
      appId,
      appKey,
      authorization,
      fetchLimit,
      pullOnStartUp,
      lastSyncStatus,
      lastSyncTime,
      lastedFetchedId,
      latestFetchedTime,
      params,
    );
  }

  Map<String, dynamic> toJson() => _$FeedServiceToJson(this);

  factory FeedService.fromJson(Map<String, dynamic> json) =>
      _$FeedServiceFromJson(json);
}
