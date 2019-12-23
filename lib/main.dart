import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_magna/Model/model.dart';
import 'package:school_magna/Teacher/functions/homeWork.dart';
import 'package:school_magna/Teacher/teacherHome.dart';
import 'package:school_magna/selectPanel.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      StreamProvider<FirebaseUser>.value(
        value: FirebaseAuth.instance.onAuthStateChanged,
      ),
      StreamProvider<SharedPreferences>.value(
          value: SharedPreferences.getInstance().asStream())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              textTheme: TextTheme(
                  title: TextStyle(fontSize: 18, color: Colors.black)),
              iconTheme: IconThemeData(color: Colors.black),
              actionsIconTheme: IconThemeData(color: Colors.black)),
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue, splashColor: Colors.indigo)),
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("School Magna"),
        textTheme: Theme.of(context).textTheme,
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("schools").snapshots(),
            builder: (context, snapshots) => (snapshots.data != null)
                ? buildSchoolListcard(snapshots.data.documents)
                : CircularProgressIndicator()),
      ),
    );
  }

  Widget buildSchoolListcard(List<DocumentSnapshot> documents) {
    SharedPreferences sharedPreferences =
        Provider.of<SharedPreferences>(context);

    return ListView.builder(
        controller: _scrollController,
        itemCount: documents.length,
        itemBuilder: ((context, i) {
          return GestureDetector(
              onTap: () {
                sharedPreferences
                    .setString("school", documents[i]['id'])
                    .then((bool val) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectionPanel(i)));
                });
              },
              child: CustomWidgets.SchoolPannelCard(
                  context,
                  documents[i]['logo'],
                  documents[i]['name'],
                  documents[i]['address'],
                  Colors.indigo,
                  Colors.blue,
                  i));
        }));
  }
}
