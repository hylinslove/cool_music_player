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

  Color labelColorNew = Constant.PINK;
  Color labelColorHot = Colors.white70;

  @override
  void initState() {
    _banners = [
      BannerEntity(picUrl: "http://p1.music.126.net/LXyOAfUKeeUTCfrEUM22HQ==/109951164277643563.jpg"),
    ];
    _playList = [];
    getBanner();
    getPlayList('new');
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
          Row(
            children: <Widget>[
              Text("  推荐歌单"),
              GestureDetector(
                onTap: (){
                  if(labelColorNew != Constant.PINK) {
                    labelColorNew = Constant.PINK;
                    labelColorHot = Colors.white70;
                    getPlayList('new');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: labelColorNew,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.fromLTRB(15,5,0,5),
                  child:Text(
                    " 最 新 ",
                    style: TextStyle(
                      fontSize: 12,
                      color: labelColorNew,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(labelColorHot != Constant.PINK) {
                    labelColorHot = Constant.PINK;
                    labelColorNew = Colors.white70;
                    getPlayList('hot');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: labelColorHot,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.fromLTRB(15,5,0,5),
                  child:Text(
                    " 最 热 ",
                    style: TextStyle(
                      fontSize: 12,
                      color: labelColorHot,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Container(
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

      var newBanner = await RequestUtil.getBannerData();
      setState(() {
        _banners = newBanner;
      });


  }
  void getPlayList(String type) async {

    var newList = await RequestUtil.getPlayList(type);
    setState(() {
      _playList = newList;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
