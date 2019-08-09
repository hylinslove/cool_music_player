import 'package:flutter/material.dart';
import 'myPage.dart';
import 'findPage.dart';

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
          actions: <Widget>[Icon(Icons.search)],
        ),
        body: TabBarView(
          children: <Widget>[
            MyPage(),
            FindPage()
          ],
        ),
        bottomNavigationBar: Container(
          height: 70,
          color: Colors.black,
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
