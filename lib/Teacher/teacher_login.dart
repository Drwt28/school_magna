import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_magna/Teacher/classBuilderScreen.dart';

class teacher_login extends StatefulWidget {
  @override
  _teacher_loginState createState() => _teacher_loginState();
}

class _teacher_loginState extends State<teacher_login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String _e,_p;

  @override
  void initState() {

    FirebaseAuth.instance.currentUser().then((FirebaseUser user){

      if(user!=null)
        {
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>classBuilderScreen()
          ));
        }
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        widthFactor: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              onSaved: (val){
                _e =val;
              },
              controller: email,
              style: TextStyle(fontSize: 18),
              obscureText: false,
              decoration: InputDecoration(
                  labelText: 'teacher id', icon: Icon(Icons.email)),
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              onSaved: (val){
                _p = val;
              },
              onChanged: (val){
                setState(() {
                  _p =val;
                });
              },
              controller: password,
              obscureText: true,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                  labelText: 'password', icon: Icon(Icons.security)),
            ),
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RaisedButton(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () async {

                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text)
                      .then((AuthResult result) {
                        print(result.user);
                        
                        Navigator.push(context, MaterialPageRoute(

                          builder: (context)=>classBuilderScreen()
                        ));

                  })
                      .catchError((Error e) {

                        print(e.stackTrace.toString());
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
