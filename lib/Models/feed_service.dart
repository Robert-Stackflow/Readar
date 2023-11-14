import 'dart:convert';

import 'feed_setting.dart';

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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'endpoint': endpoint,
        'feedServiceType': feedServiceType.index,
        'username': username,
        'password': password,
        'appId': appId,
        'appKey': appKey,
        'authorization': authorization,
        'fetchLimit': fetchLimit,
        'pullOnStartUp': pullOnStartUp ? 1 : 0,
        'lastSyncStatus': lastSyncStatus?.index,
        'lastSyncTime': lastSyncTime?.millisecondsSinceEpoch,
        'latestFetchedTime': latestFetchedTime?.millisecondsSinceEpoch,
        'lastedFetchedId': lastedFetchedId,
        'params': jsonEncode(params),
      };

  factory FeedService.fromJson(Map<String, dynamic> map) => FeedService(
        map['endpoint'] as String,
        FeedServiceType.values[map['feedServiceType']],
        id: map['id'] as int?,
        username: map['username'] as String?,
        password: map['password'] as String?,
        appId: map['appId'] as String?,
        appKey: map['appKey'] as String?,
        authorization: map['authorization'] as String?,
        fetchLimit: map['fetchLimit'] as int? ?? 500,
        pullOnStartUp: map['pullOnStartUp'] == 0 ? false : true,
        lastSyncStatus: map['lastSyncStatus'] == null
            ? null
            : SyncStatus.values[map['lastSyncStatus']],
        lastSyncTime: map['lastSyncTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['lastSyncTime']),
        lastedFetchedId: map['lastedFetchedId'] as String?,
        latestFetchedTime: map['latestFetchedTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['latestFetchedTime']),
        params: jsonDecode(map['params']),
      );
}
