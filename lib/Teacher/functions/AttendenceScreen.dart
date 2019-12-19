import 'package:flutter/material.dart';

class AttendencePage extends StatefulWidget {
  String tag;

  AttendencePage(this.tag);

  @override
  _AttendencePageState createState() => _AttendencePageState();
}

class _AttendencePageState extends State<AttendencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
            width: 100,
            child: Hero(
              tag: 'attendence',
              child: Image(
                image: AssetImage('assets/teacher/attendence.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<bool> isSelected = [false, false, false];

  Widget buildAttendenceList(String name, roll) {
    return Row(
      children: <Widget>[
        Text('Student name'),
        ToggleButtons(
          children: <Widget>[
            Icon(Icons.ac_unit),
            Icon(Icons.call),
            Icon(Icons.cake),
          ],
          onPressed: (int index) {
            int count = 0;
            isSelected.forEach((bool val) {
              if (val) count++;
            });
            if (isSelected[index] && count < 2) return;
            setState(() {
              isSelected[index] = !isSelected[index];
            });
          },
          isSelected: isSelected,
        ),
      ],
    );
  }
}
