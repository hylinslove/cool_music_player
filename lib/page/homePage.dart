import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'myPage.dart';
import 'findPage.dart';
import 'package:cool_music_player/widget/bottomPlayBar.dart';
import 'package:cool_music_player/base/constant.dart';
import 'package:cool_music_player/page/searchPage.dart';

final List<String> tabTitles = <String>["我的", "发现"];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold (
        appBar: AppBar(
          centerTitle: true,
          title: TabLayout(),
          titleSpacing: 30 ,
          leading: Icon(Icons.music_note),
          actions: <Widget>[
            IconButton(
              icon:Icon(Icons.search),
              onPressed: (){
                Navigator.of(context).push(
                    new CupertinoPageRoute(
                        builder: (BuildContext context) => SearchPage())
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            MyPage(onPlay: (playingSong) {
              setState(() {
                Constant.playingEntity = playingSong;
              });
            },),
            FindPage()
          ],
        ),
        bottomNavigationBar: BottomPlayBar(
          playingEntity: Constant.playingEntity,
        ) ,
      ),
      length: tabTitles.length,
    );
  }
}

class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabTitles.map((String title) => Tab(
                text: title,
              ))
          .toList(),

    );
  }
}
