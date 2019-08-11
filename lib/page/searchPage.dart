import 'package:flutter/material.dart';
import 'package:cool_music_player/widget/bottomPlayBar.dart';
import 'package:cool_music_player/base/constant.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _controller =  TextEditingController();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.MAIN,
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: Colors.white,
          ),

          margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
          child: TextField(

            controller: _controller,
            focusNode: FocusNode(),
            style:TextStyle(
              color: Constant.MAIN,
            ) ,
            cursorColor: Constant.PINK,

          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "热门搜索:",
              style: TextStyle(
                color: Constant.PINK,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                FlatButton(
                  onPressed: ( ) {
                    print("hahah");
                  },
                  highlightColor: Constant.PINK,
                  textColor: Constant.PINK,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Constant.PINK,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),),
                  child: Text("来自天堂的魔鬼"),
                ),
                Text("cc"),
                Text("adf"),
                Text("adsfadfadf"),
                Text("adfadf"),
                Text("adfadf"),
                Text("adsfadfadfadsf"),
                Text("adsf"),
                Text("adfasdfadsfasdfasdfasd"),
              ],
            )
          ],
        ),
      ),

      bottomNavigationBar: BottomPlayBar(
        playingEntity: Constant.playingEntity,
      ),
    );
  }
}
