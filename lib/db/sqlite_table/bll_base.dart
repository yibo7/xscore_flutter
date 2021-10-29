
import 'package:sqflite/sqflite.dart';
import 'package:xscore/db/sqlite_table/sqlite_provider.dart';
import 'package:xscore/utils/log_util.dart';

import 'entity_base.dart';

abstract class BllBase<T extends EntityBase,K> {

  String get tableName;
  Database get db => SqliteProvider.db;

  Future<void> createTable();

  Future<bool> existByColum(String columName,String value) async {
    List<Map> maps = await db.query(tableName,
        where: '$columName = ?',
        whereArgs: [value]);
    if (maps.length > 0) {
      return true;
    }
    return false;
  }
  Future<int> insert(T model) async {
    return await db.insert(tableName, model.toMap());
  }
  Future<T> getEntity(K id) async {
    List<Map> maps = await db.query(tableName,
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return fromMap(maps.first);
    }
    return null;
  }

  T fromMap(Map<String, dynamic> mp);
  Future<List<T>> getList() async {
    List<T> lst = [];
    List<Map> records = await db.query(tableName);
    records.forEach((v) {
      lst.add(fromMap(v));
    });
    return lst;
  }
  Future<int> delete(K id) async {
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    return await db.delete(tableName);
  }

  Future<int> update(T model) async {
    return await db.update(tableName, model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }
  init() async {
     bool isHave = await _isHaveTable();
    if(!isHave){
      createTable();
      LogUtil.debug("表$tableName创建成功");
    }
    else{
      deleteAll();
      LogUtil.debug("清空$tableName数据");
    }
  }

  Future<void> deleteTable() async{
    await db.execute('''
        DROP TABLE $tableName;
      ''');
  }

  Future<bool> _isHaveTable() async {
    List lstTables = await _getTables();
    bool isHave = false;
    if(lstTables.length>0){
      lstTables.forEach((v) {
        if(v==tableName){
          isHave = true;
        }
      });
    }
    return isHave;
  }
  Future<List> _getTables() async {
    if (db == null) {
      return Future.value([]);
    }
    List tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    return targetList;
  }



}