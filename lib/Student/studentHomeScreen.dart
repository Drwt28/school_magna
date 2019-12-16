import 'package:flutter/material.dart';

    class studentHome extends StatefulWidget {
      @override
      _studentHomeState createState() => _studentHomeState();
    }

    class _studentHomeState extends State<studentHome> {

      String title ="title";


      @override
      Widget build(BuildContext context) {
        return DefaultTabController(
          length: 3,

          initialIndex: 0,

          child: Scaffold(


            
            appBar: AppBar(


              elevation: 0,
              backgroundColor: Colors.white,


              primary: true,

              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home,color: Colors.yellow,),child: buildTab('Home', Colors.yellow),),
                  Tab(icon: Icon(Icons.receipt,color: Colors.blue,),child: buildTab('Result', Colors.blue)),
                  Tab(icon: Icon(Icons.report,color: Colors.green,),child: buildTab('Attendence', Colors.green)),
                ],
              ),
            ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),

        )

        );
      }

      Widget buildTab(String text,Color c)
      {
        return Text(text,style: TextStyle(
          color: c
              ,fontSize: 16
        ),);
      }


    }
