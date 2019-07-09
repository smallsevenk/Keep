import 'package:flutter/material.dart';
import 'package:keep/base/public.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      {'icon': 'imgs/explore_find_class.png', 'title': '找课程'},
      {'icon': 'imgs/explore_action.png', 'title': '动作库'},
      {'icon': 'imgs/explore_activity.png', 'title': '活动挑战'},
      {'icon': 'imgs/explore_activity.png', 'title': '私家课'},
    ];
    return _fastInfo.map((v) {
      return Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(v['icon']),
          ),
          SizedBox(height: 10),
          Text(
            v['title'],
            style: TextStyle(
                color: Z6Color.deep_kgray, fontSize: ScreenUtil().setSp(22)),
          )
        ],
      );
    }).toList();
  }

  Widget _refreshView() {
    return Column(
      children: <Widget>[
        //第一栏
        Column(
          children: <Widget>[
            // SizedBox(height: 8),
            //banner 图
            Container(
              padding: EdgeInsets.fromLTRB(
                  margin8, margin8, margin8, ScreenUtil().setHeight(40)),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://pics2.baidu.com/feed/4034970a304e251f8274c6bed7d5d0127e3e5348.jpeg?token=ad0a856b977c8761d45938993ad38d95&s=40E1B1444F033541085419880300D080',
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
            ),
            // 快捷入口
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _fastEntryView(),
            )
          ],
        )
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
