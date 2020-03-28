import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String taskName,taskDetails,taskDate,taskTime;

  getTaskName(taskName){
    this.taskName = taskName;
  }
  getTaskDetails(taskDetails){
    this.taskDetails = taskDetails;
  }
  getTaskDate(taskDate){
    this.taskDate = taskDate;
  }
  getTaskTime(taskTime){
    this.taskTime = taskTime;
  }

  int _myTaskType=0;
  String taskVal;

  void _handleTaskType(int value){
    setState(() {
      _myTaskType=value;
      switch(_myTaskType){
        case 1: taskVal='travel';break;
        case 2: taskVal='shopping';break;
        case 3: taskVal='gym';break;
        case 4: taskVal='party';break;
        case 5: taskVal='others';break;
      }
    });
  }

  createData(){
    DocumentReference ds = Firestore.instance.collection('todolist').document(taskName);
    Map<String,dynamic> tasks = {
      "taskName":taskName,
      "taskDetails":taskDetails,
      "taskDate":taskDate,
      "taskTime":taskTime,
      "tasktype":taskVal
    };
    ds.setData(tasks).whenComplete((){
      print("Task created");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),

        centerTitle: true,
        title: Text("New Task",
        style: TextStyle(
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-80,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextField(
                    onChanged: (String taskName){
                      getTaskName(taskName);
                    },
                    decoration: InputDecoration(
                      labelText: "Task:"
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextField(
                    onChanged: (String taskDetails){
                      getTaskDetails(taskDetails);
                    },
                    decoration: InputDecoration(
                        labelText: "Details:"
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextField(
                    onChanged: (String taskDate){
                      getTaskDate(taskDate);
                    },
                    decoration: InputDecoration(
                        labelText: "Date:"
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0,right: 16.0),
                  child: TextField(
                    onChanged: (String taskTime){
                      getTaskTime(taskTime);
                    },
                    decoration: InputDecoration(
                        labelText: "Time:"
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Center(
                  child: Text(
                    "Select a task",
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
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
                          "Travel",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
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
                          "Shopping",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
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
                          activeColor: Colors.blueGrey,
                        ),
                        Text(
                          "Gym",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
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
                          activeColor: Colors.blueGrey,
                        ),
                        Text(
                          "Party",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
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
                          activeColor: Colors.blueGrey,
                        ),
                        Text(
                          "Others",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
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
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blueGrey,
                      onPressed: (){
                        createData();
                      },
                      child: const Text("Submit",
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
