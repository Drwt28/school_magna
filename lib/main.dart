import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_magna/selectPanel.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text("School Magna"),
            ),
            body: Center(


              child: RaisedButton(

                color: Colors.blue,
                child: Text('Start',style: TextStyle(
                  color: Colors.white
                ),),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SelectionPanel()));
                },
              ),
            ),
          );


  }


}
