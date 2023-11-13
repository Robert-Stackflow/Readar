import 'package:json_annotation/json_annotation.dart';

part 'rss_item.g.dart';

///
/// RSS item class, including title, original link, release date, article content, snippets and other elements
///
@JsonSerializable()
class RSSItem {
  String id;
  String source;
  String title;
  String link;
  DateTime date;
  String content;
  String snippet;
  bool hasRead;
  bool starred;
  String? creator; // Optional
  String? thumb; // Optional

  RSSItem({
    required this.id,
    required this.source,
    required this.title,
    required this.link,
    required this.date,
    required this.content,
    required this.snippet,
    this.hasRead = false,
    this.starred = false,
    this.creator,
    this.thumb,
  });

  RSSItem clone() {
    return RSSItem(
      id: id,
      source: source,
      title: title,
      link: link,
      date: date,
      content: content,
      snippet: snippet,
      hasRead: hasRead,
      starred: starred,
      creator: creator,
      thumb: thumb,
    );
  }

  Map<String, dynamic> toJson() => _$RSSItemToJson(this);

  factory RSSItem.fromJson(Map<String, dynamic> json) =>
      _$RSSItemFromJson(json);
}
