import 'package:json_annotation/json_annotation.dart';

import 'feed_setting.dart';

part 'feed.g.dart';

///
/// Feed class, including ID, link, icon, name and other elements
///
@JsonSerializable()
class Feed {
  int id;
  int serviceId;
  String sid;
  String url;
  String? iconUrl;
  String name;
  FeedSetting? feedSetting;
  SyncStatus? lastPullStatus;
  DateTime? lastPullTime;
  DateTime? latestArticleTime;
  String? latestArticleTitle;
  String? params;

  Feed(
    this.sid,
    this.url,
    this.name, {
    required this.id,
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
    this.sid,
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
      sid,
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

  Map<String, dynamic> toJson() => _$FeedToJson(this);

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
}
