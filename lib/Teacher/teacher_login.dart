import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_magna/Teacher/classBuilderScreen.dart';
import 'package:school_magna/Teacher/teacherHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class teacher_login extends StatefulWidget {
  @override
  _teacher_loginState createState() => _teacher_loginState();
}

class _teacher_loginState extends State<teacher_login> {
  FirebaseUser user;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String _e, _p;
  String designation;
  var dec = false;

  @override
  initState() {
    super.initState();
    checkForSignIn();
  }

  Future checkForSignIn() async {
    user = await FirebaseAuth.instance.currentUser();

    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => classBuilderScreen()
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool dec = false;
    user = Provider.of<FirebaseUser>(context);
    var pref = Provider.of<SharedPreferences>(context);


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(
                height: 130,
                width: 130,
                child: buildTopBox()),

            Center(
              widthFactor: MediaQuery.of(context).size.width * 0.85,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      onSaved: (val) {
                        _e = val;
                      },
                      controller: email,
                      style: TextStyle(fontSize: 18),
                      obscureText: false,
                      decoration: InputDecoration(

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          labelText: 'teacher id', icon: Icon(Icons.email)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        _p = val;
                      },
                      onChanged: (val) {
                        setState(() {
                          _p = val;
                        });
                      },
                      controller: password,
                      obscureText: true,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),

                          labelText: 'password', icon: Icon(Icons.security)),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: buildClassDropDown(context),
                      ),
                    )
                    ,
                    SizedBox(height: 10),
                     (dec)?CircularProgressIndicator():Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        child:Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                                setState(() {
                                  dec = true;
                                                          
                          try {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: email.text.trim(),
                                password: password.text.trim())
                                .then((AuthResult result) {
                              print(result.user);
                              pref.setString('id', user.email);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => classBuilderScreen()));

                            }).catchError((Error e) {
                              print(e.stackTrace.toString());


                            });
                          } catch (e) {
                            setState(() {
                              dec = false;
                            });
                          }
                                });
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  }


  Widget buildTopBox() {
    return Hero(
      tag: 'teacher',
      child: Image(
        image: AssetImage('assets/teacher/teacher.png'),
      ),
    );
  }

  Widget buildClassDropDown(BuildContext context) {
    return SizedBox(
        height: 50,
        child: DropdownButton<String>(
          value: designation,
          icon: Icon(Icons.arrow_drop_down,color: Colors.blue,),
          iconSize: 28,
          hint: Text("select your designation ",style: TextStyle(
            color: Colors.blue,fontSize: 16
          ),),
          elevation: 16,
          style: TextStyle(color: Colors.indigo),
          underline: Container(
            height: 1,
            color: Colors.blue,
          ),
          onChanged: (String newValue) {
            setState(() {
              designation = newValue;
            });
          },
          items: <String>[
            'Teacher'
            ,'Principle'
            ,'Vice Principle'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }

}
