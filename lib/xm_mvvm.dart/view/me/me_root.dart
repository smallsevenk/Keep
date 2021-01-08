import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../public.dart';
import 'me_data.dart';

class MePage extends StatefulWidget {
  MePage({Key key}) : super(key: key);

  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
      color: XMColor.bgGray,
      padding: EdgeInsets.all(0),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          _header(),
          _subHeader(),
          Container(
            color: XMColor.bgGray,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: <Widget>[
                _grayGap(),
                _keepVip(),
                _grayGap(),
                _mySportData(),
                _grayGap(),
                _myBodyData(),
                _grayGap(),
                _myList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _grayGap() {
    return Container(color: XMColor.bgGray, height: 10, width: Screen.width);
  }

  _header() {
    Map user = meData['data']['user'];
    List headerFooters = user['userStatisticsList'];
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: XMColor.black_3),
      child: Column(
        children: <Widget>[
          SizedBox(height: 40),
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
                  'res/imgs/me_appbar_setting.png',
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
                        'res/imgs/me_appbar_scan.png',
                      )),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 25,
                      height: 25,
                      child: Image(
                          image: AssetImage(
                        'res/imgs/me_appbar_msg.png',
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
                      style: TextStyle(fontSize: 18, color: XMColor.vipColor),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Image(
                          height: 20,
                          image: AssetImage('res/imgs/me_header_hz.png'),
                        ),
                        SizedBox(width: 10),
                        Image(
                          height: 20,
                          image: AssetImage('res/imgs/me_header_kg.png'),
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
                        image: AssetImage('res/imgs/me_header_detail.png'),
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

  _subHeader() {
    List headEntry = meData['data']['headEntry'];
    return Container(
      color: Colors.white,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: headEntry.map((v) {
            return Row(
              children: <Widget>[
                SizedBox(height: 60),
                Container(
                  width: 23,
                  height: 23,
                  child: CachedNetworkImage(imageUrl: v['icon']),
                ),
                SizedBox(width: 10),
                Text(
                  v['name'],
                  style: TextStyle(fontSize: 12),
                )
              ],
            );
          }).toList()),
    );
  }

  _keepVip() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(children: <Widget>[
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Keep 会员',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 13),
            Text(
              '完成任务，即可获得现金奖励!',
              style: TextStyle(color: XMColor.gray, fontSize: 12),
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 80,
                child: Image(
                  image: AssetImage('res/imgs/me_vip_bg.png'),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  _mySportData() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 10, height: 50),
              Text(
                '我的运动数据',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 12,
                      child: Image(
                          image:
                              AssetImage('res/imgs/me_my_sport_data_gth.png')),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '有自动生成的数据',
                      style: TextStyle(fontSize: 12, color: XMColor.black_3),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 12,
                      child: Image(
                        image: AssetImage('res/imgs/comm_detail.png'),
                      ),
                    ),
                    SizedBox(width: 10)
                  ],
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('总运动'),
                      Text(' (分钟)',
                          style: TextStyle(color: XMColor.gray, fontSize: 12))
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('494', style: TextStyle(fontSize: 22)),
                  SizedBox(height: 20),
                ],
              ),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('本周消耗'),
                      Text(' (千卡)',
                          style: TextStyle(color: XMColor.gray, fontSize: 12))
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('1494', style: TextStyle(fontSize: 22)),
                  SizedBox(height: 20),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  _myBodyData() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 10, height: 50),
              Text(
                '我的身体数据',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Container(
                width: 20,
                child: Image(image: AssetImage('res/imgs/me_my_body_data.png')),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 12,
                      child: Image(
                        image: AssetImage('res/imgs/comm_detail.png'),
                      ),
                    ),
                    SizedBox(width: 10)
                  ],
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '178.0',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(' 身高 cm',
                          style: TextStyle(color: XMColor.gray, fontSize: 12))
                    ],
                  ),
                ],
              ),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '66.0',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(' 体重 kg',
                          style: TextStyle(color: XMColor.gray, fontSize: 12))
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  _myList() {
    List list = meData['data']['tabs'][0];
    return Column(
      children: list.map((v) {
        return InkWell(
            onTap: () {
              Toast.show(v['name']);
            },
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      Container(
                        width: 25,
                        child: CachedNetworkImage(
                          imageUrl: v['icon'],
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(v['name'], style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 12,
                              child: Image(
                                image: AssetImage('res/imgs/comm_detail.png'),
                              ),
                            ),
                            SizedBox(width: 10)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                _grayGap(),
              ],
            ));
      }).toList(),
    );
  }
}
