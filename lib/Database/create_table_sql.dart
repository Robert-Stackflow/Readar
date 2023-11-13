enum CreateTableSql {
  feed(
    "feed",
    '''
      CREATE TABLE feed (
        id INTEGER PRIMARY KEY,
        url TEXT NOT NULL,
        iconUrl TEXT,
        name TEXT NOT NULL,
        openTarget INTEGER NOT NULL,
        latest INTEGER NOT NULL,
        lastTitle INTEGER NOT NULL
      );
    ''',
  );

  const CreateTableSql(this.tableName, this.sql);

  final String tableName;
  final String sql;
}
