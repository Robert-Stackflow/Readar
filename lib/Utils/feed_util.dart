import 'package:http/http.dart' as http;
import 'package:readar/Utils/ilogger.dart';
import 'package:rss_dart/dart_rss.dart';
import 'package:rss_dart/domain/rss1_feed.dart';

import '../Models/article.dart';

class FeedUtil {
  static Future<String> fetchXml(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        ILogger.error('fetch xml error', 'status code: ${response.statusCode}');
        return '';
      }
    } catch (e, t) {
      ILogger.error('fetch xml error', e, t);
      return '';
    }
  }

  static Future<List<Article>> parseRss(String xml) async {
    try {
      List<Article> articles = [];
      bool success = false;
      try {
        var channel = RssFeed.parse(xml);
        articles = channel.items.map((item) => item.article).toList();
        success = true;
      } catch (e, t) {
        ILogger.error('parse rss error', e, t);
        articles = [];
      }
      if (!success) {
        try {
          var channel = AtomFeed.parse(xml);
          articles = channel.items.map((item) => item.article).toList();
        } catch (e, t) {
          ILogger.error('parse rss error', e, t);
          articles = [];
        }
      }
      if (!success) {
        try {
          var channel = Rss1Feed.parse(xml);
          articles = channel.items.map((item) => item.article).toList();
        } catch (e, t) {
          ILogger.error('parse rss error', e, t);
          articles = [];
        }
      }
      return articles;
    } catch (e, t) {
      ILogger.error('parse rss error', e, t);
      return [];
    }
  }
}
