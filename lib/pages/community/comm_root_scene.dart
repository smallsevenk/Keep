import 'package:flutter/material.dart';
import 'package:keep/base/public.dart';
import 'package:keep/models/entrys.dart';
import 'package:keep/models/author.dart';
import 'package:keep/models/entry.dart';
import 'package:keep/models/hot.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keep/widgets/tile_card.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class KeepCommRootScene extends StatefulWidget {
  @override
  KeepCommRootSceneState createState() => KeepCommRootSceneState();
}

class KeepCommRootSceneState extends State<KeepCommRootScene> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  bool _loadMore = true;
  bool _showCancel = false;

  NestedScrollView _supCtr;
  final controller = TextEditingController();

  Widget buildTextField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      alignment: Alignment.centerLeft,
      height: 30.0,
      decoration: new BoxDecoration(
          color: Color(0xfff9f9f9),
          // border: new Border.all(color: Z6Color.bg_gray, width: 0.5),
          borderRadius: new BorderRadius.circular(5.0)),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            child: IconButton(
              padding: EdgeInsets.all(0),
              color: Z6Color.black_3,
              iconSize: 24,
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 14),
              controller: controller,
              cursorColor: Z6Color.gray,
              decoration: InputDecoration.collapsed(
                hintText: '大家都在搜超DD',
              ),
              textInputAction: TextInputAction.search,
              onTap: () {
                setState(() {
                  _showCancel = true;
                });
              },
              onSubmitted: (v) {
                Toast.show('搜个毛线啊，没有接口');
                _showCancel = false;
              },
            ),
          ),
          _showCancel
              ? Container(
                  width: 28,
                  child: IconButton(
                    iconSize: 20,
                    color: Z6Color.gray,
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                    },
                  ),
                )
              : Text('')
        ],
      ),
    );
  }

  NestedScrollView _getSuperWidget() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            expandedHeight: 0.0,
            floating: false,
            snap: false,
            pinned: false,
            leading: null,
            centerTitle: false,
            title: buildTextField(),
            actions: <Widget>[
              _showCancel
                  ? Container(
                      width: 40,
                      height: 20,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          controller.clear();
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            _showCancel = false;
                          });
                        },
                        child: Text(
                          '取消',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    )
                  : IconButton(
                      icon: new Icon(Icons.person_add),
                      color: Colors.grey,
                      iconSize: 18.0,
                      onPressed: () {
                        Navigator.of(context).pushNamed('PushTestScene');
                        // Toast.show('添加好友');
                      },
                    ),
              _showCancel ? SizedBox(width: 10) : Text('')
            ],
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

  int _position = 0; //表示从第几条开始取

  List<Entrys> posts = [];

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
    Hot hot = await Z6Srv.queryHot(_position.toString(), '跑步');
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

  Widget _refreshView() {
    return Container(
      color: Z6Color.bg_gray,
      padding: EdgeInsets.fromLTRB(margin8, margin8, margin8, 0),
      child: SafeArea(
        top: false,
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
          child: _gridView(),
          onRefresh: _refresh,
          loadMore: _fetchData,
        ),
      ),
    );
  }

  Widget _gridView() {
    return StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(0),
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
        staggeredTileBuilder: (index) => StaggeredTile.fit(2));
  }

  Widget _tabBarView() {
    return TabBarView(
      children: [
        Container(child: _refreshView()),
        Text('data2'),
        Text('data3'),
        Text('data4'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Toast.show('点个金币啊111111');
        },
        child: Image(
          image: AssetImage('imgs/comm_photo.png'),
        ),
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
