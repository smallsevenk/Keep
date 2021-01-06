import 'package:flutter/material.dart';
import '../../../public.dart';
import 'sport_data.dart';

class SportPage extends StatefulWidget {
  SportPage({Key key}) : super(key: key);

  _SportPageState createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                title: Text(
                  '运动',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                expandedHeight: 0.0,
                floating: false,
                snap: false,
                pinned: false,
                actions: <Widget>[
                  Container(
                    width: 35,
                    height: 35,
                    child: IconButton(
                      icon: Image.asset('res/imgs/sport_nav_right_kxwy.png'),
                      onPressed: () {
                        Toast.show('k星物语');
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 35,
                    height: 35,
                    child: IconButton(
                      icon:
                          Image.asset('res/imgs/sport_nav_right_wristband.png'),
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
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  _tabBar(),
                ),
                pinned: true,
              ),
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: _body(),
              ),
              Text('data2'),
              Text('data1'),
              Text('data2'),
              Text('data1'),
            ],
          ),
        ),
      ),
    );
  }

  _body() {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                  height: 44,
                ),
                Text(
                  '下午好，',
                  style: TextStyle(color: XMColor.light_kgray, fontSize: 12),
                ),
                Text(
                  sportData['userInfo']['name'],
                  style: TextStyle(color: XMColor.light_kgray, fontSize: 14),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(18, 10, 0, 16),
              child: Row(
                children: <Widget>[
                  Image(
                    height: 18,
                    image: AssetImage('res/imgs/sport_set_goals.png'),
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    '订个目标 ，开始Keep! ',
                    style: TextStyle(
                        color: XMColor.deep_kgray,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
                title: Text(
                  '已累计运动1862分钟',
                  style: TextStyle(fontSize: 14),
                ),
                trailing: Container(
                  width: ScreenUtil().setHeight(17),
                  height: ScreenUtil().setHeight(30),
                  child: Image(
                    image: AssetImage('res/imgs/comm_detail.png'),
                  ),
                ))
          ],
        ),
        _grayGap(),
        _myTeam(),
        _grayGap(),
        _myClass(),
        _grayGap(),
        _eventPromotion(),
      ],
    );
  }

  _eventPromotion() {
    Map secInfo = sportData['sections'][4];
    List promotions = secInfo['promotions'];
    return Column(
      children: <Widget>[
        _sectionView(secInfo['sectionName'], false),
        CarouselSlider(
          viewportFraction: 1.0,
          aspectRatio: 2.0,
          autoPlay: false,
          enlargeCenterPage: false,
          items: promotions.map((v) {
            var img = v['picture'];
            return new Builder(
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setHeight(40)),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        width: ScreenUtil()
                            .setWidth(ScreenUtil.screenWidth - 10 * 2),
                        child: ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl: img,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        v['title'],
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        v['text'],
                        style:
                            TextStyle(fontSize: 12, color: XMColor.light_kgray),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
          height: 280.0,
        ),
        Container(
            width: Screen.width,
            height: 44,
            color: XMColor.bg_gray,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('- 没有更多了 -',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: XMColor.deep_kgray)),
              ],
            ))
      ],
    );
  }

  _myClass() {
    Map sec3 = sportData['sections'][3];
    List cls = sec3['joinedCoursesV2'];

    return Column(
      children: <Widget>[
        _sectionView(sec3['sectionName'], true),
        Container(
          child: Column(
            children: cls.map((v) {
              var diffTime = RelativeDateFormat.format(
                  DateTime.parse(v['lastTrainingDate']));
              bool isVip = v['hasPlus'];
              return Column(
                children: <Widget>[
                  SizedBox(height: 15),
                  Container(
                    height: 24,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                          height: 24,
                        ),
                        Text(
                          v['name'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        isVip
                            ? Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Color(0xffe9d399),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Text(
                                  '会员精讲',
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            : Text(''),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '${v['averageDuration']} 分钟 · K${v['difficulty']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                width: 16,
                                height: 48,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 24,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          '上次训练 $diffTime  ${v['liveUserCount']}人正在练',
                          style: TextStyle(
                              fontSize: 10, color: XMColor.light_kgray),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '已下载',
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                width: 16,
                                height: 48,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    height: 1,
                  )
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  _myTeam() {
    Map sec1 = sportData['sections'][1];
    Map squad = sec1['squad'];
    Map week = squad['week'];
    String des = '第 ${week['weekIndex']} 周：   ${week['introduction']}';
    List teams = squad['dynamicItems'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 50,
          child: ListTile(
              title: Text(
            sec1['sectionName'],
            style: TextStyle(
                fontSize: ScreenUtil().setSp(30), color: Colors.black),
          )),
        ),
        Container(
          width: Screen.width,
          height: Screen.width,
          padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(squad['picture']), fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                title: Text(
                  squad['name'],
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(44), color: Colors.white),
                ),
                subtitle: Text(
                  des,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(22), color: Colors.white),
                ),
                trailing: Container(
                  width: ScreenUtil().setWidth(40),
                  height: ScreenUtil().setHeight(40),
                  child:
                      Image.asset('res/imgs/explore_class_section_right.png'),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 120,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      _teamCell(week, 0),
                      Divider(height: 0.5),
                      _teamCell(week, 1),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 35),
              Container(
                width: Screen.width - 20 * 2,
                height: 50,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    _finishedTeamers(teams)[0],
                    _finishedTeamers(teams)[1],
                    _finishedTeamers(teams)[2],
                    Positioned(
                      left: 80,
                      child: Container(
                        height: 30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.asset(
                              'res/imgs/sport_punch.png',
                              fit: BoxFit.cover,
                            ),
                            Text(
                              '完成了今天全部打卡',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          Toast.show('加油加油!');
                        },
                        child: Container(
                          height: 30,
                          child: Image.asset(
                            'res/imgs/sport_like.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _teamCell(Map week, idx) {
    Map info = week['taskList'][idx];
    return InkWell(
      onTap: () {
        setState(() {
          String flag = info['flag'];
          info['flag'] = flag == '1' ? '0' : '1';
        });
      },
      child: Container(
        height: 60,
        child: Row(
          children: <Widget>[
            SizedBox(width: 20),
            Container(
              width: 20,
              height: 20,
              child: Image.asset('res/imgs/sport_check_${info['flag']}.png'),
            ),
            SizedBox(width: 20),
            Text(info['task']['title'])
          ],
        ),
      ),
    );
  }

  _finishedTeamers(teams) {
    return teams.map((v) {
      double w = 30;
      int idx = teams.indexOf(v);
      double x = (w - 10) * (2 - idx.toDouble());
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
            backgroundImage: NetworkImage(v['avatar']),
            radius: 20,
          ),
        ),
      );
    }).toList();
  }

  _sectionView(title, bool showDetail) {
    return InkWell(
      onTap: () {
        setState(() {
          // widget.inde = 1;
        });
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            width: ScreenUtil().setWidth(28),
            height: ScreenUtil().setWidth(78),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28), color: XMColor.deep_kgray),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: showDetail
                      ? Container(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                          decoration: BoxDecoration(
                              color: Color(0xff5fc48f),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            '发现课程',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )
                      : Text(''),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(28),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _grayGap() {
    return Container(
      height: ScreenUtil().setHeight(22),
      color: XMColor.bg_gray,
    );
  }
}

Widget _tabBar() {
  return TabBar(
    isScrollable: true,
    labelColor: XMColor.darkGray,
    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    unselectedLabelColor: XMColor.kgray,
    indicatorColor: XMColor.deep_kgray,
    indicatorSize: TabBarIndicatorSize.label,
    indicatorWeight: 2,
    indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
    tabs: [
      Tab(text: '现在开始'),
      Tab(text: '跑步'),
      Tab(text: '行走'),
      Tab(text: '智能硬件'),
      Tab(text: '瑜伽'),
    ],
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
