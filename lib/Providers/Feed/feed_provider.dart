import 'package:flutter/cupertino.dart';
import 'package:readar/Models/feed.dart';
import 'package:readar/Utils/feed_util.dart';

import '../../Models/article.dart';

class FeedProvider with ChangeNotifier {
  final FeedModel feedModel; // 关联的 Feed 数据
  final List<Article> _articles = [];
  List<Article> _filteredArticles = []; // 过滤后的文章列表
  String _searchQuery = ''; // 搜索关键词

  FeedProvider(this.feedModel);

  List<Article> get articles =>
      _filteredArticles.isEmpty ? _articles : _filteredArticles;

  update(FeedModel feed) {
    feedModel.url = feed.url;
    feedModel.iconUrl = feed.iconUrl;
    notifyListeners();
  }

  // 同步方法，例如从 API 获取文章等
  Future<void> sync() async {
    // 根据 Feed 的 URL 和其他条件，获取新的文章并更新 _articles
    fetchArticlesFromWeb();
    _applyFiltersAndSearch(); // 同步后重新应用过滤和搜索
    notifyListeners();
  }

  fetchArticlesFromWeb() async {
    // 从网络获取文章
    List<Article> articles = await fetchFeed(feedModel.url);
    _articles.addAll(articles);
  }

  Future<List<Article>> fetchFeed(String url) async {
    return FeedUtil.parseRss(await FeedUtil.fetchXml(url));
  }

  // 添加文章
  Future<void> addArticle(Article article) async {
    _articles.add(article);
    _applyFiltersAndSearch(); // 在添加文章后重新应用过滤和搜索
    notifyListeners();
  }

  // 删除文章
  Future<void> removeArticle(Article article) async {
    _articles.remove(article);
    _applyFiltersAndSearch(); // 删除后重新应用过滤和搜索
    notifyListeners();
  }

  // 标记文章为已读
  Future<void> markArticleAsRead(Article article) async {
    article.read = true;
    _applyFiltersAndSearch(); // 标记已读后重新应用过滤和搜索
    notifyListeners();
  }

  // 收藏文章
  Future<void> favoriteArticle(Article article) async {
    article.starred = true;
    _applyFiltersAndSearch(); // 收藏后重新应用过滤和搜索
    notifyListeners();
  }

  // 搜索文章
  void searchArticles(String query) {
    _searchQuery = query;
    _applyFiltersAndSearch(); // 应用搜索
    notifyListeners();
  }

  // 过滤已读文章
  void filterReadArticles(bool filter) {
    _applyFiltersAndSearch(filterRead: filter); // 应用已读过滤
    notifyListeners();
  }

  // 过滤收藏文章
  void filterFavoriteArticles(bool filter) {
    _applyFiltersAndSearch(filterFavorite: filter); // 应用收藏过滤
    notifyListeners();
  }

  // 按时间排序
  void sortArticlesByDate({bool descending = false}) {
    _articles.sort((a, b) {
      return descending
          ? b.publishTime.compareTo(a.publishTime)
          : a.publishTime.compareTo(b.publishTime);
    });
    _applyFiltersAndSearch(); // 排序后重新应用过滤和搜索
    notifyListeners();
  }

  // 按标题排序
  void sortArticlesByTitle({bool descending = false}) {
    _articles.sort((a, b) {
      return descending
          ? b.title.compareTo(a.title)
          : a.title.compareTo(b.title);
    });
    _applyFiltersAndSearch(); // 排序后重新应用过滤和搜索
    notifyListeners();
  }

  // 应用搜索和过滤
  void _applyFiltersAndSearch(
      {bool filterRead = false, bool filterFavorite = false}) {
    _filteredArticles = _articles;

    // 搜索过滤
    if (_searchQuery.isNotEmpty) {
      _filteredArticles = _filteredArticles.where((article) {
        return article.title.contains(_searchQuery) ||
            article.content.contains(_searchQuery);
      }).toList();
    }

    // 已读过滤
    if (filterRead) {
      _filteredArticles =
          _filteredArticles.where((article) => article.read).toList();
    }

    // 收藏过滤
    if (filterFavorite) {
      _filteredArticles =
          _filteredArticles.where((article) => article.starred).toList();
    }
  }
}
