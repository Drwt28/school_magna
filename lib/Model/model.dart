import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomWidgets {
//teacher home pannel card

  static Widget teacherHomePannelCard(BuildContext context, String tit,
      String path, Color startColor, Color endColor) {
    return AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(4),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [startColor, endColor]),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image(
                    image: AssetImage(path),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  tit,
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }

  static Widget teacherHomePannelCardHero(BuildContext context, String tit,
      String path, Color startColor, Color endColor, String tag) {
    return AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(4),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [startColor, endColor]),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Hero(
                    tag: tag,
                    child: Image(
                      image: AssetImage(path),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  tit,
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }

//selection pannel card
  static Widget SelectionPannelCard(BuildContext context, String tit,
      String path, Color startColor, Color endColor) {
    return AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(30),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [startColor, endColor]),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Image(
                  image: AssetImage(path),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  tit,
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }

  static String getTimeFromString(DateTime time) {
    var now = time;
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);

    return formatted;
  }

  static Widget SchoolPannelCard(BuildContext context, String logo, String name,
      String address, Color startColor, Color endColor, int i) {
    return AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(30),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [startColor, endColor]),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(address)
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Hero(
                  tag: i,
                  child: Image(
                    image: NetworkImage(logo),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
