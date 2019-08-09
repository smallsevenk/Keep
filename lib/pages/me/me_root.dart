import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/base/public.dart';
import 'package:keep/pages/me/me_data.dart';

class MePage extends StatefulWidget {
  MePage({Key key}) : super(key: key);

  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
      padding: EdgeInsets.all(0),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[_header()],
      ),
    );
  }

  _header() {
    Map user = meData['data']['user'];
    List headerFooters = user['userStatisticsList'];
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Z6Color.black_3),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              SizedBox(
                  width: 20,
                  height: Screen.navigationBarHeight - Screen.topSafeHeight),
              Container(
                width: 25,
                height: 25,
                child: Image(
                    image: AssetImage(
                  'imgs/me_appbar_setting.png',
                )),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 25,
                      height: 25,
                      child: Image(
                          image: AssetImage(
                        'imgs/me_appbar_scan.png',
                      )),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 25,
                      height: 25,
                      child: Image(
                          image: AssetImage(
                        'imgs/me_appbar_msg.png',
                      )),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 25),
            height: 100,
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: CachedNetworkImage(
                    width: 70,
                    height: 70,
                    imageUrl: user['avatar'],
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5),
                    Text(
                      user['username'],
                      style: TextStyle(fontSize: 18, color: Z6Color.vip_color),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Image(
                          height: 20,
                          image: AssetImage('imgs/me_header_hz.png'),
                        ),
                        SizedBox(width: 10),
                        Image(
                          height: 20,
                          image: AssetImage('imgs/me_header_kg.png'),
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image(
                        height: 16,
                        image: AssetImage('imgs/me_header_detail.png'),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: headerFooters.map((v) {
                return Column(children: <Widget>[
                  Text(
                    v['count'].toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    v['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ]);
              }).toList()),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
