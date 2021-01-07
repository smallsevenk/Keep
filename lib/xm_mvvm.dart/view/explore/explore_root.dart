import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../public.dart';
import 'explore_class.dart';

class ExploreRootScene extends StatefulWidget {
  @override
  _ExploreRootSceneState createState() => _ExploreRootSceneState();
}

const VARIANTS_PRIMARY = Color.fromRGBO(0, 119, 253, 1);

class _ExploreRootSceneState extends State<ExploreRootScene> {
  NestedScrollView _supCtr;

  int _position = 0; //表示从第几条开始取

  get trailing => null;

  @override
  void dispose() {
    // 资源释放
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // 首次拉取数据
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Hot hot = await Z6Srv.queryHot(_position.toString());
    setState(() {
      if (_position == 0) {
        // posts.clear();
      }
      // posts.addAll(hot.data.items);
    });
  }

  Future<void> _refresh() async {
    _position = 0;
    _fetchData();
  }

  Widget _tabBar() {
    return TabBar(
      isScrollable: true,
      // labelColor: XMColor.darkGray,
      // labelStyle: TextStyle(
      //   fontSize: ScreenUtil().setSp(28),
      // ),
      // unselectedLabelColor: XMColor.kgray,
      // indicatorColor: XMColor.deepGray,
      // indicatorSize: TabBarIndicatorSize.label,
      // indicatorWeight: 2,
      // indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),

      labelColor: XMColor.darkGray,
      labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      unselectedLabelColor: XMColor.kgray,
      indicatorColor: XMColor.deepGray,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
      tabs: [
        Tab(text: '课程与挑战'),
        Tab(text: '运动商城'),
        Tab(text: '健康轻食'),
        Tab(text: '硬件商城'),
      ],
    );
  }

  //快捷入口
  List<Widget> _fastEntryView() {
    List<Map<String, String>> _fastInfo = [
      {'icon': '/2019/04/22/15/1555916831229_126x126.png', 'title': '找课程'},
      {'icon': '/2019/04/17/15/1555487381969_126x126.png', 'title': '动作库'},
      {'icon': '/2019/04/22/15/1555916811115_126x126.png', 'title': '活动挑战'},
      {'icon': '/2019/04/22/15/1555916607160_126x126.png', 'title': '私家课'},
    ];
    return _fastInfo.map((v) {
      return InkWell(
        onTap: () {
          Toast.show(v['title']);
        },
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage:
                  NetworkImage('https://static1.keepcdn.com${v['icon']}'),
            ),
            SizedBox(height: 10),
            Text(
              v['title'],
              style: TextStyle(
                  color: XMColor.deepGray, fontSize: ScreenUtil().setSp(36)),
            )
          ],
        ),
      );
    }).toList();
  }

//bannber图
  _bannberView() {
    List<String> imgList = [
      '/2019/07/08/1562568672006_750x340.jpg',
      '/2019/07/05/1562322727672_750x340.jpg',
      '/2019/07/05/1562309054265_750x340.jpg'
    ];
    return CarouselSlider(
        viewportFraction: 1.0,
        aspectRatio: 2.0,
        autoPlay: false,
        enlargeCenterPage: false,
        items: imgList.map((url) {
          var img = 'https://static1.keepcdn.com$url';
          return new Builder(
            builder: (BuildContext context) {
              return Container(
                padding:
                    EdgeInsets.fromLTRB(xmDp(30), xmDp(30), xmDp(30), xmDp(40)),
                child: Container(
                  width: xmSW() - margin8 * 2,
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: img,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ),
              );
            },
          );
        }).toList(),
        height: xmDp(450));
  }

  //栏标题
  _sectionView(title, bool showDetail) {
    return InkWell(
      onTap: () {
        Toast.show(title);
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            width: xmDp(28),
            height: xmDp(118),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(52), color: XMColor.deepGray),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: xmDp(78),
                  child: showDetail
                      ? Container(
                          width: xmDp(22),
                          height: xmDp(44),
                          child: Image(
                            image: AssetImage('res/imgs/comm_detail.png'),
                          ),
                        )
                      : Text(''),
                ),
                SizedBox(
                  width: xmDp(28),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //热门课题分类流式布局
  _hotClassCategory() {
    List _classCategories = ['减脂', '瑜伽', '有氧操', '学生专属', '腹肌马甲线', '为你推荐'];
    return Wrap(
        spacing: xmDp(28), // 主轴(水平)方向间距
        runSpacing: xmDp(16), // 纵轴（垂直）方向间距
        alignment: WrapAlignment.start, //沿主轴方向居中
        children: _classCategories.map((title) {
          return Container(
            decoration: BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.all(Radius.circular(xmDp(24)))),

            // alignment: Alignment.centerLeft,
            padding:
                EdgeInsets.fromLTRB(xmDp(20), xmDp(10), xmDp(20), xmDp(10)),
            child: InkWell(
              onTap: () {
                Toast.show(title);
              },
              child: Text(
                title,
                style: TextStyle(
                  color: XMColor.deepGray,
                  fontSize: ScreenUtil().setSp(36),
                  // fontFamily: 'fzxbs',
                ),
              ),
            ),
          );
        }).toList());
  }

  //热门活动
  _hotActivity() {
    List _activities = [
      {'title': 'Keep 马拉松 | 跑过暑假', 'num': '37071'},
      {'title': '减脂挑战.暴汗突击瘦身', 'num': '546064'},
      {'title': '7月跑量挑战', 'num': '179171'},
      {'title': '暑假悄悄变瘦计划', 'num': '401395'}
    ];

    var h = xmDp(340);
    var count = 2;
    return Container(
        child: GridView.count(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: count,
      childAspectRatio: xmSW() / (h * count),
      crossAxisSpacing: xmDp(16),
      mainAxisSpacing: xmDp(20),
      children: _activities.map((v) {
        int _idx = _activities.indexOf(v);
        double _leftPadding = xmDp(28);
        double _rightPadding = 0;
        var img =
            'res/imgs/explore_hot_activity_0' + (_idx + 1).toString() + '.png';
        if ((_idx % 2).isOdd) {
          _rightPadding = _leftPadding;
          _leftPadding = 0;
        }
        return InkWell(
          onTap: () {
            Toast.show(v['title']);
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(_leftPadding, 0, _rightPadding, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  child: Image.asset(img),
                  borderRadius: BorderRadius.circular(3),
                ),
                SizedBox(height: xmDp(10)),
                Text(
                  v['title'],
                  style: TextStyle(
                    color: XMColor.deepGray,
                    fontSize: ScreenUtil().setSp(34),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: xmDp(10)),
                Container(
                    child: Text(
                  v['num'] + ' 已参加',
                  style: TextStyle(
                    color: XMColor.lightGray,
                    fontSize: ScreenUtil().setSp(32),
                  ),
                ))
              ],
            ),
          ),
        );
      }).toList(),
    ));
  }

  _funExplore() {
    List _entrances = [
      {
        "name": "K 星物语",
        "description": "",
        "imgUrl":
            "https://static1.keepcdn.com/2019/04/22/11/1555903832078_330x330.png",
        "schema": "https://m.gotokeep.com/glue-web?fullscreen=1",
        "ipadImg": null
      },
      {
        "name": "每日一答",
        "description": "",
        "imgUrl":
            "https://static1.keepcdn.com/2019/04/22/11/1555904571696_330x330.png",
        "schema": "https://activity.gotokeep.com/lab/daily-quiz",
        "ipadImg": null
      },
      {
        "name": "跳跃小游戏",
        "description": "",
        "imgUrl":
            "https://static1.keepcdn.com/2019/04/22/11/1555903917312_330x330.png",
        "schema":
            "https://m.gotokeep.com/training/jumpGames/entry?fullscreen=true ",
        "ipadImg": null
      }
    ];
    return GridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: xmDp(16),
        mainAxisSpacing: 0,
        children: _entrances.map((v) {
          return InkWell(
            onTap: () {
              Toast.show(v['name']);
            },
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: v['imgUrl'],
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }).toList());
  }

  _classTopic() {
    return classInfoList.map((v) {
      List plans = v['plans'];
      return Container(
        height: xmDp(900),
        padding: EdgeInsets.fromLTRB(xmDp(16), 0, xmDp(16), xmDp(16)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: AssetImage(
                      'res/imgs/explore_class_topic_bg${v['color']}.png'),
                  fit: BoxFit.fill)),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: v['recPicture'],
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),
                  ListTile(
                    title: Text(
                      v['name'],
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(50),
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      v['description'],
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(30),
                          color: Colors.white),
                    ),
                    trailing: Container(
                      width: xmDp(60),
                      height: xmDp(60),
                      child: Image.asset(
                          'res/imgs/explore_class_section_right.png'),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(xmDp(20), 0, xmDp(20), xmDp(20)),
                child: Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      children: ListTile.divideTiles(
                              context: context, tiles: _planListTiles(plans))
                          .toList()),
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
  }

  _planListTiles(List plan) {
    return plan.map((plan) {
      return Row(
        children: <Widget>[
          SizedBox(width: margin8, height: xmDp(125) + margin8 * 2),
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: plan['picture'],
              fit: BoxFit.cover,
              width: xmDp(125),
              height: xmDp(125),
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          SizedBox(width: margin8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                plan['title'],
                style: TextStyle(fontSize: ScreenUtil().setSp(38)),
              ),
              SizedBox(height: 3),
              Text(
                'K${plan['difficulty']} ${_keppLev(plan['difficulty'])}·${plan['averageDuration']}分钟',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(30), color: XMColor.lightGray),
              )
            ],
          ),
        ],
      );
    }).toList();
  }

  _keppLev(lev) {
    if (lev == 1) {
      return '零基础';
    } else if (lev == 2) {
      return '初级';
    } else if (lev == 3) {
      return '入门';
    } else {
      return '强化';
    }
  }

  _grayGap() {
    return Container(
      height: xmDp(22),
      color: XMColor.bgGray,
    );
  }

  Widget _refreshView() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        //第一栏
        Column(
          children: <Widget>[
            // SizedBox(height: 8),
            //banner 图
            _bannberView(),
            // 快捷入口
            Container(
              padding: EdgeInsets.symmetric(horizontal: margin8 * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _fastEntryView(),
              ),
            ),
            SizedBox(height: xmDp(40)),
          ],
        ),
        _grayGap(),
        //第二栏
        Column(children: <Widget>[
          _sectionView('热门课程分类', true),
          Container(
            child: _hotClassCategory(),
          ),
          SizedBox(height: xmDp(40)),
        ]),
        _grayGap(),
        //第��栏
        Column(
          children: <Widget>[
            _sectionView('全站热门活动', true),
            _hotActivity(),
            SizedBox(height: xmDp(40)),
          ],
        ),
        _grayGap(),
        //��四栏
        Column(
          children: <Widget>[_sectionView('趣味探索', true), _funExplore()],
        ),
        _grayGap(),
        //第五栏
        Column(
          children: <Widget>[
            _sectionView('课程专题', false),
            Column(
              children: _classTopic(),
            )
          ],
        )
      ],
    );
  }

  Widget _easyRefresh() {
    return Container(
      color: Colors.white,
      child: EasyRefresh(
        child: _refreshView(),
        onRefresh: _refresh,
        onLoad: _fetchData,
      ),
    );
  }

  Widget _tabBarView() {
    return TabBarView(
      children: [
        Container(child: _easyRefresh()),
        Text('data2'),
        Text('data3'),
        Text('data4'),
      ],
    );
  }

  NestedScrollView _getSuperWidget() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            centerTitle: false,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            expandedHeight: 0.0,
            floating: false,
            snap: false,
            pinned: false,
            title: Text('搜索',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              _tabBar(),
            ),
            pinned: true,
          ),
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
        ];
      },
      body: _tabBarView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _supCtr = _getSuperWidget();

    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: _supCtr ?? Container(),
      ),
    );
  }
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
