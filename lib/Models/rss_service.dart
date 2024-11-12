import 'dart:convert';

import 'feed_setting.dart';
import '../Utils/utils.dart';

///
/// Rss服务类型
///
enum RssServiceType {
  local("Local", []),
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
  int id;
  String uid;
  String endpoint;
  String name;
  RssServiceType rssServiceType;
  String? username;
  String? password;
  String? appId;
  String? appKey;
  String? authorization;
  int fetchLimit;
  bool pullOnStartUp;
  SyncStatus lastSyncStatus;
  int lastSyncTime;
  int latestFetchTime;
  String? latestFetchId;
  int createTime;
  Map<String, dynamic> params;

  RssService(
    this.uid,
    this.endpoint,
    this.name,
    this.rssServiceType, {
    this.id = 0,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.authorization,
    this.fetchLimit = 500,
    this.pullOnStartUp = true,
    this.lastSyncStatus = SyncStatus.unspecified,
    this.lastSyncTime = 0,
    this.latestFetchId,
    this.latestFetchTime = 0,
    required this.createTime,
    this.params = const {},
  });

  RssService.local()
      : id = 0,
        endpoint = "",
        name = "",
        uid = Utils.generateUid(),
        rssServiceType = RssServiceType.local,
        username = null,
        password = null,
        appId = null,
        appKey = null,
        authorization = null,
        fetchLimit = 500,
        pullOnStartUp = true,
        lastSyncStatus = SyncStatus.unspecified,
        lastSyncTime = 0,
        latestFetchId = null,
        latestFetchTime = 0,
        createTime = DateTime.now().millisecondsSinceEpoch,
        params = {};

  RssService._privateConstructor(
    this.id,
    this.uid,
    this.endpoint,
    this.name,
    this.rssServiceType,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.authorization,
    this.fetchLimit,
    this.pullOnStartUp,
    this.lastSyncStatus,
    this.lastSyncTime,
    this.latestFetchId,
    this.latestFetchTime,
    this.params,
    this.createTime,
  );

  RssService clone() {
    return RssService._privateConstructor(
      id,
      uid,
      endpoint,
      name,
      rssServiceType,
      username,
      password,
      appId,
      appKey,
      authorization,
      fetchLimit,
      pullOnStartUp,
      lastSyncStatus,
      lastSyncTime,
      latestFetchId,
      latestFetchTime,
      params,
      createTime,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'uid': uid,
        'endpoint': endpoint,
        'name': name,
        'rssServiceType': rssServiceType.index,
        'username': username,
        'password': password,
        'appId': appId,
        'appKey': appKey,
        'authorization': authorization,
        'fetchLimit': fetchLimit,
        'pullOnStartUp': pullOnStartUp ? 1 : 0,
        'lastSyncStatus': lastSyncStatus.index,
        'lastSyncTime': lastSyncTime,
        'latestFetchId': latestFetchId,
        'latestFetchTime': latestFetchTime,
        'params': jsonEncode(params),
        'createTime': createTime,
      };

  factory RssService.fromJson(Map<String, dynamic> map) => RssService(
        map['uid'],
        map['endpoint'],
        map['name'],
        RssServiceType.values[map['rssServiceType']],
        id: map['id'],
        username: map['username'],
        password: map['password'],
        appId: map['appId'],
        appKey: map['appKey'],
        authorization: map['authorization'],
        fetchLimit: map['fetchLimit'],
        pullOnStartUp: map['pullOnStartUp'] == 1,
        lastSyncStatus: SyncStatus.values[map['lastSyncStatus']],
        lastSyncTime: map['lastSyncTime'],
        latestFetchId: map['latestFetchId'],
        latestFetchTime: map['latestFetchTime'],
        params: jsonDecode(map['params']),
        createTime: map['createTime'],
      );
}
