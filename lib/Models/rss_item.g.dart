// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rss_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RSSItem _$RSSItemFromJson(Map<String, dynamic> json) => RSSItem(
      id: json['id'] as String,
      source: json['source'] as String,
      title: json['title'] as String,
      link: json['link'] as String,
      date: DateTime.parse(json['date'] as String),
      content: json['content'] as String,
      snippet: json['snippet'] as String,
      hasRead: json['hasRead'] as bool? ?? false,
      starred: json['starred'] as bool? ?? false,
      creator: json['creator'] as String?,
      thumb: json['thumb'] as String?,
    );

Map<String, dynamic> _$RSSItemToJson(RSSItem instance) => <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'title': instance.title,
      'link': instance.link,
      'date': instance.date.toIso8601String(),
      'content': instance.content,
      'snippet': instance.snippet,
      'hasRead': instance.hasRead,
      'starred': instance.starred,
      'creator': instance.creator,
      'thumb': instance.thumb,
    };
