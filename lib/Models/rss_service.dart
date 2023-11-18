import 'dart:convert';

import 'feed_setting.dart';

///
/// Rss服务类型
///
enum RssServiceType {
  inoreader("Inoreader", [
    "https://www.inoreader.com",
    "https://www.innoreader.com",
    "https://jp.inoreader.com",
  ]),
  feedbin("Feedbin", [
    "https://api.feedbin.me/v2",
    "https://api.feedbin.com/v2",
  ]),
  feedHQ("FeedHQ", [""]),
  theOldReader("TheOldReader", ["https://theoldreader.com"]),
  bazQuxReader("BazQuxReader", ["https://bazqux.com"]),
  feedWrangler("FeedWrangler", [""]),
  newsBlur("NewsBlur", [""]),
  feverAPI("FeverAPI", [""]),
  freshRssAPI("FreshRssAPI", [""]),
  googleReaderAPI("GoogleReaderAPI", [""]),
  miniflux("Miniflux", [""]),
  nextcloudNewsAPI("NextcloudNewsAPI", [""]);

  const RssServiceType(this.name, this.endpoint);

  final String name;
  final List<String> endpoint;
}

///
/// Rss服务
///
class RssService {
  int? id;
  String endpoint;
  String name;
  RssServiceType feedServiceType;
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

  RssService(
    this.endpoint,
    this.name,
    this.feedServiceType, {
    this.id,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.authorization,
    this.fetchLimit = 500,
    this.pullOnStartUp = true,
    this.lastSyncStatus,
    this.lastSyncTime,
    this.lastedFetchedId,
    this.latestFetchedTime,
    this.params,
  });

  RssService._privateConstructor(
    this.id,
    this.endpoint,
    this.name,
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

  RssService clone() {
    return RssService._privateConstructor(
      id,
      endpoint,
      name,
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
        "name": name,
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

  factory RssService.fromJson(Map<String, dynamic> map) => RssService(
        map['endpoint'] as String,
        map['name'] as String,
        RssServiceType.values[map['feedServiceType']],
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
