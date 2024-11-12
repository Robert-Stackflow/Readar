import 'dart:convert';

///
/// RSS文章条目
///
class ArticleItem {
  int id;
  String uid;
  String feedUid;
  String title;
  String url;
  int publishTime;
  String content;
  String snippet;
  String aiSummary;
  String? creator;
  String? thumb;
  bool read;
  bool starred;
  bool hide; // 是否隐藏
  int readTime;
  int starTime;
  int readDuration; // 阅读时长，以秒为单位
  int aiSummaryTime; // AI摘要生成时间
  Map<String, dynamic> params;

  ArticleItem({
    required this.id,
    required this.feedId,
    required this.feedUid,
    required this.title,
    this.aiSummary = "",
    required this.url,
    required this.publishTime,
    required this.content,
    required this.snippet,
    this.creator,
    this.thumb,
    this.read = false,
    this.starred = false,
    this.hide = false,
    this.readTime = 0,
    this.starTime = 0,
    this.readDuration = 0,
    this.aiSummaryTime = 0,
    this.params = const {},
  });

  ArticleItem._privateConstructor(
    this.id,
    this.feedId,
    this.feedUid,
    this.title,
    this.url,
    this.publishTime,
    this.content,
    this.snippet,
    this.creator,
    this.thumb,
    this.read,
    this.hide,
    this.starred,
    this.readTime,
    this.starTime,
    this.params,
    this.aiSummary,
    this.readDuration,
    this.aiSummaryTime,
  );

  ArticleItem clone() {
    return ArticleItem._privateConstructor(
      id,
      feedId,
      feedUid,
      title,
      url,
      publishTime,
      content,
      snippet,
      creator,
      thumb,
      read,
      hide,
      starred,
      readTime,
      starTime,
      params,
      aiSummary,
      readDuration,
      aiSummaryTime,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'feedId': feedId,
        'feedFid': feedUid,
        'title': title,
        'url': url,
        'date': publishTime,
        'content': content,
        'snippet': snippet,
        'creator': creator,
        'thumb': thumb,
        'hasRead': read ? 1 : 0,
        'starred': starred ? 1 : 0,
        'readTime': readTime,
        'starTime': starTime,
        'params': jsonEncode(params),
        'aiDigest': aiSummary,
        'readDuration': readDuration,
        'hide': hide ? 1 : 0,
        'aiSummaryTime': aiSummaryTime,
      };

  factory ArticleItem.fromJson(Map<String, dynamic> map) => ArticleItem(
        id: map['id'] as String,
        feedId: map['feedId'] as int,
        feedUid: map['feedFid'] as String,
        title: map['title'] as String,
        url: map['url'] as String,
        publishTime: map['date'] as int,
        content: map['content'] as String,
        snippet: map['snippet'] as String,
        creator: map['creator'] as String?,
        thumb: map['thumb'] as String?,
        read: map['hasRead'] == 1,
        starred: map['starred'] == 1,
        readTime: map['readTime'] as int,
        starTime: map['starTime'] as int,
        params: jsonDecode(map['params'] as String),
        aiSummary: map['aiDigest'] as String,
        readDuration: map['readDuration'] as int,
        hide: map['hide'] == 1,
        aiSummaryTime: map['aiSummaryTime'] as int,
      );
}
