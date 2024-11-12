import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../database_manager.dart';

abstract class BaseDao<T> {
  Future<Database> getDataBase() async {
    return await DatabaseManager.getDataBase();
  }

  FutureOr<T?> queryById(int id);

  FutureOr<List<T>> queryAll();

  FutureOr<int> insert(T item);

  FutureOr<int> insertAll(List<T> items);

  FutureOr<int> update(T item);

  FutureOr<int> updateAll(List<T> items);

  FutureOr<int> delete(T item);

  FutureOr<int> deleteAll();
}