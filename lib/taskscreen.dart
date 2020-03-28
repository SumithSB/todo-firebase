import 'package:flutter/material.dart';
import 'task.dart';
import 'firestoreservice.dart';

class TaskScreen extends StatefulWidget {
  final Task task;
  TaskScreen(this.task);
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  FirestoreService fireServ = new FirestoreService();

  TextEditingController _taskNameController;
  TextEditingController _taskDetailsController;
  TextEditingController _taskDateController;
  TextEditingController _taskTimeController;

  int _myTaskType = 0;
  String taskVal;
  void _handleTaskType(int value) {
    setState(() {
      _myTaskType = value;
      switch (_myTaskType) {
        case 1:
          taskVal='travel';
          break;
        case 2:
          taskVal='shopping';
          break;
        case 3:
          taskVal='gym';
          break;
        case 4:
          taskVal='party';
          break;
        case 5:
          taskVal='others';
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _taskNameController = new TextEditingController(text: widget.task.taskName);
    _taskDetailsController = new TextEditingController(text: widget.task.taskDetails);
    _taskDateController = new TextEditingController(text: widget.task.taskDate);
    _taskTimeController = new TextEditingController(text: widget.task.taskTime);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: Icon(Icons.arrow_back_ios,color: Colors.white,),
        centerTitle: true,
        title: Text(
          "New Task",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskNameController,
                    decoration: InputDecoration(labelText: "Task: "),
                    style: TextStyle(
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskDetailsController,
                    decoration: InputDecoration(labelText: "Details: "),
                    style: TextStyle(
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskDateController,
                    decoration: InputDecoration(labelText: "Date: "),
                    style: TextStyle(
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskTimeController,
                    decoration: InputDecoration(labelText: "Time: "),
                    style: TextStyle(
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    'Select Task Type:',
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,fontFamily: 'Raleway',),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Colors.blueGrey,
                        ),
                        Text(
                          'Travel',
                          style: TextStyle(fontSize: 16.0,fontFamily: 'Raleway',),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Colors.blueGrey,
                        ),
                        Text(
                          'Shopping',
                          style: TextStyle(
                            fontSize: 16.0,fontFamily: 'Raleway',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 3,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4caf50),
                        ),
                        Text(
                          'Gym',
                          style: TextStyle(fontSize: 16.0,fontFamily: 'Raleway',),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 4,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff9962d0),
                        ),
                        Text(
                          'Party',
                          style: TextStyle(fontSize: 16.0,fontFamily: 'Raleway',),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 5,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff0dc8f5),
                        ),
                        Text(
                          'Others',
                          style: TextStyle(fontSize: 16.0,fontFamily: 'Raleway',),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.blueGrey,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white,
                          fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold
                          ),
                        )),
                    // This button results in adding the contact to the database
                    RaisedButton(
                        color: Colors.blueGrey,
                        onPressed: () {
                          fireServ.createTODOtask(_taskNameController.text, _taskDetailsController.text,_taskDateController.text,_taskTimeController.text,taskVal).then((_) {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold
                          ),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}