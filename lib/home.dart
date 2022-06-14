import 'package:finallab/StudentModel.dart';
import 'package:finallab/dto/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {

  final rollNoController = TextEditingController();
  final nameController = TextEditingController();
  final marksController = TextEditingController();


  Future<List<List>> data = Student.fetchAndSetStudent().asStream().toList() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Student Management "),
          leading: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.menu,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 2.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.only(right: 2.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                      Icons.more_vert
                  ),
                )
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text("Student Details", textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  // elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: "Roll No"),
                          controller: rollNoController,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: "Name"),
                          controller: nameController,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: "Marks"),
                          controller: marksController,
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(onPressed: () {
                              Student.StudentData(
                                  rollNoController.text, nameController.text,
                                  marksController.text);
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('Data Added'),
                                      content: Text("Record Added"),
                                    ),
                              );
                              blankAllTheFields();
                            },
                                textColor: Colors.purple,
                                child: Text("Add Data"),
                              color: Colors.amber,
                            ),
                            Padding(padding: EdgeInsets.only(left: 40)),
                            RaisedButton(onPressed: (){
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                        title: const Text('Get All Students'),
                                        content: ListView.builder(
                                          itemCount: Student.data.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return ListTile(
                                              title: Text('* Roll No : ${Student.data[index].rollNo} \n* Name : ${Student.data[index].name} \n* Marks : ${Student.data[index].marks}'),
                                            );
                                          },
                                        )
                                    ),
                              );
                            },textColor: Colors.purple,child: Text("Get data"), color: Colors.amber,),
                          ],
                        ),
                       
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(onPressed: () {
                              DbHelper.deleteData(rollNoController.text);
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                  AlertDialog(
                                  title: const Text('Data Deleted'),
                                    content: Text("Record Deleted"),
                                  ),
                              );
                              blankAllTheFields();
                            },
                                textColor: Colors.purple,
                                child: Text("Delete data"), color: Colors.amber,),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            RaisedButton(onPressed: () {
                              DbHelper.updateDataById(
                                  rollNoController.text, nameController.text,
                                  marksController.text);
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: const Text('Data Updated'),
                                      content: Text("Record Updated"),
                                    ),
                              );
                              blankAllTheFields();
                            },
                                textColor: Colors.purple,
                                child: Text("Update data"), color: Colors.amber,)
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
        )
    );
  }

  void blankAllTheFields(){
    nameController.text = "";
    rollNoController.text = "";
    marksController.text = "";
  }

}
