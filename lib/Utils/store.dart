import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class StoreKeys {
  static const GROUPS = "groups";
  static const ERROR_LOG = "errorLog";
  static const UNCATEGORIZED = "uncategorized";
  static const UNREAD_SUBS_ONLY = "unreadSubsOnly";

  // General
  static const THEME = "theme";
  static const LOCALE = "locale";
  static const KEEP_ITEMS_DAYS = "keepItemsD";
  static const SYNC_ON_START = "syncOnStart";
  static const IN_APP_BROWSER = "inAppBrowser";
  static const TEXT_SCALE = "textScale";

  // Feed preferences
  static const FEED_FILTER_ALL = "feedFilterA";
  static const FEED_FILTER_SOURCE = "feedFilterS";
  static const SHOW_THUMB = "showThumb";
  static const SHOW_SNIPPET = "showSnippet";
  static const DIM_READ = "dimRead";
  static const FEED_SWIPE_R = "feedSwipeR";
  static const FEED_SWIPE_L = "feedSwipeL";
  static const UNREAD_SOURCE_TIP = "unreadSourceTip";

  // Reading preferences
  static const ARTICLE_FONT_SIZE = "articleFontSize";

  // Syncing
  static const SYNC_SERVICE = "syncService";
  static const LAST_SYNCED = "lastSynced";
  static const LAST_SYNC_SUCCESS = "lastSyncSuccess";
  static const LAST_ID = "lastId";
  static const ENDPOINT = "endpoint";
  static const USERNAME = "username";
  static const PASSWORD = "password";
  static const API_ID = "apiId";
  static const API_KEY = "apiKey";
  static const FETCH_LIMIT = "fetchLimit";
  static const FEVER_INT_32 = "feverInt32";
  static const LAST_FETCHED = "lastFetched";
  static const AUTH = "auth";
  static const USE_INT_64 = "useInt64";
  static const INOREADER_REMOVE_AD = "inoRemoveAd";
}

class Store {
  static late SharedPreferences sp;

  static Map<String, List<String>> getGroups() {
    var groups = sp.getString(StoreKeys.GROUPS);
    if (groups == null) return <String, List<String>>{};
    Map<String, List<String>> result = {};
    var parsed = jsonDecode(groups);
    for (var key in parsed.keys) {
      result[key] = List.castFrom(parsed[key]);
    }
    return result;
  }

  static void setGroups(Map<String, List<String>> groups) {
    sp.setString(StoreKeys.GROUPS, jsonEncode(groups));
  }

  static int getArticleFontSize() {
    return sp.getInt(StoreKeys.ARTICLE_FONT_SIZE) ?? 16;
  }

  static void setArticleFontSize(int value) {
    sp.setInt(StoreKeys.ARTICLE_FONT_SIZE, value);
  }

  static String getErrorLog() {
    return sp.getString(StoreKeys.ERROR_LOG) ?? "";
  }

  static void setErrorLog(String value) {
    sp.setString(StoreKeys.ERROR_LOG, value);
  }
}
