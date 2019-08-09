import 'package:flutter/material.dart';
import 'package:cool_music_player/entity/playListEntity.dart';

class PlayListGridView extends StatefulWidget {
  final List<PlayListEntity> playList;
  final Function onTap;

  PlayListGridView({this.playList, this.onTap});

  @override
  _PlayListGridViewState createState() => _PlayListGridViewState();
}

class _PlayListGridViewState extends State<PlayListGridView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.7),
          itemCount: widget.playList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 200,
              margin: EdgeInsets.all(5),
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Hero(
                        tag: widget.playList[index].id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.playList[index].coverImgUrl,
                            fit: BoxFit.cover,
                          ),
                        )
                    ),
                    Text(
                      widget.playList[index].name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xFFEEEEEE),
                          fontSize: 12,
                          decoration: null),
                    ),
                  ],
                ),
                onTap: () {
                  //点击事件
                  if(widget.onTap!=null) {
                    widget.onTap(index);
                  }
                },
              ),
            );
          },
        ));
  }
}
