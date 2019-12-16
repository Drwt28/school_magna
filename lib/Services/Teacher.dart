
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class teacher{

  String name;
  String id;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;





  Future login(id,pass) async
  {

    await FirebaseAuth.instance.signInWithEmailAndPassword(email: id, password: pass)
        .then((AuthResult result){

          if(result.user!=null)
            {
              return result.user;
            }
          else{
            return null;
          }
    }).catchError((e){
      print(e.toString());
      return null;
    });
  }


}