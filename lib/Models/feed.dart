import 'dart:convert';

import 'package:readar/Models/filter_rule.dart';

import 'feed_setting.dart';

///
/// 订阅源
///
class FeedModel {
  int? id;
  String uid; // feed id
  String serviceUid; // RSS service id
  String url; // feed url
  String? iconUrl; // feed icon url
  String name; // feed name
  int unReadCount; // unread count
  FeedSetting? feedSetting; // feed setting
  SyncStatus lastFetchStatus; // last fetch status
  int lastFetchTime; // last fetch time
  int latestArticleTime; // latest article time
  int createTime;
  String? latestArticleTitle; // latest article title
  List<FilterRule> filterRules;
  Map<String, dynamic> params;

  FeedModel(
    this.uid,
    this.url,
    this.name, {
    this.id = 0,
    required this.serviceUid,
    this.unReadCount = 0,
    this.feedSetting,
    this.lastFetchTime = 0,
    this.lastFetchStatus = SyncStatus.unspecified,
    this.iconUrl,
    this.latestArticleTime = 0,
    this.createTime = 0,
    this.latestArticleTitle = "",
    this.params = const {},
    this.filterRules = const [],
  });

  FeedModel._privateConstructor(
    this.id,
    this.serviceUid,
    this.uid,
    this.url,
    this.iconUrl,
    this.name,
    this.unReadCount,
    this.latestArticleTime,
    this.latestArticleTitle,
    this.lastFetchStatus,
    this.lastFetchTime,
    this.feedSetting,
    this.params,
    this.filterRules,
    this.createTime,
  );

  FeedModel clone() {
    return FeedModel._privateConstructor(
        id,
        serviceUid,
        uid,
        url,
        iconUrl,
        name,
        unReadCount,
        latestArticleTime,
        latestArticleTitle,
        lastFetchStatus,
        lastFetchTime,
        feedSetting,
        params,
        filterRules,
        createTime);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'serviceUid': serviceUid,
        'uid': uid,
        'url': url,
        'iconUrl': iconUrl,
        'name': name,
        'unReadCount': unReadCount,
        'latestArticleTime': latestArticleTime,
        'latestArticleTitle': latestArticleTitle,
        'lastFetchStatus': lastFetchStatus.index,
        'lastFetchTime': lastFetchTime,
        'feedSetting': feedSetting?.toJson(),
        'params': jsonEncode(params),
        'filterRules': jsonEncode(filterRules),
        'createTime': createTime,
      };

  factory FeedModel.fromJson(Map<String, dynamic> map) => FeedModel(
        map['uid'] as String,
        map['url'] as String,
        map['name'] as String,
        id: map['id'] as int,
        serviceUid: map['serviceUid'] as String,
        iconUrl: map['iconUrl'] as String?,
        unReadCount: map['unReadCount'] as int,
        latestArticleTime: map['latestArticleTime'] as int,
        latestArticleTitle: map['latestArticleTitle'] as String?,
        lastFetchStatus: SyncStatus.values[map['lastFetchStatus'] as int],
        lastFetchTime: map['lastFetchTime'] as int,
        feedSetting: map['feedSetting'] == null
            ? null
            : FeedSetting.fromJson(map['feedSetting'] as Map<String, dynamic>),
        params: jsonDecode(map['params'] as String),
        filterRules: (jsonDecode(map['filterRules'] as String) as List)
            .map((e) => FilterRule.fromJson(e))
            .toList(),
        createTime: map['createTime'] as int,
      );
}
