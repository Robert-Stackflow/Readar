import 'package:flutter/cupertino.dart';
import 'package:readar/Providers/RssService/local_rss_service_provider.dart';

import '../../Models/rss_service.dart';
import '../RssService/base_rss_service_provider.dart';

GlobalRssProvider globalRssProvider = GlobalRssProvider();

class GlobalRssProvider with ChangeNotifier {
  final List<BaseRssServiceProvider> _serviceManagers = [];

  List<BaseRssServiceProvider> get serviceManagers => _serviceManagers;

  BaseRssServiceProvider? _selectedService;

  BaseRssServiceProvider? get selectedService => _selectedService;

  void select() {
    if (_selectedService == null && _serviceManagers.isNotEmpty) {
      _selectedService = serviceManagers.first;
    }
    notifyListeners();
  }

  void addService(RssServiceModel serviceModel) {
    _serviceManagers.add(BaseRssServiceProvider.impl(serviceModel));
    notifyListeners();
    select();
  }

  void addServices(List<RssServiceModel> serviceModels) {
    _serviceManagers
        .addAll(serviceModels.map((e) => BaseRssServiceProvider.impl(e)).toList());
    notifyListeners();
    select();
  }

  void removeService(BaseRssServiceProvider manager) {
    _serviceManagers.remove(manager);
    notifyListeners();
  }
}
