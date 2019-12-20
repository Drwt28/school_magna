import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_magna/Model/Database/db.dart';
import 'package:school_magna/Services/Student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendencePage extends StatefulWidget {
  String tag;

  AttendencePage(this.tag);

  @override
  _AttendencePageState createState() => _AttendencePageState();
}

class _AttendencePageState extends State<AttendencePage> {
  var _db = DatabaseService();
  List<Student> students = [];
  Color selectColor = Colors.blue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var pref = Provider.of<SharedPreferences>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Attendence'),

        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[

            Flexible(
              flex: 1,
              child: SizedBox(
                height: 90,
                width: 90,
                child: buildTopBox(),
              ),
            )
            ,
            Flexible(
              flex: 7,
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('schools')
                    .document(pref.getString('school'))
                    .collection('students')
                    .where('classId', isEqualTo: user.email)
                    .snapshots(),
                builder: (context, query) {
                  return (query.data != null && query.data.documents.length > 0)
                      ? buildAttendenceList(query.data.documents)
                      : CircularProgressIndicator();
                },
              ),
            ),
          ],
        ));
  }

  Widget buildAttendenceList(List<DocumentSnapshot> snap) {
    List<bool> isSelected = [false, false, false];
    return ListView.builder(
      itemCount: snap.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("\t" + snap[index]['name']),
          trailing: ToggleButtons(
            borderRadius: BorderRadius.circular(20),
            selectedColor: selectColor,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: buildAttendence("A"),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: buildAttendence("P"),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: buildAttendence('L'),
              )
            ],
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0;
                buttonIndex < isSelected.length;
                buttonIndex++) {
                  if (buttonIndex == index) {
                    if (index == 0) {
                      selectColor = Colors.red;
                    } else if (index == 1) {
                      selectColor = Colors.green;
                    } else {
                      selectColor = Colors.blue;
                    }

                    isSelected[buttonIndex] = !isSelected[buttonIndex];
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
              });
            },
            isSelected: isSelected,
          ),
        );
      },
    );
  }

  Widget buildAttendence(String a) {
    return Text(a, style: TextStyle(fontSize: 30));
  }

  Widget buildTopBox() {
    return Hero(
      tag: 'attendence',
      child: Image(
        image: AssetImage('assets/teacher/attendence.png'),
      ),
    );
  }

  void getStudentsData(String classId, schoolId) {
    setState(() {
      this.students = _db.getStudents(classId, schoolId);
    });

    print(students);
  }
//
//  StreamBuilder<QuerySnapshot>(
//  stream: Firestore.instance.collection('schools').document(pref.getString('school'))
//      .collection('students').where('classId',isEqualTo:"1" ).snapshots(),
//
//  builder: (context,snapshots)
//  {
//  return
//  ListView.builder(
//  itemCount: 30,
//  itemBuilder: (context,index){
//  return buildAttendenceList('name', index);
//  });
//
//  },
//  )

}
