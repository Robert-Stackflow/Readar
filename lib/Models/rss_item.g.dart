// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rss_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RSSItem _$RSSItemFromJson(Map<String, dynamic> json) => RSSItem(
      id: json['id'] as String,
      feedId: json['feedId'] as int,
      feedSid: json['feedSid'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      date: DateTime.parse(json['date'] as String),
      content: json['content'] as String,
      snippet: json['snippet'] as String,
      creator: json['creator'] as String?,
      thumb: json['thumb'] as String?,
      hasRead: json['hasRead'] as bool? ?? false,
      starred: json['starred'] as bool? ?? false,
      readTime: json['readTime'] == null
          ? null
          : DateTime.parse(json['readTime'] as String),
      starTime: json['starTime'] == null
          ? null
          : DateTime.parse(json['starTime'] as String),
      params: json['params'] as String?,
    );

Map<String, dynamic> _$RSSItemToJson(RSSItem instance) => <String, dynamic>{
      'id': instance.id,
      'feedId': instance.feedId,
      'feedSid': instance.feedSid,
      'title': instance.title,
      'url': instance.url,
      'date': instance.date.toIso8601String(),
      'content': instance.content,
      'snippet': instance.snippet,
      'creator': instance.creator,
      'thumb': instance.thumb,
      'hasRead': instance.hasRead,
      'starred': instance.starred,
      'readTime': instance.readTime?.toIso8601String(),
      'starTime': instance.starTime?.toIso8601String(),
      'params': instance.params,
    };
