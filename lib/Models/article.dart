import 'dart:convert';

import 'package:rss_dart/dart_rss.dart';
import 'package:rss_dart/domain/rss1_item.dart';

import '../Utils/utils.dart';

///
/// RSS文章条目
///
class Article {
  int? id;
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

  Article({
    required this.id,
    required this.uid,
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

  Article._privateConstructor(
    this.id,
    this.uid,
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

  Article clone() {
    return Article._privateConstructor(
      id,
      uid,
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
        'uid': uid,
        'feedUid': feedUid,
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

  factory Article.fromJson(Map<String, dynamic> map) => Article(
        id: map['id'] as int,
        uid: map['uid'] as String,
        feedUid: map['feedUid'] as String,
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
        readDuration: map['readDuration'] as int,
        aiSummary: map['aiDigest'] as String,
        aiSummaryTime: map['aiSummaryTime'] as int,
        hide: map['hide'] == 1,
        params: jsonDecode(map['params'] as String),
      );

  @override
  String toString() {
    return 'Article{id: $id, uid: $uid, feedUid: $feedUid, title: $title, url: $url, publishTime: $publishTime, content: $content, snippet: $snippet, aiSummary: $aiSummary, creator: $creator, thumb: $thumb, read: $read, starred: $starred, hide: $hide, readTime: $readTime, starTime: $starTime, readDuration: $readDuration, aiSummaryTime: $aiSummaryTime, params: $params}';
  }
}

extension RssItemToArticle on RssItem {
  Article get article {
    return Article(
      id: null,
      uid: guid ?? Utils.generateUid(),
      feedUid: "",
      title: title ?? "",
      url: link ?? "",
      publishTime: Utils.parseDateTime(pubDate)?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      content: content?.value ?? "",
      snippet: description ?? "",
      creator: author,
      thumb: content?.images.isNotEmpty == true ? content!.images.first : "",
      read: false,
      starred: false,
      hide: false,
      readTime: 0,
      starTime: 0,
      readDuration: 0,
      aiSummary: "",
      aiSummaryTime: 0,
      params: {},
    );
  }
}

extension Rss1ItemToArticle on Rss1Item {
  Article get article {
    return Article(
      id: null,
      uid: Utils.generateUid(),
      feedUid: "",
      title: title ?? "",
      url: link ?? "",
      publishTime: DateTime.now().millisecondsSinceEpoch,
      content: content?.value ?? "",
      snippet: description ?? "",
      thumb: content?.images.isNotEmpty == true ? content!.images.first : "",
      read: false,
      starred: false,
      hide: false,
      readTime: 0,
      starTime: 0,
      readDuration: 0,
      aiSummary: "",
      aiSummaryTime: 0,
      params: {},
    );
  }
}

extension AtomItemToArticle on AtomItem {
  Article get article {
    return Article(
      id: null,
      uid: id ?? Utils.generateUid(),
      feedUid: "",
      title: title ?? "",
      url: links.isNotEmpty ? links[0].href ?? "" : "",
      publishTime: Utils.parseDateTime(updated)?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      content: content ?? "",
      snippet: summary ?? "",
      creator: authors.isNotEmpty ? authors[0].name : "",
      thumb: media?.thumbnails.isNotEmpty == true ? media!.thumbnails.first.url : "",
      read: false,
      starred: false,
      hide: false,
      readTime: 0,
      starTime: 0,
      readDuration: 0,
      aiSummary: "",
      aiSummaryTime: 0,
      params: {},
    );
  }
}
