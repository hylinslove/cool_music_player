import 'package:cool_music_player/util/dbUtil.dart';
import 'package:flutter/material.dart';
import 'package:cool_music_player/entity/playListEntity.dart';
import 'package:cool_music_player/base/constant.dart';
import 'dart:ui';
import 'package:cool_music_player/entity/songEntity.dart';
import 'package:cool_music_player/util/requstUtil.dart';
import 'package:cool_music_player/widget/bottomPlayBar.dart';
import 'package:cool_music_player/entity/playingEntity.dart';
import 'package:cool_music_player/widget/songListItem.dart';

class PlayListPage extends StatefulWidget {
  final PlayListEntity playList;

  const PlayListPage({Key key, this.playList}) : super(key: key);

  @override
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {

  List<SongEntity> _songList;
  PlayingEntity _playingEntity;

  @override
  void initState() {
    _songList = [];
    _playingEntity = Constant.playingEntity;
    getSongList(widget.playList.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("歌单详情"),
      ),
      body: Container(

        color: Constant.MAIN,
        child: Stack(
          children: <Widget>[
            Image.network(
              widget.playList.coverImgUrl,
              scale: 0.01,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              child: Container(
                color: Color(0x77000000),
              ),
            ),

            Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.all(10),

                            child: Hero(
                                tag: widget.playList.id,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  child: Image.network(widget.playList.coverImgUrl),
                                )),
                          )),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.playList.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xccFFFFFF),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                widget.playList.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0x55FFFFFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ),
                Expanded(
                  flex: 5,
                  child:Container(
                    color: Color(0x66000000),
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomPlayBar(
        playingEntity: _playingEntity,
      ),
    );
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
    setState(() {
      _playingEntity = playingEntity;
      Constant.playingEntity = playingEntity;
    });
    DbUtil.instance.insert(songEntity.id, songEntity.name, songEntity.arName, songEntity.alName, songEntity.picUrl);
  }

  void getSongList(String id) async {
    var newList = await RequestUtil.getPlayListDetail(id);

    setState(() {
      _songList = newList;
    });
  }


}
