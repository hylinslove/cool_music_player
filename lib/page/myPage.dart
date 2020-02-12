import 'package:cool_music_player/entity/playingEntity.dart';
import 'package:cool_music_player/entity/songEntity.dart';
import 'package:cool_music_player/util/dbUtil.dart';
import 'package:cool_music_player/widget/songListItem.dart';
import 'package:flutter/material.dart';
import 'package:cool_music_player/base/constant.dart';

class MyPage extends StatefulWidget {
  final ValueChanged<PlayingEntity> onPlay;

  MyPage({this.onPlay});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin, WidgetsBindingObserver{

  List<SongEntity> _songList;


  @override
  void initState() {
    _songList = [];
    getPlayHistory();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed) {
      getPlayHistory();
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color:Constant.MAIN ,
      child: ListView.builder(
        itemCount: _songList.length,
        itemBuilder: (context,index) {

          return SongListItem(
            songList: _songList,
            index: index,
            onTap: (){
              playTheSong(_songList[index]);
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void getPlayHistory() async {
    List<SongEntity> songs = await DbUtil.instance.query();
    setState(() {
      _songList = songs;
    });
  }

  void playTheSong(SongEntity songEntity) async {
    if(Constant.playingEntity.isPlaying) {
      await Constant.audioPlayer.stop();
    }
    await Constant.audioPlayer.play("https://music.163.com/song/media/outer/url?id=${songEntity.id}.mp3");
    PlayingEntity playingEntity = PlayingEntity(
      isPlaying: true,
      songEntity: songEntity,
    );
    widget.onPlay(playingEntity);

    DbUtil.instance.insert(songEntity.id, songEntity.name, songEntity.arName, songEntity.alName, songEntity.picUrl);

  }
}
