import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/base/color.dart';

class TileCard extends StatelessWidget {
  final String img;
  final String content;
  final String avatar;
  final String name;
  final String likes;
  final bool isVip;
  TileCard(
      {this.img, this.content, this.avatar, this.name, this.likes, this.isVip});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new ClipRRect(
            child: CachedNetworkImage(
              imageUrl: '$img',
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
            child: Text(
              '$content',
              style: TextStyle(
                  color: Color(0xff343434),
                  fontSize: ScreenUtil().setSp(17),
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(10),
                bottom: ScreenUtil().setWidth(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(28),
                      height: ScreenUtil().setWidth(28),
                      // color: Colors.red,
                    ),
                    Positioned(
                      width: ScreenUtil().setWidth(26),
                      height: ScreenUtil().setWidth(26),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('$avatar'),
                        radius: ScreenUtil().setWidth(12),
                      ),
                    ),
                    isVip
                        ? Positioned(
                            width: ScreenUtil().setWidth(12),
                            height: ScreenUtil().setWidth(12),
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                          )
                        : Text(''),
                    isVip
                        ? Positioned(
                            width: ScreenUtil().setWidth(10),
                            height: ScreenUtil().setWidth(10),
                            bottom: ScreenUtil().setWidth(1),
                            right: ScreenUtil().setWidth(1),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('imgs/vip.png'),
                              // radius: ScreenUtil().setWidth(28),
                            ),
                          )
                        : Text(''),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                  width: ScreenUtil().setWidth(220),
                  child: Text(
                    '$name',
                    style: TextStyle(
                      color: Color(0xff343434),
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(5)),
                        width: ScreenUtil().setWidth(20),
                        height: ScreenUtil().setWidth(20),
                        child: Image.asset('imgs/like.png'),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                        child: Text(
                          '$likes',
                          style: TextStyle(
                            color: Z6Color.kgray,
                            fontSize: ScreenUtil().setSp(12),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
