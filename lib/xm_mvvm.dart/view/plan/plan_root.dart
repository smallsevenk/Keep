import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../public.dart';
import 'plan_data.dart';

class PlanPage extends StatefulWidget {
  PlanPage({Key key}) : super(key: key);

  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _goToCurrDay(DateTime.now().day);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            '智能训练计划',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            SizedBox(width: 10),
            Container(
              width: 35,
              height: 35,
              child: IconButton(
                icon: Image.asset('res/imgs/sport_nav_right_wristband.png'),
                onPressed: () {
                  Toast.show('keep手环');
                },
              ),
            ),
            Container(
              width: 35,
              height: 35,
              child: IconButton(
                icon: Image.asset('res/imgs/sport_nav_right_search.png'),
                onPressed: () {
                  Toast.show('搜索');
                },
              ),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            _suitInprogress(),
            _grayGap(),
            _trainContent(),
            _grayGap()
          ],
        ),
      ),
    );
  }

  _suitInprogress() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Color(0xffeff9f6),
                borderRadius: BorderRadius.circular(30)),
            width: Screen.width - 15 * 2,
            height: 60,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                _teamers()[0],
                _teamers()[1],
                _teamers()[2],
                Positioned(
                  left: 110,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 30,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '我的计划监督小组',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          height: 20,
                          child: Text(
                            '7小时前训练',
                            style: TextStyle(
                                color: XMColor.light_kgray, fontSize: 10),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  child: Image(
                    width: 8,
                    height: 15,
                    image: AssetImage('res/imgs/comm_detail.png'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Screen.width,
            height: 80,
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: _dateView(),
            ),
          )
        ],
      ),
    );
  }

  _teamers() {
    List teams = [
      "http://static1.keepcdn.com/avatar/2019/07/11/20/13/367bafc8b2e7bd975d2723caa467ce73a368e512.jpg",
      "http://static1.keepcdn.com/avatar/2019/05/14/16/3d8e39f826f4a54f753b5613987dfbfcf55ef623.jpg",
      "http://static1.keepcdn.com/avatar/2019/06/25/20/599b7559d3bf7ee628a0730c9ed3e4e10553c25d.jpg"
    ];
    return teams.map((v) {
      double w = 35;
      int idx = teams.indexOf(v);
      double x = (w - 10) * (2 - idx.toDouble()) + 10;
      return Positioned(
        left: x,
        width: w,
        height: w,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )),
          child: CircleAvatar(
            backgroundImage: NetworkImage(v),
            radius: 20,
          ),
        ),
      );
    }).toList();
  }

  _dateView() {
    // return <Widget>[];
    DateTime currDt = DateTime.now();
    int days = _getDaysNum(currDt.year, currDt.month);
    List<Widget> dayItems = [];
    double itemWidth = Screen.width / 7;

    for (var i = 1; i <= days; i++) {
      DateTime dt = DateTime(currDt.year, currDt.month, i);
      String weekday = DateUtil.getZHWeekDay(dt);
      Widget item = Container(
        width: itemWidth,
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
              alignment: Alignment.center,
              child: Text(
                weekday.substring(2),
                style: TextStyle(
                    fontSize: 14,
                    color:
                        currDt.day == i ? Colors.black : XMColor.light_kgray),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: currDt.day == i ? Color(0xff554f5e) : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  child: Text(
                    i.toString(),
                    style: TextStyle(
                        color: currDt.day == i ? Colors.white : Colors.black,
                        fontSize: 10),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            )
          ],
        ),
      );
      dayItems.add(item);
    }
    return dayItems;
  }

  //滚动到当前日期
  _goToCurrDay(int day) {
    if (_scrollController.hasClients) {
      day = day == 1 ? 1 : day - 1;
      double x = day * (Screen.width / 7);
      _scrollController.animateTo(x,
          duration: new Duration(seconds: 2), curve: Curves.ease);
    }
  }

  /*根据年份月份获取当前月有多少天*/
  int _getDaysNum(int y, int m) {
    if (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
      return 31;
    } else if (m == 2) {
      if (((y % 4 == 0) && (y % 100 != 0)) || (y % 400 == 0)) {
        //闰年 2月29
        return 29;
      } else {
        //平年 2月28
        return 28;
      }
    } else {
      return 30;
    }
  }

  String _getVideoTime(seconds) {
    seconds = 80.0;
    int min = seconds ~/ 60;
    double sec = seconds % 60;
    int s = sec.toInt();
    return '$min:$s';
  }

  //训练内��������������������������������������
  _trainContent() {
    Map task = planData['data']['sections'][0]['suit']['days'][0];
    return Center(
      child: Container(
        width: Screen.width - 20,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '今日训练',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '今天是计划的第 7 天，你的训练任务已完成 7 / 30 天',
                      style:
                          TextStyle(fontSize: 12, color: XMColor.light_kgray),
                      textAlign: TextAlign.left,
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 25),
            _teamCell(0),
            _teamCell(1),
            SizedBox(height: 15),
            Divider(
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      task['suitTip']['subTitle'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              image: DecorationImage(
                                  image: NetworkImage(task['suitTip']['cover']),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '有没有安全又有效的减肥药',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 25),
                            Text(
                              _getVideoTime(80),
                              style: TextStyle(
                                  fontSize: 12, color: XMColor.light_kgray),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _teamCell(idx) {
    List task = planData['data']['sections'][0]['suit']['days'][0]['tasks'][0]
        ['todoList'];
    Map info = task[idx];
    return InkWell(
      onTap: () {
        setState(() {
          String flag = info['flag'];
          info['flag'] = flag == '1' ? '0' : '1';
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
        height: 80,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                  image: NetworkImage(info['picture']), fit: BoxFit.cover)),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 20,
                height: 60,
              ),
              Container(
                width: 20,
                height: 20,
                child: Image.asset('res/imgs/sport_check_${info['flag']}.png'),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Color(0xffe9d399),
                        borderRadius: BorderRadius.circular(3)),
                    child: Text(
                      '会员精讲',
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                  Text(
                    info['name'],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    '${info['duration']}分钟',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // _sectionView(title, bool showDetail) {
  //   return InkWell(
  //     onTap: () {},
  //     child: Row(
  //       children: <Widget>[
  //         SizedBox(
  //           width: ScreenUtil().setWidth(28),
  //           height: ScreenUtil().setWidth(78),
  //         ),
  //         Text(
  //           title,
  //           style: TextStyle(
  //               fontSize: ScreenUtil().setSp(28), color: XMColor.deep_kgray),
  //         ),
  //         Expanded(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: <Widget>[
  //               Container(
  //                 child: showDetail
  //                     ? Container(
  //                         padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
  //                         decoration: BoxDecoration(
  //                             color: Color(0xff5fc48f),
  //                             borderRadius: BorderRadius.circular(12)),
  //                         child: Text(
  //                           '发现课程',
  //                           style: TextStyle(fontSize: 10, color: Colors.white),
  //                         ),
  //                       )
  //                     : Text(''),
  //               ),
  //               SizedBox(
  //                 width: ScreenUtil().setWidth(28),
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  _grayGap() {
    return Container(
      height: 11,
      color: XMColor.bg_gray,
    );
  }
}
