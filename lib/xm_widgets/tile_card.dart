import 'package:flutter/material.dart';

import '../public.dart';

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
            padding: EdgeInsets.symmetric(horizontal: xmDp(10)),
            margin: EdgeInsets.symmetric(vertical: xmDp(5)),
            child: Text(
              '$content',
              style: TextStyle(
                  color: Color(0xff343434),
                  fontSize: ScreenUtil().setSp(24),
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: xmDp(10), bottom: xmDp(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: xmDp(28),
                      height: xmDp(28),
                      // color: Colors.red,
                    ),
                    Positioned(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('$avatar'),
                        radius: xmDp(30),
                      ),
                    ),
                    isVip
                        ? Positioned(
                            width: xmDp(30),
                            height: xmDp(30),
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                          )
                        : Text(''),
                    isVip
                        ? Positioned(
                            width: xmDp(28),
                            height: xmDp(28),
                            bottom: xmDp(1),
                            right: xmDp(1),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('res/imgs/vip.png'),
                              // radius: xmDp(28),
                            ),
                          )
                        : Text(''),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: xmDp(10)),
                  width: xmDp(220),
                  child: Text(
                    '$name',
                    style: TextStyle(
                      color: Color(0xff343434),
                      fontSize: ScreenUtil().setSp(20),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: xmDp(10)),
                        width: xmDp(40),
                        height: xmDp(40),
                        child: Image.asset('res/imgs/like.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: xmDp(10)),
                        child: Text(
                          '$likes',
                          style: TextStyle(
                            color: XMColor.kgray,
                            fontSize: ScreenUtil().setSp(20),
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
