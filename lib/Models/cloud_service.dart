import 'package:json_annotation/json_annotation.dart';

import 'feed_setting.dart';

part 'cloud_service.g.dart';

///
/// Feed Service class
///
@JsonSerializable()
class CloudService {
  int id;
  String endpoint;
  String? username;
  String? password;
  String? appId;
  String? appKey;
  SyncStatus? lastPullStatus;
  DateTime? lastPullTime;
  SyncStatus? lastPushStatus;
  DateTime? lastPushTime;
  String? params;

  CloudService(
    this.endpoint, {
    required this.id,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.lastPullStatus,
    this.lastPullTime,
    this.lastPushStatus,
    this.lastPushTime,
    this.params,
  });

  CloudService._privateConstructor(
    this.id,
    this.endpoint,
    this.username,
    this.password,
    this.appId,
    this.appKey,
    this.lastPullStatus,
    this.lastPullTime,
    this.lastPushStatus,
    this.lastPushTime,
    this.params,
  );

  CloudService clone() {
    return CloudService._privateConstructor(
      id,
      endpoint,
      username,
      password,
      appId,
      appKey,
      lastPullStatus,
      lastPullTime,
      lastPushStatus,
      lastPushTime,
      params,
    );
  }

  Map<String, dynamic> toJson() => _$CloudServiceToJson(this);

  factory CloudService.fromJson(Map<String, dynamic> json) =>
      _$CloudServiceFromJson(json);
}
