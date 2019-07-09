import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:keep/base/public.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

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
      {'icon': 'imgs/explore_private_class.png', 'title': '私家课'},
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
              backgroundImage: AssetImage(v['icon']),
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

  _bannberView() {
    return CarouselSlider(
        viewportFraction: 1.0,
        aspectRatio: 2.0,
        autoPlay: false,
        enlargeCenterPage: false,
        items: imgList.map((url) {
          return new Builder(
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.fromLTRB(
                    margin8, margin8, margin8, ScreenUtil().setHeight(40)),
                child: Container(
                  width: ScreenUtil()
                      .setWidth(ScreenUtil.screenWidth - margin8 * 2),
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
        height: 180.0);
  }

  final CarouselSlider coverScreenExample = CarouselSlider(
    viewportFraction: 1.0,
    aspectRatio: 2.0,
    autoPlay: false,
    enlargeCenterPage: false,
    items: map<Widget>(
      imgList,
      (index, i) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(i), fit: BoxFit.cover),
          ),
        );
      },
    ),
  );

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
        ), //第一栏
        Column(children: <Widget>[
          ListTile(
            title: Text(
              '热门课程分类',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28), color: Z6Color.deep_kgray),
            ),
            trailing: Container(
              width: ScreenUtil().setHeight(17),
              height: ScreenUtil().setHeight(30),
              child: Image(
                image: AssetImage('imgs/comm_detail.png'),
              ),
            ),
          )
        ]),
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
