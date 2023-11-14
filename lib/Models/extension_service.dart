import 'package:json_annotation/json_annotation.dart';

import 'feed_setting.dart';

part 'extension_service.g.dart';

///
/// Feed Service class
///
@JsonSerializable()
class ExtensionService {
  int id;
  String endpoint;
  String? username;
  String? password;
  String? appId;
  String? appKey;
  int articleCount;
  SyncStatus? lastPullStatus;
  DateTime? lastPullTime;
  String? params;

  ExtensionService(
    this.endpoint, {
    required this.id,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.lastPullStatus,
    this.lastPullTime,
    this.articleCount = 0,
    this.params,
  });

  ExtensionService._privateConstructor(
    this.id,
    this.endpoint,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.lastPullStatus,
    this.lastPullTime,
    this.articleCount,
    this.params,
  );

  ExtensionService clone() {
    return ExtensionService._privateConstructor(
      id,
      endpoint,
      username,
      password,
      appId,
      appKey,
      lastPullStatus,
      lastPullTime,
      articleCount,
      params,
    );
  }

  Map<String, dynamic> toJson() => _$ExtensionServiceToJson(this);

  factory ExtensionService.fromJson(Map<String, dynamic> json) =>
      _$ExtensionServiceFromJson(json);
}
