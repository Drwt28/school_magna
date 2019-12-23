import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homeworkPage extends StatefulWidget {
  @override
  _homeworkPageState createState() => _homeworkPageState();
}

class _homeworkPageState extends State<homeworkPage> {

  File _image;

  int selectedImage=0;

  Map<String,dynamic> subjectImage =Map();

  List<String> subList = ['Hindi','English','Mathematics'];

  List<File> subImageList =[null,null,null];




  Future getImageCamera(int i) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;

      subImageList[i] = image;
    });
  }
  Future getImageGallery(int i) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      subImageList[i] = image;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var pref = Provider.of<SharedPreferences>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Remark'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Flexible(
                flex: 1,
                child: buildTopBox()),

            Flexible(
              flex: 6,
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 80),
                  itemCount: subList.length,
                  itemBuilder: (context,i){
                return AnimatedContainer(
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          child: buildHomeWorkListTile(i, 'Subject Name')),
                    ),
                  ),
                );
              })
            ),
          ],
        )
        ,persistentFooterButtons: <Widget>[

          CupertinoButton(
            child: Text('Send Homework'),
            onPressed: (){},
            color: Colors.blue,
          )
    ],
    );
  }
  Widget buildTopBox() {
    return Hero(
      tag: 'homework',
      child: Image(
        image: AssetImage('assets/teacher/homework.png'),
      ),
    );
  }

  Widget buildHomeWorkListTile(int i,String SubName)
  {
    return ListTile(
      title: subImageList[i]==null?Text(i.toString()+'\t' + SubName):Center(child: SizedBox(height: 200,width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Flexible(
            flex: 1,
            child: Text(i.toString()+'\t' + SubName)),Flexible(
            flex: 5,
            child: Image.file((subImageList[i])))],
      ),)),
      isThreeLine: true,
      contentPadding: EdgeInsets.all(5),
      subtitle: TextField(decoration: InputDecoration(
          labelText: 'enter homework '
      ),),

      trailing: SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: subImageList[i]!=null?IconButton(color: Colors.blue,icon: Icon(Icons.delete),
          onPressed: (){
            setState(() {

              subImageList[i]=null;
            });
          },):Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                onPressed: (){
                getImageCamera(i);
                },
                icon: Icon(Icons.camera_enhance),
                color: Colors.blue,
              ),IconButton(
                onPressed: (){
                getImageGallery(i);
                },
                icon: Icon(Icons.image),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );

  }

  buildHomeworkImagePreview()
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Container(

          decoration: BoxDecoration(
              color: Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(10)

          ),
          child: Image.file(_image,fit: BoxFit.fitWidth,width: 200,),
        ),

      ),
    );
  }
}
