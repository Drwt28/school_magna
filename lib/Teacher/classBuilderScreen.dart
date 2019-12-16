import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class classBuilderScreen extends StatefulWidget {
  @override
  _classBuilderScreenState createState() => _classBuilderScreenState();
}

class _classBuilderScreenState extends State<classBuilderScreen> {

  List<bool> CheckList = [];
  ScrollController controller;
  String email;



  @override
   initState() {

     FirebaseAuth.instance.currentUser().then((FirebaseUser user){
      setState(() {
        email = user.email;
      });


    });

    super.initState();

    controller = ScrollController();

  }
 Future<List> getData() async {



    List<String> list=[
    ];

    String data ="name";
    CollectionReference ref = Firestore.instance.collection('books');
       
    await ref.getDocuments().then((QuerySnapshot snapshots){
      
      for(DocumentSnapshot snapshot in snapshots.documents)
        {
          list.add(snapshot.data['author']);
        }

      return list;
    }).catchError((e){

      print(e);
    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),

      body: Column(
        children: <Widget>[

          Flexible(
            
            child: Text(
              email,
              style: TextStyle(
                color: Colors.black
                    ,fontSize: 20
              ),
            ),
          ),

          TextFormField(
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Name'
            ),
          )

          ,Flexible(
            child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance.collection('schoolsTest')
              .document("school_1").snapshots(),
              builder: (context,snapshot)
              {
                if (!snapshot.hasData) return Text('Loading');

                return buildCheckBox(snapshot.data.data['subjectList']);
              },
            )


          )



        ],
      ),
    );
  }

  Widget buildCheckBox(List list)
  {

    for(var c in list)
      {
        CheckList.add(false);
      }

    return ListView.builder(

        controller: controller,

        itemCount: list.length,
        itemBuilder: (context,i){

      return CheckboxListTile(

       title: Text(list[i],style: TextStyle(
         fontSize: 17
             ,color: Colors.black
       ),)

       ,value: CheckList[i],
        onChanged: (val)
        {

          setState(() {
            CheckList.insert(i, val);


          });

        },
      );

    });
  }

}
