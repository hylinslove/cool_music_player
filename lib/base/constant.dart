import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cool_music_player/entity/playingEntity.dart';
import 'package:cool_music_player/entity/songEntity.dart';


class Constant{
  static const Color PINK = Color(0xFFE91E63);
  static const Color MAIN = Color(0xCC000000);

  static double screenWidth ;
  static double screenHeight ;

  static const String BASE_URL = "http://musicapi.leanapp.cn/";

  static PlayingEntity playingEntity = PlayingEntity(
      isPlaying: false,
      songEntity: SongEntity(
          name:"胖胖之歌",
          arName: "馒头",
          id: "493700144",
          alName: "胖胖之歌",
          picUrl: "http://p2.music.126.net/cz7nfpFM8420bZ-A26JT_Q==/109951162986551563.jpg"
      )
  );
  static final AudioPlayer audioPlayer = AudioPlayer();
}