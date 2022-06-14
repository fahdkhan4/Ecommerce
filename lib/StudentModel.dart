import 'package:finallab/dto/database.dart';
import 'package:flutter/cupertino.dart';

class Student{

  String  rollNo;
  String name;
  String marks;

  static List<Student> _data =[];

  static List<Student> get data{
    return [..._data];
  }

  Student({
   required this.rollNo,
    required this.name,
    required this.marks,
  });

  @override
  String toString() {
    return 'Student{rollNo: $rollNo, name: $name, marks: $marks}';
  }

  static void StudentData(String rollNo,String name,String marks){
    DbHelper.insert('student',
        {'rollno':rollNo,
         'name':name,
          'marks':marks
        });
    fetchAndSetStudent();
  }

   static Future<List> fetchAndSetStudent() async{
    final dataList = await DbHelper.getData('student');
    _data = dataList.map((item) => Student(rollNo:item['rollno'],name:item['name'],marks:item['marks'])).toList();
    return _data;
  }


}