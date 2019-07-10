import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:keep/base/public.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';

class ExploreRootScene extends StatefulWidget {
  @override
  _ExploreRootSceneState createState() => _ExploreRootSceneState();
}

class _ExploreRootSceneState extends State<ExploreRootScene> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  NestedScrollView _supCtr;

  int _position = 0; //表示从第几条开始取

  @override
  bool get wantKeepAlive => true;

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
      labelColor: Z6Color.darkGray,
      labelStyle: TextStyle(
        fontSize: ScreenUtil().setSp(28),
      ),
      unselectedLabelColor: Z6Color.kgray,
      indicatorColor: Z6Color.deep_kgray,
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
              backgroundColor: Colors.white,
              backgroundImage:
                  NetworkImage('https://static1.keepcdn.com${v['icon']}'),
            ),
            SizedBox(height: 10),
            Text(
              v['title'],
              style: TextStyle(
                  color: Z6Color.deep_kgray, fontSize: ScreenUtil().setSp(22)),
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
          print('xxxx:$img');
          return new Builder(
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setHeight(30),
                    ScreenUtil().setHeight(30),
                    ScreenUtil().setHeight(30),
                    ScreenUtil().setHeight(40)),
                child: Container(
                  width: ScreenUtil()
                      .setWidth(ScreenUtil.screenWidth - margin8 * 2),
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
        height: 180.0);
  }

  //栏标题
  _sectionView(title, bool showDetail) {
    return InkWell(
      onTap: () {
        Toast.show(title);
      },
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28), color: Z6Color.deep_kgray),
        ),
        trailing: showDetail
            ? Container(
                width: ScreenUtil().setHeight(17),
                height: ScreenUtil().setHeight(30),
                child: Image(
                  image: AssetImage('imgs/comm_detail.png'),
                ),
              )
            : Text(''),
      ),
    );
  }

  //热门课题分类流式布局
  _hotClassCategory() {
    List _classCategories = ['减脂', '瑜伽', '有氧操', '学生专属', '腹肌马甲线', '为你推荐'];
    return Wrap(
        spacing: ScreenUtil().setWidth(28), // 主轴(水平)方向间距
        runSpacing: ScreenUtil().setWidth(16), // 纵轴（垂直）方向间距
        alignment: WrapAlignment.start, //沿主轴方向居中
        children: _classCategories.map((title) {
          return Container(
            decoration: BoxDecoration(
                color: Z6Color.bg_gray,
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil().setWidth(24)))),
            height: ScreenUtil().setHeight(48),

            // alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(20),
                ScreenUtil().setWidth(10),
                ScreenUtil().setWidth(20),
                ScreenUtil().setWidth(10)),
            child: InkWell(
              onTap: () {
                Toast.show(title);
              },
              child: Text(
                title,
                style: TextStyle(
                  color: Z6Color.deep_kgray,
                  fontSize: ScreenUtil().setSp(22),
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
    return SafeArea(
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 197 / 125,
          crossAxisSpacing: ScreenUtil().setWidth(16),
          mainAxisSpacing: ScreenUtil().setHeight(20),
          children: _activities.map((v) {
            int _idx = _activities.indexOf(v);
            double _leftPadding = ScreenUtil().setWidth(28);
            double _rightPadding = 0;
            var img =
                'imgs/explore_hot_activity_0' + (_idx + 1).toString() + '.png';
            print('-----$img');
            if ((_idx % 2).isOdd) {
              _rightPadding = _leftPadding;
              _leftPadding = 0;
            }
            return Container(
              padding: EdgeInsets.fromLTRB(_leftPadding, 0, _rightPadding, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    child: Image.asset(img),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text(
                    v['title'],
                    style: TextStyle(
                      color: Z6Color.deep_kgray,
                      fontSize: ScreenUtil().setSp(24),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text(
                    v['num'] + ' 已参加',
                    style: TextStyle(
                      color: Z6Color.light_kgray,
                      fontSize: ScreenUtil().setSp(22),
                    ),
                  )
                ],
              ),
            );
          }).toList()),
    );
  }

  Widget _refreshView() {
    return Column(
      children: <Widget>[
        //第一栏
        Column(
          children: <Widget>[
            // SizedBox(height: 8),
            //banner 图
            _bannberView(),
            // 快捷入口
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _fastEntryView(),
            ),
            SizedBox(height: ScreenUtil().setHeight(40)),
          ],
        ),
        Container(
          height: ScreenUtil().setHeight(22),
          color: Z6Color.bg_gray,
        ),
        //第二栏
        Column(children: <Widget>[
          _sectionView('热门课程分类', true),
          _hotClassCategory(),
          SizedBox(height: ScreenUtil().setHeight(40)),
        ]),
        Container(
          height: ScreenUtil().setHeight(22),
          color: Z6Color.bg_gray,
        ),
        //第三栏
        Column(
          children: <Widget>[
            _sectionView('全站热门活动', true),
            Container(
              height: 300,
              child: _hotActivity(),
            ),
            SizedBox(height: ScreenUtil().setHeight(40)),
          ],
        ),
      ],
    );
  }

  Widget _easyRefresh() {
    return Container(
      color: Z6Color.white,
      // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: EasyRefresh(
        key: _easyRefreshKey,
        behavior: ScrollOverBehavior(),
        refreshHeader: ClassicsHeader(
          key: _headerKey,
          refreshText: 'pullToRefresh',
          refreshReadyText: 'releaseToRefresh',
          refreshingText: "refreshing...",
          refreshedText: 'refreshed',
          moreInfo: 'updateAt',
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          loadText: 'pushToLoad',
          loadReadyText: 'releaseToLoad',
          loadingText: 'loading',
          loadedText: 'loaded',
          noMoreText: 'noMore',
          moreInfo: 'updateAt',
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        child: _refreshView(),
        onRefresh: _refresh,
        loadMore: _fetchData,
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
            expandedHeight: 0.0,
            floating: false,
            snap: false,
            pinned: false,
            title: Text('搜索'),
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
