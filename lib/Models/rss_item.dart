import 'dart:convert';

///
/// RSS文章条目
///
class RssItem {
  String iid;
  int feedId;
  String feedFid;
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
  Map<String, Object?>? params;

  RssItem({
    required this.iid,
    required this.feedId,
    required this.feedFid,
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

  RssItem._privateConstructor(
    this.iid,
    this.feedId,
    this.feedFid,
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

  RssItem clone() {
    return RssItem._privateConstructor(
      iid,
      feedId,
      feedFid,
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'iid': iid,
        'feedId': feedId,
        'feedFid': feedFid,
        'title': title,
        'url': url,
        'date': date.millisecondsSinceEpoch,
        'content': content,
        'snippet': snippet,
        'creator': creator,
        'thumb': thumb,
        'hasRead': hasRead ? 1 : 0,
        'starred': starred ? 1 : 0,
        'readTime': readTime?.millisecondsSinceEpoch,
        'starTime': starTime?.millisecondsSinceEpoch,
        'params': jsonEncode(params),
      };

  factory RssItem.fromJson(Map<String, dynamic> map) => RssItem(
        iid: map['iid'] as String,
        feedId: map['feedId'] as int,
        feedFid: map['feedFid'] as String,
        title: map['title'] as String,
        url: map['url'] as String,
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        content: map['content'] as String,
        snippet: map['snippet'] as String,
        creator: map['creator'] as String?,
        thumb: map['thumb'] as String?,
        hasRead: map['hasRead'] == 0 ? false : true,
        starred: map['starred'] == 0 ? false : true,
        readTime: map['readTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['readTime']),
        starTime: map['starTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['starTime']),
        params: jsonDecode(map['params']),
      );
}
