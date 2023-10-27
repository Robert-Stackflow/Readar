import 'package:tuple/tuple.dart';

import '../Models/feed.dart';
import '../Models/rss_item.dart';
import '../Providers/global.dart';

enum SyncService { none, fever, feedbin, googleReader, inoreader }

///
/// Service-related interface parent class.
/// Define operation interfaces such as account authentication, obtaining feeds, obtaining articles, synchronizing articles, stars, and marking as read.
///
abstract class ServiceHandler {
  void remove() {
    Global.groupsProvider.groups = <String, List<String>>{};
    Global.groupsProvider.showUncategorized = false;
  }

  Future<bool> validate();

  Future<void> reauthenticate() async {}

  Future<Tuple2<List<Feed>, Map<String, List<String>>>> getFeeds();

  Future<List<RSSItem>> fetchItems();

  Future<Tuple2<Set<String>, Set<String>>> syncItems();

  Future<void> markAllRead(Set<String> sids, DateTime date, bool before);

  Future<void> markRead(RSSItem item);

  Future<void> markUnread(RSSItem item);

  Future<void> star(RSSItem item);

  Future<void> unstar(RSSItem item);
}
