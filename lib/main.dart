
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestoreservice.dart';
import 'taskscreen.dart';
import 'task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff543B7A),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> todoTasks;

  @override
  void initState() {
    super.initState();

    items=new List();

    todoTasks?.cancel();
    todoTasks=fireServ.getTaskList().listen((QuerySnapshot snapshot){
      final List<Task> tasks=snapshot.documents
          .map((documentSnapshot) => Task. fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = tasks;
      });

    });

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
          "To-Do List",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,
            color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Stack(children: <Widget>[
                    // The containers in the background
                    Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80.0,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Material(
                              color: Colors.white,
                              elevation: 14.0,
                              shadowColor: Colors.blueGrey,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      todoType('${items[index].tasktype}'),
                                      Text(
                                        '${items[index].taskName}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,fontFamily: 'Raleway'),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${items[index].taskDate}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,fontFamily: 'Raleway'),
                                          ),
                                          Text(
                                            '${items[index].taskTime}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,fontFamily: 'Raleway'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]);
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          //Navigator.push(context,MaterialPageRoute(builder: (context) => TaskScreen()),
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskScreen(Task('', '', '', '', '')),
                fullscreenDialog: true),
          );
        },
      ),
    );
  }


  Widget todoType(String icontype) {
    IconData iconval;
    Color colorval;
    switch (icontype) {
      case 'travel':
        iconval = Icons.markunread;
        colorval = Color(0xff4158ba);
        break;
      case 'shopping':
        iconval = Icons.cloud;
        colorval = Color(0xfffb537f);
        break;
      case 'gym':
        iconval = Icons.bookmark;
        colorval = Color(0xff4caf50);
        break;
      case 'party':
        iconval = Icons.cloud_upload;
        colorval = Color(0xff9962d0);
        break;
      default:
        iconval = Icons.tablet_android;
        colorval = Color(0xff0dc8f5);
    //
    }
    return CircleAvatar(
      backgroundColor: colorval,
      child: Icon(iconval, color: Colors.white, size: 20.0),
    );
  }


}