import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Db_helper {
  static Db_helper db_helper = Db_helper();
  Database? database;
  Database? database2;

  Future<Database?> cheackDb() async {
    if (database != null) {
      return database;
    } else {
      return await createDb();
    }
  }
  Future<Database?> cheackDb2() async {
    if (database2 != null) {
      return database2;
    } else {
      return await createDb2();
    }
  }

  Future<Database> createDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'todo.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT,cat TEXT,work TEXT)";
        db.execute(query);
      },
    );
  }


  Future<void> insertdata({required cat,required work}) async {
    database = await cheackDb();
    database!.insert('todo', {'cat':cat,'work':work});
  }
  Future<List<Map>> readdata() async {
    database = await cheackDb();
    String quary = "SELECT * FROM todo";
    List<Map>dataList =await  database!.rawQuery(quary);
    return dataList;
  }

  Future<void> deletedata({required id}) async {
    database  = await cheackDb();
    database!.delete('todo',where: "id = ?",whereArgs: [id]);
  }

  Future<Database> createDb2() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'todo2.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE done(id INTEGER PRIMARY KEY AUTOINCREMENT,cat TEXT,work TEXT)";
        db.execute(query);
      },
    );
  }

  Future<void> insertdonedata({required cat,required work}) async {
    database2 = await cheackDb2();
    database2!.insert('done', {'cat':cat,'work':work});
  }
  Future<List<Map>> readdonedata() async {
    database2 = await cheackDb2();
    String quary = "SELECT * FROM done";
    List<Map> dataList2 =await  database2!.rawQuery(quary);
    return dataList2;
  }

  Future<void> deletedonedata({required id}) async {
    database2  = await cheackDb2();
    database2!.delete('done',where: "id = ?",whereArgs: [id]);
  }
}
