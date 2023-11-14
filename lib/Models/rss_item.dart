import 'package:json_annotation/json_annotation.dart';

part 'rss_item.g.dart';

///
/// RSS item class, including title, original link, release date, article content, snippets and other elements
///
@JsonSerializable()
class RSSItem {
  String id;
  int feedId;
  String feedSid;
  String title;
  String url;
  DateTime date;
  String content;
  String snippet;
  String? creator;
  String? thumb;
  bool hasRead;
  bool starred;
  DateTime? readTime;
  DateTime? starTime;
  String? params;

  RSSItem({
    required this.id,
    required this.feedId,
    required this.feedSid,
    required this.title,
    required this.url,
    required this.date,
    required this.content,
    required this.snippet,
    this.creator,
    this.thumb,
    this.hasRead = false,
    this.starred = false,
    this.readTime,
    this.starTime,
    this.params,
  });

  RSSItem._privateConstructor(
    this.id,
    this.feedId,
    this.feedSid,
    this.title,
    this.url,
    this.date,
    this.content,
    this.snippet,
    this.creator,
    this.thumb,
    this.hasRead,
    this.starred,
    this.readTime,
    this.starTime,
    this.params,
  );

  RSSItem clone() {
    return RSSItem._privateConstructor(
      id,
      feedId,
      feedSid,
      title,
      url,
      date,
      content,
      snippet,
      creator,
      thumb,
      hasRead,
      starred,
      readTime,
      starTime,
      params,
    );
  }

  Map<String, dynamic> toJson() => _$RSSItemToJson(this);

  factory RSSItem.fromJson(Map<String, dynamic> json) =>
      _$RSSItemFromJson(json);
}
