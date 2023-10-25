class DBConfig {
  static const defaultNickName = "耶耶";
  static const dbname = "rss.db";
  static const subscriptionTableName = "subscription";
  static const chatTableCreateSql =
      'CREATE TABLE ${DBConfig.subscriptionTableName}(id INTEGER PRIMARY KEY, content TEXT, sender INTEGER, moderation INTEGER, time TEXT)';
}
