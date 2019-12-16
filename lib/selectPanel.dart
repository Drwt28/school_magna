import 'package:flutter/material.dart';
import 'package:school_magna/Teacher/teacherChoosePanel.dart';
import 'package:school_magna/Teacher/teacher_login.dart';

import './Student/studentLoginPage.dart';

class SelectionPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        title: Text("Selection Panel",style: TextStyle(color: Colors.blue),),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentPanel()));
                  },
                  child: buildCard(
                      context, "Student", 'assets/teacher/teacher.png'))
              ,
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => teacher_login()));
                  },
                  child: buildCard(
                      context, "Teacher", 'assets/teacher/teacher.png'))

            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, String tit, String path) {
    return AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(30),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.lightBlue, Colors.blue]),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Image(
                  image: AssetImage(path),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  tit,
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }
}
