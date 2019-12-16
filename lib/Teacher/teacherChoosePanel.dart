import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class TeacherChoosePanel extends StatefulWidget {
  @override
  _TeacherChoosePanelState createState() => _TeacherChoosePanelState();
}



class _TeacherChoosePanelState extends State<TeacherChoosePanel> {

  String email;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[


              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {},
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Colors.indigo, Colors.tealAccent],
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text('Principal'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {},
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Colors.indigo, Colors.tealAccent],
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text('Vice-Principle'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {},
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Colors.indigo, Colors.tealAccent],
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text('Director'),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 40.0,
              ),

              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {},
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Colors.indigo, Colors.tealAccent],
                      ),
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text('Director'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
