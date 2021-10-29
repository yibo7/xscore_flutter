import 'package:sqflite/sqflite.dart';


/*应用样例
const createSql = {
  'cat': """
      CREATE TABLE "cat" (
      `id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
      `name`	TEXT NOT NULL UNIQUE,
      `depth`	INTEGER NOT NULL DEFAULT 1,
      `parentId`	INTEGER NOT NULL,
      `desc`	TEXT
    );
  """,
  'collectio': """
    CREATE TABLE collection (id INTEGER PRIMARY KEY NOT NULL UNIQUE, name TEXT NOT NULL, router TEXT);
  """,
  'widget': """
    CREATE TABLE widget (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, name TEXT NOT NULL, cnName TEXT NOT NULL, image TEXT NOT NULL, doc TEXT, demo TEXT, catId INTEGER NOT NULL REFERENCES cat (id), owner TEXT);
  """;
};


 */

class SqliteProvider {
  static Database db;
  //初始化数据库
  static initDb(String dbname) async {
    db = await openDatabase(dbname); //'pay_var_data.db'
  }
}
