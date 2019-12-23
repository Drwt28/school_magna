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
import 'package:school_magna/Teacher/functions/NoticeScreen.dart';
import 'package:school_magna/Teacher/functions/feesNotificationScreen.dart';
import 'package:school_magna/Teacher/functions/homeWork.dart';
import 'package:school_magna/Teacher/functions/remarkScreen.dart';
import 'package:school_magna/Teacher/functions/studentListScreen.dart';
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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              primary: true,
              floating: true,
              pinned: true,
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
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height * 0.34,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: SafeArea(
                  top: true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 58.0),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 2),
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: Firestore.instance
                              .collection('schools')
                              .document(pref.getString('school'))
                              .collection('classes')
                              .document(user.email)
                              .snapshots(),
                          builder: (context, snap) {
                            var s = snap.data;
                            if (s != null && s.exists)
                              return teacherDashBoard(snap.data.data);
                            else
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 1,
              childAspectRatio: 3.5,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => feesNotificationPage()));
                    },
                    child: CustomWidgets.teacherHomePannelCardHeroSingle(
                        context,
                        'Fee Notification',
                        'assets/teacher/fees.png',
                        Colors.blue,
                        Colors.indigo,
                        'fees'))
              ],
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NoticePage()));
                  },
                  child: CustomWidgets.teacherHomePannelCardHero(
                      context,
                      'Notice',
                      'assets/teacher/notice.png',
                      Colors.blue,
                      Colors.lightBlue,
                      'notice'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RemarkPage()));
                  },
                  child: CustomWidgets.teacherHomePannelCardHero(
                      context,
                      'Remarks',
                      'assets/teacher/remark.png',
                      Colors.indigoAccent,
                      Colors.blueAccent,
                      'remark'),
                ),
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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => homeworkPage()));
                  },
                  child: CustomWidgets.teacherHomePannelCardHero(
                      context,
                      'HomeWork',
                      'assets/teacher/homework.png',
                      Colors.blue,
                      Colors.indigoAccent,
                      'homework'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentListPage()));
                  },
                  child: CustomWidgets.teacherHomePannelCardHero(
                      context,
                      'Students ',
                      'assets/teacher/student.png',
                      Colors.blue,
                      Colors.lightBlue,
                      'studentList'),
                ),
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
//    Class c = Class.fromMap(map);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(map['teacherName'],
              style: TextStyle(color: Colors.black, fontSize: 20)),
          SizedBox(
            height: 10,
          ),
          Text(map['className'] + "\t" + map['section'],
              style: TextStyle(color: Colors.black, fontSize: 16)),
          SizedBox(
            height: 10,
          ),
          buildDashboardText('last Attendence Date :' + ''),
          SizedBox(height: 6),
          buildDashboardText('last notice :' + map['notice']),
          SizedBox(height: 6),
          buildDashboardText(
              'present students :' + map['presentStudents'].toString())
        ],
      ),
    );
  }

  Widget buildDashboardText(String text) {
    return Text(text, style: TextStyle(color: Colors.black, fontSize: 16));
  }
}
