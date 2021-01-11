import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterautotext/flutterautotext.dart';
import 'package:framework/xm_mvvm.dart/view/explore/sku.dart';
import '../../../public.dart';
import 'explore_class.dart';

class ExploreRootScene extends StatefulWidget {
  @override
  _ExploreRootSceneState createState() => _ExploreRootSceneState();
}

const VARIANTS_PRIMARY = Color.fromRGBO(0, 119, 253, 1);

class _ExploreRootSceneState extends State<ExploreRootScene> {
  TabController tabCtr;
  ScrollController scCtr = ScrollController();
  Timer seckillTimer;
  XMRefreshWidget seckillWid;
  DateTime seckillDt;
  var left = 0.0;
  var tabs = ['课程与挑战', '运动商城', '健康轻食'];
  var classScInfo = [
    {
      'icon':
          'https://static1.keepcdn.com/2019/04/22/15/1555916831229_126x126.png',
      'title': '找课程'
    },
    {
      'icon':
          'https://static1.keepcdn.com/2019/04/17/15/1555487381969_126x126.png',
      'title': '动作库'
    },
    {
      'icon':
          'https://static1.keepcdn.com/2019/04/22/15/1555916811115_126x126.png',
      'title': '活动挑战'
    },
    {
      'icon':
          'https://static1.keepcdn.com/2019/04/22/15/1555916607160_126x126.png',
      'title': '私家课'
    },
  ];
  var scInfo = [
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i2/3010695444/O1CN017fr7M91q5Omy9jsCM_!!0-item_pic.jpg_180x180.jpg',
      'title': '智能硬件'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i4/3010695444/O1CN01LnqcVi1q5On249LfC_!!0-item_pic.jpg_240x240.jpg',
      'title': '运动装备'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i2/3010695444/O1CN01c2QAQX1q5OmvkzHTY_!!0-item_pic.jpg_180x180.jpg',
      'title': '轻食代餐'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i1/3010695444/O1CN01D1ASSt1q5On0JhI66_!!0-item_pic.jpg_180x180.jpg',
      'title': '女子服饰'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i2/3010695444/O1CN01CdPHOO1q5OmxiBRYD_!!0-item_pic.jpg_240x240.jpg',
      'title': '男子服饰'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i2/3010695444/O1CN01UXZIg31q5On0JfY2M_!!0-item_pic.jpg_240x240.jpg',
      'title': '新品专区'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i1/3010695444/O1CN01jAM69A1q5Omy6yHlK_!!0-item_pic.jpg_240x240.jpg',
      'title': '户外运动'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i3/3010695444/O1CN01IoRgsV1q5OmyixdY7_!!0-item_pic.jpg_240x240.jpg',
      'title': 'LINE联名'
    },
    {
      'icon':
          'https://gd1.alicdn.com/imgextra/i1/0/O1CN01Iq0fjB1q5Omy9jXPb_!!0-item_pic.jpg_400x400.jpg',
      'title': '运动生活'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i1/3010695444/O1CN01nRV9zY1q5On0JgxKx_!!0-item_pic.jpg_240x240.jpg',
      'title': 'Keep周边'
    },
  ];

  var secKillInfo = [
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i1/3010695444/O1CN01eul7n31q5Opird3As_!!3010695444.jpg_180x180.jpg',
      'title': '99,49'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i2/3010695444/O1CN01eJlgVN1q5OpirAzAg_!!3010695444.jpg_180x180.jpg',
      'title': '72,39'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i4/3010695444/O1CN01c2H5Ka1q5Opd7G999_!!3010695444.jpg_180x180.jpg',
      'title': '98,79'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i1/3010695444/O1CN01D1ASSt1q5On0JhI66_!!0-item_pic.jpg_180x180.jpg',
      'title': '139,109'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i4/3010695444/O1CN01ujA7yr1q5OoY3M7zN_!!3010695444.jpg_180x180.jpg',
      'title': '79,59'
    },
  ];
  var news = [
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i2/3010695444/O1CN01rVoBIo1q5Oo2gY5eB_!!3010695444-0-lubanu-s.jpg_240x240.jpg',
      'title': '99,49'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i2/3010695444/O1CN0110WpmT1q5On249TzS_!!0-item_pic.jpg_240x240.jpg',
      'title': '72,39'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i1/3010695444/O1CN01dYgR9H1q5OnwxMY5y_!!3010695444.jpg_240x240.jpg',
      'title': '98,79'
    },
    {
      'icon':
          'https://img.alicdn.com/bao/uploaded/i4/3010695444/O1CN01nJ5BVK1q5OmxiCiZm_!!0-item_pic.jpg_240x240.jpg',
      'title': '139,109'
    },
  ];
  int _position = 0; //表示从第几条开始取

  @override
  void dispose() {
    // 资源释放
    super.dispose();
    seckillTimer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    tabCtr = TabController(
      length: tabs.length,
      vsync: ScrollableState(),
    );
    scCtr.addListener(() {
      left = (scCtr.position.pixels / scCtr.position.maxScrollExtent) * 20;
      setState(() {});
    });
    initSeckillDt();
    seckillWid = seckillWidCreate();
    seckillTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seckillDt == DateTime.now()) {
        initSeckillDt();
      }
      seckillWid.reload();
    });
    // 首次拉取数据
    _fetchData();
  }

  void initSeckillDt() {
    seckillDt = DateTime.now().add(Duration(hours: 24));
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
      controller: tabCtr,
      labelColor: XMColor.darkGray,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelColor: XMColor.kgray,
      indicatorColor: XMColor.deepGray,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      tabs: tabs
          .map(
            (e) => Tab(text: e),
          )
          .toList(),
    );
  }

  //快捷入口
  List<Widget> _fastEntryView(List<Map<String, String>> fastInfo,
      {double width}) {
    return fastInfo.map(
      (v) {
        var content = Column(
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(v['icon']),
            ),
            SizedBox(height: 10),
            Text(
              v['title'],
              style: TextStyle(
                  color: XMColor.deepGray, fontSize: ScreenUtil().setSp(36)),
            )
          ],
        );
        return InkWell(
          onTap: () {
            xmPush(SKUPage());
          },
          child:
              null == width ? content : Container(width: width, child: content),
        );
      },
    ).toList();
  }

  List<Widget> _seckillView(List<Map<String, String>> fastInfo) {
    return fastInfo.map(
      (v) {
        var titles = v['title'].split(',');
        var t1 = '¥' + titles[1] + '  ';
        var t2 = '¥' + titles[0];
        var content = Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: v['icon'],
                  fit: BoxFit.cover,
                )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  t1,
                  style: TextStyle(
                      color: Colors.red, fontSize: ScreenUtil().setSp(36)),
                ),
                Text(
                  t2,
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: XMColor.deepGray,
                      fontSize: ScreenUtil().setSp(32)),
                )
              ],
            ),
          ],
        );
        return InkWell(
          onTap: () {
            Toast.show(v['title']);
          },
          child: Row(
            children: <Widget>[
              Container(width: (xmSW() - margin8 * 5) / 4, child: content),
              SizedBox(width: margin8),
            ],
          ),
        );
      },
    ).toList();
  }

//bannber图
  _bannberView(List imgs) {
    return CarouselSlider(
        viewportFraction: 1.0,
        aspectRatio: 2.0,
        autoPlay: true,
        enlargeCenterPage: false,
        items: imgs.map((url) {
          return new Builder(
            builder: (BuildContext context) {
              return Container(
                padding:
                    EdgeInsets.fromLTRB(xmDp(30), xmDp(30), xmDp(30), xmDp(40)),
                child: Container(
                  width: xmSW() - margin8 * 2,
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: url,
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
  _sectionView(title, bool showDetail, {Widget diy, String subTitle}) {
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
                fontSize: ScreenUtil().setSp(42), color: XMColor.deepGray),
          ),
          diy ?? SizedBox.shrink(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                null == subTitle
                    ? SizedBox.shrink()
                    : Text(
                        subTitle,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(32),
                            color: XMColor.lightGray),
                      ),
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

  List<Widget> header() {
    return [
      {
        'icon':
            'https://static1.keepcdn.com/2019/04/22/15/1555916831229_126x126.png',
        'title': '找课程'
      },
      {
        'icon':
            'https://static1.keepcdn.com/2019/04/17/15/1555487381969_126x126.png',
        'title': '动作库'
      },
      {
        'icon':
            'https://static1.keepcdn.com/2019/04/22/15/1555916811115_126x126.png',
        'title': '活动挑战'
      }
    ].map((e) {}).toList();
  }

  Widget _classView() {
    return Container(
      color: Colors.white,
      child: EasyRefresh(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            //第一栏
            Column(
              children: <Widget>[
                //banner 图
                _bannberView([
                  'https://static1.keepcdn.com/2019/07/08/1562568672006_750x340.jpg',
                  'https://static1.keepcdn.com/2019/07/05/1562322727672_750x340.jpg',
                  'https://static1.keepcdn.com/2019/07/05/1562309054265_750x340.jpg'
                ]),

                // 快捷入口
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _fastEntryView(classScInfo),
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
        ),
        onRefresh: _refresh,
        onLoad: _fetchData,
      ),
    );
  }

  Widget _shopView() {
    return Container(
      color: Colors.white,
      child: EasyRefresh(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            //第一栏
            Column(
              children: <Widget>[
                //banner 图
                _bannberView([
                  'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=115118656,1006158330&fm=15&gp=0.jpg',
                  'https://gdp.alicdn.com/imgextra/i1/3010695444/TB2CG04JASWBuNjSszdXXbeSpXa_!!3010695444.jpg',
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        height: 50,
                        padding: EdgeInsets.only(left: margin8 * 2),
                        child: Row(
                          children: [
                            Image.asset('res/imgs/sd.png', width: xmDp(50)),
                            XMText.create(' 自营品牌', ftSize: 36),
                          ],
                        )),
                    Row(
                      children: [
                        Image.asset('res/imgs/kctk.png', width: xmDp(40)),
                        XMText.create(' 课程同款', ftSize: 36),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          commingSoon();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: margin8 * 2),
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                          decoration: BoxDecoration(
                              color: Color(0xff5fc48f),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            '关注商城',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )),
                  ],
                ),
                // 快捷入口

                Container(
                  height: 100,
                  child: ListView(
                    controller: scCtr,
                    scrollDirection: Axis.horizontal,
                    children: _fastEntryView(scInfo, width: 70),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 3,
                      decoration: BoxDecoration(
                        color: XMColor.lineColor,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: left),
                      width: 20,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: xmDp(40)),
              ],
            ),
            _grayGap(),
            //第二栏
            Column(children: <Widget>[
              _sectionView('限时秒杀', true, subTitle: '查看更多 ', diy: seckillWid),
              Container(
                height: 110,
                margin: EdgeInsets.all(margin8),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _seckillView(secKillInfo),
                ),
              ),
            ]),
            _grayGap(),
            Stack(
              children: <Widget>[
                _bannberView([
                  'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=514358584,150972866&fm=26&gp=0.jpg',
                  'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2570023260,283529150&fm=26&gp=0.jpg',
                ]),
              ],
            ),
            _grayGap(),
            Column(children: <Widget>[
              _sectionView('新品情报局', true,
                  subTitle: '查看更多 ',
                  diy: XMText.create(
                    '   冬季上新',
                    ftSize: 32,
                    color: XMColor.grayColor,
                  )),
              Container(
                height: 110,
                margin: EdgeInsets.all(margin8),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _seckillView(news),
                ),
              ),
            ]),
            _grayGap(),
            teamBuy(),
            _grayGap(),
          ],
        ),
        onRefresh: _refresh,
        onLoad: _fetchData,
      ),
    );
  }

  XMRefreshWidget seckillWidCreate() {
    return XMRefreshWidget(
      key: Key('SecKill'),
      builder: (cntext) {
        var diff = seckillDt.difference(DateTime.now());
        // int day = (diff.inSeconds ~/ 3600) ~/ 24;
        String hour =
            ((diff.inSeconds ~/ 3600) % 24).toString().padLeft(2, '0');
        String minute =
            ((diff.inSeconds % 3600 ~/ 60)).toString().padLeft(2, '0');
        String second = ((diff.inSeconds % 60)).toString().padLeft(2, '0');

        return Row(
          children: <Widget>[
            SizedBox(width: 10),
            Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xffec6067),
                borderRadius: BorderRadius.circular(5),
              ),
              child: FlutterAutoText(
                width: 20,
                text: ' $hour ',
                textColor: Colors.white,
              ),
            ),
            XMText.create(' : ', color: Color(0xffec6067)),
            Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xffec6067),
                borderRadius: BorderRadius.circular(5),
              ),
              child: FlutterAutoText(
                width: 20,
                text: ' $minute ',
                textColor: Colors.white,
              ),
            ),
            XMText.create(' : ', color: Color(0xffec6067)),
            Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xffec6067),
                borderRadius: BorderRadius.circular(5),
              ),
              child: FlutterAutoText(
                width: 20,
                text: ' $second ',
                textColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget teamBuy() {
    List info = [
      [
        '拼团嗨购',
        '低至5折',
        [
          [
            'https://img.alicdn.com/bao/uploaded/i1/3010695444/O1CN01xjffm41q5OmukVgwl_!!0-item_pic.jpg_240x240.jpg',
            49.9,
            35
          ],
          [
            'https://img.alicdn.com/bao/uploaded/i2/3010695444/O1CN01ON0XdO1q5OmvkzcHC_!!0-item_pic.jpg_240x240.jpg',
            29.9,
            25
          ]
        ]
      ],
      [
        '拼团嗨购',
        '低至5折',
        [
          [
            'https://img.alicdn.com/bao/uploaded/i2/3010695444/O1CN01jNM4hB1q5OmyZwXOk_!!0-item_pic.jpg_240x240.jpg',
            119.9,
            88
          ],
          [
            'https://img.alicdn.com/bao/uploaded/i4/3010695444/O1CN01Y2TVMe1q5Omw9mONq_!!0-item_pic.jpg_240x240.jpg',
            129.9,
            86
          ]
        ]
      ]
    ];
    int i = 0;
    var w1 = xmSW() / 2 - margin8 - 1;
    var w2 = (w1 - margin8 * 3) / 2;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: margin8),
      color: XMColor.bgGray,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Row(
          children: info.map((e) {
            var content = Container(
                padding: EdgeInsets.all(margin8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(
                        color: i == 0 ? XMColor.lineColor : Colors.transparent,
                        width: 1),
                  ),
                ),
                width: w1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: xmDp(10)),
                    XMText.create(e[0]),
                    SizedBox(height: xmDp(10)),
                    XMText.create(e[1], ftSize: 32, color: XMColor.gray),
                    SizedBox(height: xmDp(25)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: (e[2] as List).map((item) {
                        return Container(
                          width: w2,
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              xmNetWorkImage(
                                item[0],
                                200,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  XMText.create('¥' + item[1].toString() + ' ',
                                      ftSize: 32, color: Colors.red),
                                  Text(
                                    '¥' + item[2].toString(),
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.red,
                                      fontSize: ScreenUtil().setSp(26),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ));
            i++;
            return content;
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('搜索',
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500)),
        bottom: PreferredSize(
          child: Container(
            child: _tabBar(),
          ),
          preferredSize: Size(xmSW(), 40),
        ),
      ),
      body: TabBarView(controller: tabCtr, children: [
        _classView(),
        _shopView(),
        XMEmpty.show('CommingSoon', iconImgPath: imgPath('smile')),
      ]),
    );
  }
}
