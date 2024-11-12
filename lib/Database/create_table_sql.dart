enum CreateTableSql {
  rssService("rssService", '''
        CREATE TABLE rssService (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          endpoint TEXT NOT NULL,
          name TEXT NOT NULL,
          rssServiceType INTEGER NOT NULL,
          username TEXT,
          password TEXT,
          appId TEXT,
          appKey TEXT,
          authorization TEXT,
          fetchLimit INTEGER NOT NULL,
          pullOnStartUp INTEGER NOT NULL,
          lastSyncStatus INTEGER NOT NULL,
          lastSyncTime INTEGER NOT NULL,
          latestFetchTime INTEGER NOT NULL,
          createTime INTEGER NOT NULL,
          latestFetchId TEXT,
          params TEXT
        )
        '''),
  feed("feed", '''
        CREATE TABLE feed (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          serviceId INTEGER NOT NULL,
          fid TEXT NOT NULL,
          url TEXT NOT NULL,
          iconUrl TEXT,
          name TEXT NOT NULL,
          unReadCount INTEGER NOT NULL,
          feedSetting TEXT,
          lastFetchStatus INTEGER NOT NULL,
          lastFetchTime INTEGER NOT NULL,
          latestArticleTime INTEGER NOT NULL,
          latestArticleTitle TEXT,
          filterRules TEXT,
          params TEXT
        )
        '''),articleItem("articleItem", '''
        CREATE TABLE articleItem (
          id TEXT PRIMARY KEY,
          feedId INTEGER NOT NULL,
          feedFId TEXT NOT NULL,
          title TEXT NOT NULL,
          url TEXT NOT NULL,
          publishTime INTEGER NOT NULL,
          content TEXT NOT NULL,
          snippet TEXT NOT NULL,
          aiSummary TEXT,
          creator TEXT,
          thumb TEXT,
          read INTEGER NOT NULL,
          starred INTEGER NOT NULL,
          hide INTEGER NOT NULL,
          readTime INTEGER NOT NULL,
          starTime INTEGER NOT NULL,
          readDuration INTEGER NOT NULL,
          aiSummaryTime INTEGER NOT NULL,
          params TEXT
        )
        '''),backupService("backupService", '''
        CREATE TABLE backupService (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          endpoint TEXT,
          email TEXT,
          account TEXT,
          secret TEXT,
          token TEXT,
          enabled INTEGER NOT NULL,
          totalSize INTEGER NOT NULL,
          usedSize INTEGER NOT NULL,
          remainingSize INTEGER NOT NULL,
          createTimestamp INTEGER NOT NULL,
          editTimestamp INTEGER NOT NULL,
          lastFetchTimestamp INTEGER NOT NULL,
          lastBackupTimestamp INTEGER NOT NULL,
          lastFetchStatus INTEGER NOT NULL,
          lastBackupStatus INTEGER NOT NULL,
          params TEXT
        )
        '''),extensionService("extensionService", '''
        CREATE TABLE extensionService (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          endpoint TEXT NOT NULL,
          username TEXT,
          password TEXT,
          appId TEXT,
          appKey TEXT,
          articleCount INTEGER NOT NULL,
          lastPullTime INTEGER NOT NULL,
          lastPullStatus INTEGER NOT NULL,
          params TEXT
        )
        ''');

  const CreateTableSql(this.tableName, this.sql);

  final String tableName;
  final String sql;
}

// int id;
// String endpoint;
// String? username;
// String? password;
// String? appId;
// String? appKey;
// int articleCount;
// int lastPullTime;
// SyncStatus? lastPullStatus;
// Map<String, dynamic> params;
