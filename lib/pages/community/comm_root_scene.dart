import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keep/base/color.dart';
import 'package:keep/base/public.dart';
import 'package:keep/models/entrys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/models/author.dart';
import 'package:keep/models/entry.dart';
import 'package:keep/models/hot.dart';
import 'package:keep/network/server.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keep/widgets/tile_card.dart';
import 'community_list_view.dart';

class KeepCommRootScene extends StatefulWidget {
  @override
  KeepCommRootSceneState createState() => KeepCommRootSceneState();
}

class KeepCommRootSceneState extends State<KeepCommRootScene> {
  ScrollController _superScCtr = new ScrollController();
  ScrollController _subScCtr = new ScrollController();
  ScrollPhysics _physicsAble = BouncingScrollPhysics();
  ScrollPhysics _physicsDisable = NeverScrollableScrollPhysics();
  ScrollPhysics _superPhysics;
  ScrollPhysics _subPhysics;
  NestedScrollView _supCtr;

  NestedScrollView _getSuperWidget() {
    return NestedScrollView(
      // controller: _superScCtr,
      // physics: _superPhysics,
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
            // child: Text('data'),
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
        ];
      },
      body: _tabBarView(),
    );
  }

  // int _beLoad = 0; // 0表示不显示, 1表示正在请求, 2表示没有更多数据
  int _position = 0; //表示从第几条开始取

  List<Entrys> posts = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // 资源释放
    _superScCtr.dispose();
    _subScCtr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // 首次拉取数据
    _fetchData();

    _subPhysics = _physicsAble;
    _subPhysics = _physicsAble;

    // controller = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 2000));
    // // 通过 Tween 对象 创建 Animation 对象
    // animation = Tween(begin: 50.0, end: 200.0).animate(controller)
    //   ..addListener(() {
    //     // 注意：这句不能少，否则 widget 不会重绘，也就看不到动画效果
    //     setState(() {});
    //   });

    // _setBodyFrame();

    _superScCtr.addListener(() {
      double _scviewPosition = _superScCtr.position.pixels;
      // double _scviewMinPosition = _subScCtr.position.minScrollExtent;
      // double _scviewMaxPosition = _subScCtr.position.maxScrollExtent;
      print('Y1111:' + _scviewPosition.toString());
      // if (_scviewPosition <= 0) {
      //   setState(() {
      //     _superPhysics = _physicsDisable;
      //     _subPhysics = _physicsAble;
      //   });
      // }
    });

    _subScCtr.addListener(() {
      //滚动视图滚动位置
      double _scviewPosition = _subScCtr.position.pixels;
      double _scviewMinPosition = _subScCtr.position.minScrollExtent;
      double _scviewMaxPosition = _subScCtr.position.maxScrollExtent;

      print('Y2222:' + _scviewPosition.toString());
      if (_scviewPosition > _scviewMinPosition) {
        //往上覆盖
        print('往上覆盖');
        setState(() {
          // _subScCtr.jumpTo(0);
          // _superPhysics = _physicsAble;
          // _subPhysics = _physicsDisable;
          // _supCtr.dragStartBehavior = DragStartBehavior.start;
          // _superScCtr.animateTo(_scviewPosition,
          //     duration: Duration(milliseconds: 200), curve: Curves.ease);
        });
        // } else {
      } else if (_scviewPosition == _scviewMaxPosition) {
        //从多少条数据后面开始取数据
        _position = posts.length;
        _fetchData();
        print('我监听到底部了!');
      } else if (_scviewPosition == _scviewMinPosition) {
        print('下拉下拉下拉下拉下拉下拉下拉下拉下拉下拉!');
      }
      // }
    });
  }

  Future<void> _fetchData() async {
    Hot hot = await Z6Srv.queryHot(_position.toString());
    setState(() {
      if (_position == 0) {
        posts.clear();
      }
      posts.addAll(hot.data.items);
    });
  }

  Future<void> _refresh() async {
    _position = 0;
    _fetchData();
  }

  Widget _tabBar() {
    return TabBar(
      labelColor: Z6Color.darkGray,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelColor: Z6Color.kgray,
      indicatorColor: Z6Color.deep_kgray,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
      tabs: [
        Tab(text: '热门'),
        Tab(text: '关注'),
        Tab(text: '话题'),
        Tab(text: '同城'),
      ],
    );
  }

  Widget _hotList() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(margin8),
      child: StaggeredGridView.countBuilder(
          // controller: _subScCtr,
          // physics: _physicsDisable,
          itemCount: posts.length,
          primary: false,
          crossAxisCount: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          itemBuilder: (context, idx) {
            String img;
            String content;
            String avatar;
            String name;
            String likes;
            try {
              Entry entry = posts[idx].entry ?? Entry();
              List imgs = entry.images ?? [];
              Author author = entry.author ?? Author();

              img = imgs.length >= 1 ? imgs[0] : Api.hot_img;
              content = entry.content ?? '默认测试内容';
              avatar = author.avatar ?? Api.avatar;
              name = author.username ?? '无名';
              likes = (entry.likes ?? 0).toString();
            } catch (e) {
              print('-----ItemError-$idx:$e');
              return Container();
            }

            return TileCard(
              img: img,
              content: content,
              avatar: avatar,
              name: name,
              likes: likes,
              isVip: idx % 3 == 0 ? true : false,
            );
          },
          staggeredTileBuilder: (index) => StaggeredTile.fit(2)),
    );
  }

  // _showRefresh() {
  //   return _bodyTop >= Screen.navigationBarHeight + _tabBarHeight
  //       ? true
  //       : false;
  // }

  Widget _tabBarView() {
    return TabBarView(
      children: [
        Container(
            child: RefreshIndicator(onRefresh: _refresh, child: _hotList())),
        RefreshIndicator(
          onRefresh: () {
            print('xxxx');
          },
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.red,
                height: 100,
              ),
              Container(
                color: Colors.yellow,
                height: 100,
              ),
              Container(
                color: Colors.blue,
                height: 100,
              ),
              Container(
                color: Colors.green,
                height: 100,
              ),
              Container(
                color: Colors.blue,
                height: 100,
              ),
              Container(
                color: Colors.blue,
                height: 100,
              ),
              Container(
                color: Colors.blue,
                height: 100,
              ),
              Container(
                color: Colors.blue,
                height: 100,
              ),
            ],
          ),
        ),
        Text('data3'),
        Text('data4'),
        // Container(),
      ],
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
