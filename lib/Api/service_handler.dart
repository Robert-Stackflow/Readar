import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../Models/feed.dart';
import '../Models/rss_item.dart';
import '../Providers/provider_manager.dart';

enum SyncService { none, fever, feedbin, googleReader, inoreader }

///
/// Service-related interface parent class.
/// Define operation interfaces such as account authentication, obtaining feeds, obtaining articles, synchronizing articles, stars, and marking as read.
///
abstract class ServiceHandler {
  ///
  /// 删除服务
  ///
  void removeService() {
    ProviderManager.groupsProvider.groups = <String, List<String>>{};
    ProviderManager.groupsProvider.showUncategorized = false;
  }

  ///
  /// 发送HTTP请求接口
  ///
  /// [path] 请求路径
  ///
  /// [body] 请求体
  ///
  Future<http.Response> fetchResponse(String path, {dynamic body});

  ///
  /// 验证登陆状态
  ///
  Future<bool> validate();

  ///
  /// 登录认证
  ///
  Future<void> authenticate() async {}

  ///
  /// 获取订阅源
  ///
  Future<Tuple2<List<Feed>, Map<String, List<String>>>> fetchFeedsAndGroups();

  ///
  /// 获取文章列表
  ///
  Future<List<RSSItem>> fetchItems();

  Future<Tuple2<Set<String>, Set<String>>> syncItems();

  Future<void> markAllRead(Set<String> sids, DateTime date, bool before);

  Future<void> markRead(RSSItem item);

  Future<void> markUnread(RSSItem item);

  Future<void> star(RSSItem item);

  Future<void> unstar(RSSItem item);
}
