import 'package:flutter/material.dart';
import 'package:cool_music_player/widget/bannerView.dart';
import 'package:cool_music_player/util/requstUtil.dart';
import 'package:cool_music_player/entity/bannerEntity.dart';
import 'package:cool_music_player/entity/playListEntity.dart';
import 'package:cool_music_player/widget/playListGirdView.dart';
import 'package:cool_music_player/base/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:cool_music_player/page/playListPage.dart';

class FindPage extends StatefulWidget  {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin {

  List<BannerEntity> _banners;
  List<PlayListEntity> _playList;

  @override
  void initState() {
    _banners = [
      BannerEntity(picUrl: "http://p1.music.126.net/LXyOAfUKeeUTCfrEUM22HQ==/109951164277643563.jpg"),
    ];
    _playList = [];
    getBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Constant.MAIN ,
      child: ListView (
        shrinkWrap: true,
        controller: ScrollController(),
        children: <Widget>[
          BannerView(banners: _banners,),
          Container(margin:EdgeInsets.all(10), height: 0.5, ),
          Text("  推荐歌单"),
          Container(
//            color: Colors.deepPurple,

            child: PlayListGridView(
              playList: _playList,
              onTap: (index) {
                Navigator.of(context).push(
                    new CupertinoPageRoute(
                        builder: (BuildContext context) => PlayListPage(playList: _playList[index])));
              },
            )

          ),
        ],
      ),
    );
  }

  void getBanner() async {

      print("update state");
      var newBanner = await RequestUtil.getBannerData();
      setState(() {
        _banners = newBanner;
      });

      var newList = await RequestUtil.getPlayList();
      setState(() {
        _playList = newList;
      });

  }

  @override
  bool get wantKeepAlive => true;
}
