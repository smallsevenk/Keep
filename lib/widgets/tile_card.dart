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
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
            child: Text(
              '$content',
              style: TextStyle(
                  color: Color(0xff343434),
                  fontSize: ScreenUtil().setSp(34),
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                bottom: ScreenUtil().setWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(60),
                      height: ScreenUtil().setWidth(60),
                      // color: Colors.red,
                    ),
                    Positioned(
                      width: ScreenUtil().setWidth(56),
                      height: ScreenUtil().setWidth(56),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('$avatar'),
                        radius: ScreenUtil().setWidth(28),
                      ),
                    ),
                    isVip
                        ? Positioned(
                            width: 12,
                            height: 12,
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                          )
                        : Text(''),
                    isVip
                        ? Positioned(
                            width: 10,
                            height: 10,
                            bottom: 1,
                            right: 1,
                            child: CircleAvatar(
                              backgroundImage: AssetImage('imgs/vip.png'),
                              // radius: ScreenUtil().setWidth(28),
                            ),
                          )
                        : Text(''),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                  width: ScreenUtil().setWidth(230),
                  child: Text(
                    '$name',
                    style: TextStyle(
                      color: Color(0xff343434),
                      fontSize: ScreenUtil().setSp(25),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(65)),
                    child: Image.asset('imgs/like.png'),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    child: Text(
                      '$likes',
                      style: TextStyle(
                        color: Z6Color.kgray,
                        fontSize: ScreenUtil().setSp(25),
                      ),
                    ),
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
