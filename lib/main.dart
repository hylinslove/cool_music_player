import 'package:flutter/material.dart';
import 'page/homePage.dart';
import 'dart:core';
import 'dart:async';
import 'base/constant.dart';
import 'util/httpUtil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          backgroundColor: Colors.black,
          primaryColor: Colors.black,
          primaryColorDark: Colors.black,
          accentColor: Constant.PINK,
          textTheme: TextTheme(
            //
            body1: TextStyle(color: Color(0xFFededed), fontSize: 16.0),
          ),
          iconTheme: IconThemeData(
            color: Constant.PINK,
            size: 35.0,
          )),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var seconds = 4;
  var hitText = "";

  @override
  void initState() {
    super.initState();

    _getHit();

    Timer(Duration(seconds: seconds), () {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Constant.screenWidth = MediaQuery.of(context).size.width;
    Constant.screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              "COOL MUSIC",
              style: TextStyle(
                  color: Constant.PINK,
                  fontSize: 42,
                  decoration: TextDecoration.none),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(50),
              child: Text(
                hitText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    decoration: TextDecoration.none),
              ) ,
            ),
          )
        ],
      )
    );
  }

  void _getHit() async {
    Map<String, dynamic> result =
        await HttpUtil.get("https://international.v1.hitokoto.cn/");
    print(result['msg']);
    if (result['msg'].toString() == "success" && mounted) {
      setState(() {
        hitText = "\"${result['hitokoto']}\"  -- 【${result['from']}】";
      });
    }
  }
}
