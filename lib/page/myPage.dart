import 'package:flutter/material.dart';
import 'package:cool_music_player/base/constant.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color:Constant.MAIN ,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
