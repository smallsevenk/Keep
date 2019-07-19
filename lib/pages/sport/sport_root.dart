import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/base/public.dart';

class SportPage extends StatefulWidget {
  SportPage({Key key}) : super(key: key);

  _SportPageState createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.orange,
                leading: Center(
                  child: Text(
                    '运动',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
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
                      icon: Image.asset('imgs/sport_nav_right_kxwy.png'),
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
                      icon: Image.asset('imgs/sport_nav_right_wristband.png'),
                      onPressed: () {
                        Toast.show('keep手环');
                      },
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    child: IconButton(
                      icon: Image.asset('imgs/sport_nav_right_search.png'),
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
}

_body() {
  return Column(
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
                style: TextStyle(color: Z6Color.light_kgray, fontSize: 12),
              ),
              Text(
                '淡然Oooooooooooooo',
                style: TextStyle(color: Z6Color.light_kgray, fontSize: 14),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(18, 10, 0, 16),
            child: Row(
              children: <Widget>[
                Image(
                  height: 18,
                  image: AssetImage('imgs/sport_set_goals.png'),
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  '订个目标 ，开始Keep! ',
                  style: TextStyle(
                      color: Z6Color.deep_kgray,
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
                  image: AssetImage('imgs/comm_detail.png'),
                ),
              ))
        ],
      ),
      _grayGap(),
    ],
  );
}

_grayGap() {
  return Container(
    height: ScreenUtil().setHeight(22),
    color: Z6Color.bg_gray,
  );
}

Widget _tabBar() {
  return TabBar(
    isScrollable: true,
    labelColor: Z6Color.darkGray,
    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    unselectedLabelColor: Z6Color.kgray,
    indicatorColor: Z6Color.deep_kgray,
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
