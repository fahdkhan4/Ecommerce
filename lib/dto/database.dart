import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import '../StudentModel.dart';

class DbHelper{

  static Future<sql.Database> database() async{
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath,'student.db'),
        onCreate: (db,version){
          return db.execute('CREATE TABLE student (rollno TEXT PRIMARY KEY, name TEXT, marks TEXT)');
        },version: 1);
  }

  static Future<void> insert(String table,Map<String,Object> data)async {
      final db = await DbHelper.database();
          db.insert(
          table
          ,data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>> getData(String table) async{
    final db = await DbHelper.database();
    return db.query(table);
  }

  static Future<void> deleteData(String rollnumber) async{
    final db = await DbHelper.database();
    int count = await db.rawDelete('DELETE FROM student WHERE rollno = ${rollnumber}');
    assert(count == 1);
    Student.fetchAndSetStudent();
  }

  static Future<void> updateDataById(String rollNo,String name,String marks)async {
    final db = await DbHelper.database();
    int count = await db.rawUpdate('UPDATE student SET name="${name}",marks="${marks}" WHERE rollno="${rollNo}"');
    Student.fetchAndSetStudent();
  }

}
