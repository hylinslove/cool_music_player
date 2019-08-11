import 'package:flutter/material.dart';
import 'package:cool_music_player/base/constant.dart';
import 'package:cool_music_player/entity/songEntity.dart';

class SongListItem extends StatefulWidget {

  final List<SongEntity> songList;
  final int index;
  final Function onTap;

  SongListItem({this.songList, this.index,this.onTap});

  @override
  _SongListItemState createState() => _SongListItemState();
}

class _SongListItemState extends State<SongListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Constant.PINK,
      splashColor: Constant.PINK,
      onTap: () {
        widget.onTap();
      },
      child: Container (

        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 40,
              child: Text(
                widget.index.toString(),
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
                    widget.songList[widget.index].name,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFFFDDDD)
                    ),
                  ),
                  Text(
                    widget.songList[widget.index].arName+"-"
                        +widget.songList[widget.index].alName,
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
  }
}

