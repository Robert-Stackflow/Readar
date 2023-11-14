enum CreateTableSql {
  feedService("feedService", '''
        CREATE TABLE feedService (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        endpoint TEXT NOT NULL,
        feedServiceType INTEGER NOT NULL,
        username TEXT,
        password TEXT,
        appId TEXT,
        appKey TEXT,
        authorization TEXT,
        fetchLimit INTEGER,
        pullOnStartUp INTEGER,
        lastSyncStatus INTEGER,
        lastSyncTime INTEGER,
        lastedFetchedId TEXT,
        latestFetchedTime INTEGER,
        params TEXT
      );
  '''),
  feed(
    "feed",
    '''
      CREATE TABLE feed (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        serviceId INTEGER NOT NULL,
        sid TEXT NOT NULL,
        url TEXT NOT NULL,
        name TEXT NOT NULL,
        iconUrl TEXT,
        feedSetting TEXT,
        lastPullStatus INTEGER,
        lastPullTime INTEGER,
        latestArticleTime INTEGER,
        latestArticleTitle TEXT,
        params TEXT
      );
    ''',
  ),
  items(
    "items",
    '''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        feedId INTEGER NOT NULL,
        feedSid TEXT NOT NULL,
        title TEXT NOT NULL,
        url TEXT NOT NULL,
        date INTEGER NOT NULL,
        content TEXT NOT NULL,
        snippet TEXT NOT NULL,
        creator TEXT,
        thumb TEXT,
        hasRead INTEGER NOT NULL,
        starred INTEGER NOT NULL,
        readTime INTEGER,
        starTime INTEGER,
        params TEXT
      );
    ''',
  );

  const CreateTableSql(this.tableName, this.sql);

  final String tableName;
  final String sql;
}
