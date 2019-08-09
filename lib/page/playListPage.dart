import 'package:flutter/material.dart';
import 'package:cool_music_player/entity/playListEntity.dart';
import 'package:cool_music_player/base/constant.dart';
import 'dart:ui';
import 'package:cool_music_player/entity/songEntity.dart';
import 'package:cool_music_player/util/requstUtil.dart';

class PlayListPage extends StatefulWidget {
  final PlayListEntity playList;

  const PlayListPage({Key key, this.playList}) : super(key: key);

  @override
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {

  List<SongEntity> _songList;

  @override
  void initState() {
    _songList = [];
    getSongList(widget.playList.id);
    print(widget.playList.name);
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
                  child: ListView.builder(
                    itemCount: _songList.length,
                    itemBuilder: (context,index) {

                      return InkWell(
                        onTap: () {
                          print(index.toString());
                        },
                        child: Container (
                          color: Color(0x66000000),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 40,
                                child: Text(
                                  index.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Constant.PINK,
                                  ),
                                ),

                              ),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _songList[index].name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFFFFDDDD)
                                      ),
                                    ),
                                    Text(
                                      _songList[index].arName+"-"+_songList[index].alName,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFFFDDDD)
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 70,
      ),
    );
  }

  void getSongList(String id) async {
    var newList = await RequestUtil.getPlayListDetail(id);

    setState(() {
      _songList = newList;
    });
  }


}
