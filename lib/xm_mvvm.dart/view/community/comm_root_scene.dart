import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:framework/xm_mvvm.dart/model/author.dart';
import 'package:framework/xm_mvvm.dart/model/entry.dart';
import 'package:framework/xm_mvvm.dart/model/entrys.dart';
import 'package:framework/xm_mvvm.dart/model/hot.dart';
import 'package:framework/xm_network/api.dart';
import 'package:framework/xm_network/server.dart';
import 'package:framework/xm_widgets/tile_card.dart';
import '../../../public.dart';

class KeepCommRootScene extends StatefulWidget {
  @override
  KeepCommRootSceneState createState() => KeepCommRootSceneState();
}

class KeepCommRootSceneState extends State<KeepCommRootScene> {
  bool _showCancel = false;
  TabController tabCtr;
  var tabs = ['热门', '关注', '话题', '同城'];
  TextEditingController searchCtr = TextEditingController();

  _searchBarWid() {
    return Container(
      width: xmDp(972),
      height: xmDp(90),
      child: TextField(
        // focusNode: focusNode,
        controller: searchCtr, textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            fillColor: XMColor.contentColor,
            filled: true,
            contentPadding: EdgeInsets.all(2),
            hintText: '搜索',
            hintStyle: TextStyle(color: XMColor.grayColor, fontSize: xmSp(48)),
            prefixIcon: Image.asset('res/imgs/comm_search.png'),
            prefixIconConstraints:
                BoxConstraints(minWidth: xmDp(113), maxHeight: xmDp(51)),
            suffixIcon: searchCtr.text.length > 0
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      searchCtr.text = '';
                    },
                    child: Icon(
                      Icons.cancel,
                      color: XMColor.grayColor,
                    ))
                : SizedBox(),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(xmDp(50)),
            )),
        onTap: () {
          setState(() {
            _showCancel = true;
          });
        },
        onSubmitted: (v) {
          Toast.show('搜个毛线啊，没有接口');
          _showCancel = false;
        },
        style: TextStyle(color: Colors.black, fontSize: xmSp(48)),
        maxLines: 1,
        onChanged: (v) {
          setState(() {});
        },
      ),
    );
  }

  int _position = 0; //表示从第几条开始取

  List<Entrys> posts = [];

  @override
  void dispose() {
    // 资源释放
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabCtr = TabController(
      length: tabs.length,
      vsync: ScrollableState(),
    );
    // 首次拉取数据
    _fetchData();
  }

  Future<void> _fetchData() async {
    Hot hot = await Z6Srv.queryHot(_position.toString(), '瑜伽');
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
      controller: tabCtr,
      labelColor: XMColor.darkGray,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelColor: XMColor.kgray,
      indicatorColor: XMColor.deepGray,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
      tabs: tabs
          .map(
            (e) => Tab(text: e),
          )
          .toList(),
    );
  }

  Widget _refreshView() {
    return Container(
      color: XMColor.bgGray,
      padding: EdgeInsets.fromLTRB(margin8, margin8, margin8, 0),
      child: SafeArea(
        top: false,
        child: EasyRefresh(
          child: _gridView(),
          onRefresh: _refresh,
          onLoad: _fetchData,
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

            img = imgs.length >= 1 ? imgs[0] : Api.hotImg;
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
      controller: tabCtr,
      children: [
        Container(child: _refreshView()),
        XMEmpty.show(
          'Comming Soon',
          iconImgPath: imgPath('smile'),
        ),
        XMEmpty.show(
          'Comming Soon',
          iconImgPath: imgPath('smile'),
        ),
        XMEmpty.show(
          'Comming Soon',
          iconImgPath: imgPath('smile'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _searchBarWid(),
        bottom: PreferredSize(
          child: Container(
            child: _tabBar(),
          ),
          preferredSize: Size(xmSW(), 40),
        ),
        actions: <Widget>[
          _showCancel
              ? Container(
                  width: 40,
                  height: 20,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      searchCtr.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        _showCancel = false;
                      });
                    },
                    child: XMText.create(
                      '取消',
                      color: Colors.green,
                    ),
                  ),
                )
              : IconButton(
                  icon: new Icon(Icons.person_add),
                  color: Colors.grey,
                  iconSize: 22.0,
                  onPressed: () {
                    Toast.show('添加好友');
                  },
                ),
          _showCancel ? SizedBox(width: 10) : Text('')
        ],
      ),
      body: _tabBarView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          commingSoon();
        },
        child: Image(
          image: AssetImage('res/imgs/comm_photo.png'),
        ),
      ),
    );
  }
}
