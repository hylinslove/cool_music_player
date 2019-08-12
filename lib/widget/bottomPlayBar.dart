import 'package:flutter/material.dart';
import 'package:cool_music_player/base/constant.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cool_music_player/entity/playingEntity.dart';
import 'package:cool_music_player/entity/songEntity.dart';

class BottomPlayBar extends StatefulWidget {
  final PlayingEntity playingEntity;

  BottomPlayBar({this.playingEntity});

  @override
  _BottomPlayBarState createState() => _BottomPlayBarState();
}

class _BottomPlayBarState extends State<BottomPlayBar> {
  final AudioPlayer player = Constant.audioPlayer;
//  bool isPlaying = false;
//  IconData playIcon = Icons.play_circle_filled;
  
  @override
  void initState() {
    print("-----------------------------bottom bar init state");
    super.initState();
  }
  
//  IconData pauseIcon = Icons.pause;
  
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.black,
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: ClipOval(
                child: Image.network(
                  widget.playingEntity.songEntity.picUrl,
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text(widget.playingEntity.songEntity.name+
                      " -- "+widget.playingEntity.songEntity.arName,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: LinearProgressIndicator(
                    backgroundColor: Color(0x33FFFFFF),
                    value: 0.0,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Constant.PINK),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  if (!widget.playingEntity.isPlaying) {
                    play();
                  } else {
                    pause();
                  }
                },
                child: Icon(
                  widget.playingEntity.isPlaying
                      ?Icons.pause
                      :Icons.play_circle_filled,
                  color: Constant.PINK,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  play() async {
    var result = await player
        .play("https://music.163.com/song/media/outer/url?id=${widget.playingEntity.songEntity.id}.mp3");

    print("plyay");
    setState(() {
      Constant.playingEntity.isPlaying = true;
    });
    widget.playingEntity.isPlaying = true;

    return result;
  }

  pause() async {
    var result = await player.pause();
    int i = await player.getDuration();
    int i2 = await player.getCurrentPosition();

//    print("duration: " + i.toString());
//    print("current duration:"+i2.toString());
//    print("pause");
    setState(() {
      Constant.playingEntity.isPlaying = false;
    });
    widget.playingEntity.isPlaying = false;

    return result;
  }
}
