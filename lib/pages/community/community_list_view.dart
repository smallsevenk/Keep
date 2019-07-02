import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:keep/base/public.dart';
import 'package:keep/models/author.dart';
import 'package:keep/models/entry.dart';
import 'package:keep/models/entrys.dart';
import 'package:keep/models/hot.dart';
import 'package:keep/network/server.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keep/widgets/tile_card.dart';

enum HomeListType {
  hot,
  foucs,
  topic,
  local,
}

class CommunityListView extends StatefulWidget {
  final HomeListType type;

  CommunityListView(this.type);

  @override
  State<StatefulWidget> createState() {
    return CommunityListViewState();
  }
}

class CommunityListViewState extends State<CommunityListView>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = new ScrollController();
  // int _beLoad = 0; // 0表示不显示, 1表示正在请求, 2表示没有更多数据
  int _position = 0; //表示从第几条开始取

  List<Entrys> posts = [];

  Widget buildModule() {
    if (this.widget.type == HomeListType.hot) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(margin8),
        child: StaggeredGridView.countBuilder(
            controller: _scrollController,
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
              } finally {
                //     print('''\n      img:$img
                // content:$content
                // avatar:$avatar
                // name:$name
                // likes:$likes''');
                //     print('------' + (idx % 3).toString());
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
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Container(
        child: RefreshIndicator(onRefresh: _refresh, child: buildModule()));
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _refresh() async {
    _position = 0;
    _fetchData();
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

  @override
  void initState() {
    super.initState();
    // 首次拉取数据
    _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _position = posts.length;
        _fetchData();
        print('我监听到底部了!');
      } else if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        print('下拉下拉下拉下拉下拉下拉下拉下拉下拉下拉!');
      }
    });
  }
}
