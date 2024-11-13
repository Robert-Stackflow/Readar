import 'package:flutter/cupertino.dart';
import 'package:readar/Adapters/RssService/base_rss_service_adapter.dart';
import 'package:readar/Adapters/RssService/local_rss_service_adapter.dart';

GlobalAdapter globalAdapter = GlobalAdapter();

class GlobalAdapter with ChangeNotifier {
  BaseRssServiceAdapter _currentRssServiceAdapter =
      LocalRssServiceAdapter.instance;

  BaseRssServiceAdapter get currentRssServiceAdapter =>
      _currentRssServiceAdapter;

  set currentRssServiceAdapter(BaseRssServiceAdapter adapter) {
    _currentRssServiceAdapter = adapter;
    notifyListeners();
  }
}
