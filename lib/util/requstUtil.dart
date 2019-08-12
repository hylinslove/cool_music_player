import 'package:cool_music_player/entity/bannerEntity.dart';
import 'package:cool_music_player/util/httpUtil.dart';
import 'package:cool_music_player/entity/playListEntity.dart';
import 'package:cool_music_player/entity/songEntity.dart';

class RequestUtil {
  static Future<List<BannerEntity>> getBannerData() async {
    Map<String, dynamic> data =
        await HttpUtil.get("http://musicapi.leanapp.cn/banner?type=1");
    if (data['msg'] == "success") {
      List listData = data['banners'];
      List<BannerEntity> banners = listData.map((s) {
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

  static Future<List<PlayListEntity>> getPlayList(String type) async {
    Map<String, String> param = {'limit': '30', 'order': type};
    Map<String, dynamic> data = await HttpUtil.get("musicapi.leanapp.cn",
        path: "/top/playlist", param: param);
    if (data['msg'] == "success") {
      List listData = data['playlists'];
      List<PlayListEntity> playList = listData.map((s) {
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
      List<SongEntity> songList = listData.map((s) {
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

  static Future<List<String>> getHotWords() async {
    Map<String, dynamic> data = await HttpUtil.get("http://musicapi.leanapp.cn/search/hot",);
    if (data['msg'] == "success") {
      List listData = data['result']['hots'];
      List<String> wordList = listData.map((s) {
        return s['first'].toString();
      }).toList();

      return wordList;
    } else {
      return List();
    }
  }


  static Future<List<SongEntity>> getSearchResult(String keyWord) async {
    Map<String, String> param = {'keywords': keyWord};
    Map<String, dynamic> data = await HttpUtil.get("musicapi.leanapp.cn",
        path: "/search/suggest", param: param);
    if (data['msg'] == "success") {
      List listData = data['result']['songs'];
      List<SongEntity> songList = listData.map((s) {
        return SongEntity(
            id: s['id'].toString(),
            name: s['name'].toString(),
            alName: s['album']['name'].toString(),
            arName: s['artists'][0]['name'].toString(),
            picUrl: s['album']['img1v1Url'].toString()

        );
      }).toList();

      return songList;
    } else {
      return List();
    }
  }
}
