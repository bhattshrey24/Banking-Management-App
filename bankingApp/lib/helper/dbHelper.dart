import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path1;
import 'dart:async';
import 'package:path_provider/path_provider.dart' as path2;
import 'dart:io' as io;

class AppDB {
  static sql.Database _db;

  static Future<sql.Database> database() async {
    if (_db != null) {
      return _db;
    }
    _db = await AppDB._initDB();
    return _db;
  }
  static _initDB() async {
    io.Directory documentsDirectory = await path2
        .getApplicationDocumentsDirectory(); 
    var pathOfDB = path1.join(documentsDirectory.path, 'bankingDB4.db');
    var db =
        await sql.openDatabase(pathOfDB, version: 1, onCreate: AppDB._createDB);
    return db;
  }

  static _createDB(sql.Database db, int newVersion) async {
   
    await db.execute(
        'CREATE TABLE User_Details(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,credit INT)'); 
    await db.execute(
        'CREATE TABLE Transfer_Table(txnId INTEGER PRIMARY KEY AUTOINCREMENT,transferFrom TEXT,transferTo TEXT,transferAmount INT)');
    print('inside createDB');
  }

  static Future<int> insert(String tableName, Map<String, Object> data) async {
   
    print('inside insert');
    final db = await AppDB.database();

    return db.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm
            .replace); 
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    print('inside getdata');
   
    final db = await AppDB
        .database(); 
    return db.query(tableName);
  }
}
