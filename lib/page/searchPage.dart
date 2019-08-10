import 'package:flutter/material.dart';
import 'package:cool_music_player/widget/bottomPlayBar.dart';
import 'package:cool_music_player/base/constant.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: Colors.white,
          ),

          margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
          child: TextField(

            controller: TextEditingController(
            ),
            focusNode: FocusNode(),
            style:TextStyle(
              color: Constant.MAIN,
            ) ,
            cursorColor: Constant.PINK,

          ),
        ),
      ),
      body: Container(
        color: Constant.MAIN,

      ),
      bottomNavigationBar: BottomPlayBar(
        playingEntity: Constant.playingEntity,
      ),
    );
  }
}
