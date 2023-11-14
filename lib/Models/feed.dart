import 'dart:convert';

import 'feed_setting.dart';

///
/// Feed class, including ID, link, icon, name and other elements
///
class Feed {
  int? id;
  int serviceId;
  String fid;
  String url;
  String? iconUrl;
  String name;
  FeedSetting? feedSetting;
  SyncStatus? lastPullStatus;
  DateTime? lastPullTime;
  DateTime? latestArticleTime;
  String? latestArticleTitle;
  Map<String, Object?>? params;

  Feed(
    this.fid,
    this.url,
    this.name, {
    this.id,
    required this.serviceId,
    this.feedSetting,
    this.lastPullTime,
    this.lastPullStatus,
    this.iconUrl,
    this.latestArticleTime,
    this.latestArticleTitle,
    this.params,
  }) {
    latestArticleTime = DateTime.now();
    latestArticleTitle = "";
  }

  Feed._privateConstructor(
    this.id,
    this.serviceId,
    this.fid,
    this.url,
    this.iconUrl,
    this.name,
    this.latestArticleTime,
    this.latestArticleTitle,
    this.lastPullStatus,
    this.lastPullTime,
    this.feedSetting,
    this.params,
  );

  Feed clone() {
    return Feed._privateConstructor(
      id,
      serviceId,
      fid,
      url,
      iconUrl,
      name,
      latestArticleTime,
      latestArticleTitle,
      lastPullStatus,
      lastPullTime,
      feedSetting,
      params,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'serviceId': serviceId,
        'fid': fid,
        'url': url,
        'iconUrl': iconUrl,
        'name': name,
        'feedSetting':
            feedSetting != null ? jsonEncode(feedSetting!.toJson()) : null,
        'lastPullStatus': lastPullStatus?.index,
        'lastPullTime': lastPullTime?.millisecondsSinceEpoch,
        'latestArticleTime': latestArticleTime?.millisecondsSinceEpoch,
        'latestArticleTitle': latestArticleTitle,
        'params': jsonEncode(params),
      };

  factory Feed.fromJson(Map<String, dynamic> map) => Feed(
        map['fid'] as String,
        map['url'] as String,
        map['name'] as String,
        id: map['id'] as int,
        serviceId: map['serviceId'] as int,
        feedSetting: map['feedSetting'] == null
            ? null
            : FeedSetting.fromJson(jsonDecode(map['feedSetting'])),
        lastPullTime: map['lastPullTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['lastPullTime']),
        lastPullStatus: map['lastPullStatus'] == null
            ? null
            : SyncStatus.values[map['lastPullStatus']],
        iconUrl: map['iconUrl'] as String?,
        latestArticleTime: map['latestArticleTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['latestArticleTime']),
        latestArticleTitle: map['latestArticleTitle'] as String?,
        params: jsonDecode(map['params']),
      );
}
