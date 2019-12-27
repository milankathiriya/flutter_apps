import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'DBModel.dart';

class DBHelper{

  static Database _db;
  static const String COL_id = 'id';
  static const String COL_name = 'name';
  static const String TABLE = 'user';
  static const String DB_NAME = 'users.db';

  Future get db async => (_db != null) ? _db : await initDb();

  initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    var path = dir.path + "/" +DB_NAME;  //  path/users.db
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
      await db.execute("CREATE TABLE $TABLE ($COL_id INTEGER PRIMARY KEY NOT NULL, $COL_name TEXT)");
  }

  save(User user) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert("INSERT INTO $TABLE($COL_name) VALUES('${user.name}')");
    });
  }

  getUsers() async {
    var dbClient = await db;
    List data = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List users = [];
    for(int i=0; i<data.length; i++){
        users.add(User.fromMap(data[i]));
    }
    print(users);
    return users;
  }

  delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete("DELETE FROM $TABLE WHERE id=$id");
  }

}