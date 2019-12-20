import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:school_magna/Model/Database/db.dart';
import 'package:school_magna/Services/Class.dart';
import 'package:school_magna/Model/model.dart';
import 'package:school_magna/Services/Teacher.dart';
import 'package:school_magna/Teacher/functions/AddStudent.dart';
import 'package:school_magna/Teacher/functions/AttendenceScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherHomePage extends StatefulWidget {
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  Teacher teacher = Teacher();

  FirebaseUser user;

  final db = DatabaseService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<FirebaseUser>(context);

    var pref = Provider.of<SharedPreferences>(context);

    print(user.email);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddStudentPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () {
                FirebaseAuth.instance.signOut().whenComplete(() {
                  Navigator.of(context).pop();
                });
              },
            )
          ],
          leading: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image(
                image: AssetImage('assets/teacher/teacher.png'),
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height * 0.34,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: Firestore.instance
                            .collection('schools')
                            .document(user.email)
                            .collection('classes')
                            .document(pref.getString('school'))
                            .snapshots(),
                        builder: (context, snap) {
                          var s = snap.data;
                          if (snap.data.exists)
                            return CircularProgressIndicator();
                          else
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                        },
                      )),
                ),
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              children: <Widget>[
                CustomWidgets.teacherHomePannelCard(
                    context,
                    'Notice',
                    'assets/teacher/notice (1).png',
                    Colors.blue,
                    Colors.lightBlue),
                CustomWidgets.teacherHomePannelCard(
                    context,
                    'Remarks',
                    'assets/teacher/remark.png',
                    Colors.indigoAccent,
                    Colors.blueAccent),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AttendencePage('attendence')));
                    },
                    child: CustomWidgets.teacherHomePannelCardHero(
                        context,
                        'Attendence',
                        'assets/teacher/attendence.png',
                        Colors.indigoAccent,
                        Colors.indigo,
                        'attendence')),
                CustomWidgets.teacherHomePannelCard(
                    context,
                    'HomeWork',
                    'assets/teacher/homework.png',
                    Colors.blue,
                    Colors.indigoAccent),
                CustomWidgets.teacherHomePannelCard(
                    context,
                    'Students ',
                    'assets/teacher/student.png',
                    Colors.blue,
                    Colors.lightBlue),
                CustomWidgets.teacherHomePannelCard(
                    context,
                    'Result',
                    'assets/teacher/exam.png',
                    Colors.indigo,
                    Colors.indigoAccent)
              ],
            )
          ],
        ));
  }

  teacherDashBoard(Map<String, dynamic> map) {
    Class c = Class.fromMap(map);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(c.teacherName,
              style: TextStyle(color: Colors.black, fontSize: 20)),
          SizedBox(
            height: 10,
          ),
          Text(c.className + "\t" + c.section,
              style: TextStyle(color: Colors.black, fontSize: 16)),
          SizedBox(
            height: 10,
          ),
          buildDashboardText('last Attendence :' +
              CustomWidgets.getTimeFromString(c.lastAttendence))
        ],
      ),
    );
  }

  Widget buildDashboardText(String text) {
    return Text(text, style: TextStyle(color: Colors.black, fontSize: 16));
  }
}
