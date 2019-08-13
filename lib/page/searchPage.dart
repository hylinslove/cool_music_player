import 'package:flutter/material.dart';
import 'package:cool_music_player/widget/bottomPlayBar.dart';
import 'package:cool_music_player/base/constant.dart';
import 'package:cool_music_player/util/requstUtil.dart';
import 'package:cool_music_player/widget/visibilityWidget.dart';
import 'package:cool_music_player/widget/songListItem.dart';
import 'package:cool_music_player/entity/songEntity.dart';
import 'package:cool_music_player/entity/playingEntity.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _controller =  TextEditingController();
  List<Widget> _hotWords = [];
  List<SongEntity> _songList;
  int _isVisible = VisibilityWidget.VISIBLE;

  var _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _songList = [];
    getHotSearch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Constant.MAIN,
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: Colors.white,
          ),

          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextField(
            decoration: InputDecoration(),
            controller: _controller,
            focusNode: FocusNode(),
            style:TextStyle(
              color: Constant.MAIN,
            ) ,
            cursorColor: Constant.PINK,

          ),
        ),
      ),
      body:Column(
        children: <Widget>[
          VisibilityWidget(
            visibility: _isVisible,
            removeChild: Container(
              width: 0,
              height: 0,
            ),
            child: Container(
              width: Constant.screenWidth,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "热门搜索:",
                    style: TextStyle(
                      color: Constant.PINK,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _hotWords,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child:Container(
//              color: Color(0x66000000),
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
      floatingActionButton:FloatingActionButton(
        onPressed:() {
          print(_controller.text);

          if(_controller.text == null || _controller.text == "") {

            var snackBar = SnackBar(content: Text("关键字不能为空 😊"));
            _scaffoldkey.currentState.showSnackBar(snackBar);

          } else {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              _isVisible = VisibilityWidget.GONE;
            });
            getSearchResult(_controller.text);
          }

        },
        child: Icon(Icons.search),

      ) ,
      bottomNavigationBar: BottomPlayBar(
        playingEntity: Constant.playingEntity,
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
      Constant.playingEntity = playingEntity;
    });

  }

  void getHotSearch() async {
    List<String> word = await RequestUtil.getHotWords();
    print(word.toString());
    List<Widget> hotWordWights = [];
    word.forEach((s) {
      hotWordWights.add(FlatButton(
        onPressed: ( ) {
          _controller.text = s;

        },
        highlightColor: Constant.TEXT_COLOR,
        textColor: Constant.TEXT_COLOR,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Constant.TEXT_COLOR,
            width: 0.7,
          ),
          borderRadius: BorderRadius.circular(8),),
        child: Text(
          s,
          style:TextStyle(
            fontSize: 12
          ) ,
        ),
      ));
    });

    if(hotWordWights.length > 0) {
      setState(() {
        _hotWords = hotWordWights;
      });
    }
    
  }

  void getSearchResult(String keyWord) async {
    var newList = await RequestUtil.getSearchResult(keyWord);

    setState(() {
      _songList = newList;
    });

  }
}
