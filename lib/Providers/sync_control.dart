import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'global.dart';

class SyncControl extends StatefulWidget {
  const SyncControl({super.key});

  @override
  SyncControlState createState() => SyncControlState();
}

class SyncControlState extends State<SyncControl> {
  Future<void> _onRefresh() {
    var completer = Completer();
    Function() listener = () {};
    listener = () {
      if (!Global.syncProvider.syncing) {
        completer.complete();
        Global.syncProvider.removeListener(listener);
      }
    };
    Global.syncProvider.addListener(listener);
    Global.syncProvider.syncWithService();
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: _onRefresh,
    );
  }
}
