import 'package:flutter/material.dart';
import 'package:school_magna/Student/studentHomeScreen.dart';
import 'package:school_magna/Student/studentPage.dart';

class StudentPanel extends StatefulWidget {
  @override
  _StudentPanelState createState() => _StudentPanelState();
}

class _StudentPanelState extends State<StudentPanel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Login"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Email';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            SizedBox(
              height: 40.0,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Password';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
            RaisedButton(

              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));

                }
              },
              child: Text('Submit'),
            ),
            SizedBox(
              height: 40.0,
            ),

//        DataTable(
//          columns: [
//            DataColumn(label: Text('name' , style: TextStyle(
//              color: Colors.blue
//            ),))
//            ,DataColumn(label: Text('name', style: TextStyle(
//                color: Colors.red
//            )))
//           , DataColumn(label: Text('name'))
//            ,DataColumn(label: Text('name'))
//          ],
//
//          rows: [
//            DataRow(cells:
//           [ DataCell(Text('1'))
//           , DataCell(Text('2')), DataCell(Text('2')), DataCell(Text('2'))
//
//    ]
//    ),        DataRow(cells:
//           [ DataCell(Text('1'))
//           , DataCell(Text('2')), DataCell(Text('2')), DataCell(Text('2'))
//
//    ]
//    ) ,       DataRow(cells:
//           [ DataCell(Text('1'))
//           , DataCell(Text('2')), DataCell(Text('2')), DataCell(Text('2'))
//
//    ]
//    )
//          ],
//        ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => studentHome  ()));
              },
              child: Text('Skip'),
            ),
          ],
        ),
      ),
    );
  }
}
