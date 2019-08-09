import 'package:cool_music_player/entity/bannerEntity.dart';
import 'package:cool_music_player/util/httpUtil.dart';
import 'package:cool_music_player/entity/playListEntity.dart';
import 'package:cool_music_player/entity/songEntity.dart';

class RequestUtil {
  static Future<List<BannerEntity>> getBannerData() async {
    Map<String, dynamic> data =
        await HttpUtil.get("http://musicapi.leanapp.cn/banner");
    if (data['msg'] == "success") {
      List listData = data['banners'];
      print("遍历" + listData.toString());
      List<BannerEntity> banners = listData.map((s) {
        print(s);
        return BannerEntity(
            picUrl: s['picUrl'],
            url: s['url'],
            targetId: s['targetId'],
            targetType: s['targetType']);
      }).toList();

      return banners;
    } else {
      return List();
    }
  }

  static Future<List<PlayListEntity>> getPlayList() async {
    Map<String, String> param = {'limit': '20', 'order': 'hot'};
    Map<String, dynamic> data = await HttpUtil.get("musicapi.leanapp.cn",
        path: "/top/playlist", param: param);
    if (data['msg'] == "success") {
      List listData = data['playlists'];
      print("遍历" + listData.toString());
      List<PlayListEntity> playList = listData.map((s) {
        print(s);
        return PlayListEntity(
            coverImgUrl: s['coverImgUrl'].toString(),
            name: s['name'].toString(),
            description: s['description'].toString(),
            id: s['id'].toString(),
            playCount: s['playCount'].toString(),
            trackCount: s['trackCount'].toString());
      }).toList();

      return playList;
    } else {
      return List();
    }
  }

  static Future<List<SongEntity>> getPlayListDetail(String id) async {
    Map<String, String> param = {'id': id};
    Map<String, dynamic> data = await HttpUtil.get("musicapi.leanapp.cn",
        path: "/playlist/detail", param: param);
    if (data['msg'] == "success") {
      List listData = data['playlist']['tracks'];
      print("遍历" + listData.toString());
      List<SongEntity> songList = listData.map((s) {
        print(s);
        return SongEntity(
          id: s['id'].toString(),
          name: s['name'].toString(),
          alName: s['al']['name'].toString(),
          arName: s['ar'][0]['name'].toString(),
          picUrl: s['al']['picUrl'].toString()

        );
      }).toList();

      return songList;
    } else {
      return List();
    }
  }
}
