import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,

      children: <Widget>[

        Flexible(
          flex: 1,
          child: SizedBox(
            height: 120,
            width: 120,
            child: buildTopBox(),
          ),
        )
        ,
        Flexible(
          flex: 6,
          child:  AnimatedContainer(
            duration: Duration(seconds: 2),
            height: MediaQuery.of(context).size.height*0.5,

            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Notice'

                    ),
                    style: TextStyle(
                      fontSize: 18

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    onPressed: (){

                    },
                    child: Text('Send'),
                    textColor: Colors.white,

                    color: Colors.blue,


                  ),
                )
              ],
            ),


          )
        ),
      ],
    )

    );
  }
  Widget buildTopBox() {
    return Hero(
      tag: 'notice',
      child: Image(
        image: AssetImage('assets/teacher/notice.png'),
      ),
    );
  }
}
