import 'package:flutter/material.dart';
import 'package:keep/base/public.dart';
import 'community_list_view.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({Key key}) : super(key: key);

  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('keep'),
              bottom: TabBar(
                controller: this._tabController,
                tabs: [
                  Tab(text: '热门'),
                  Tab(text: '关注'),
                  Tab(text: '话题'),
                  Tab(text: '同城'),
                ],
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: TabBar(
              //     controller: this._tabController,
              //     labelColor: Z6Color.darkGray,
              //     labelStyle:
              //         TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //     unselectedLabelColor: Z6Color.kgray,
              //     indicatorColor: Z6Color.deep_kgray,
              //     indicatorSize: TabBarIndicatorSize.label,
              //     indicatorWeight: 2,
              //     indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
              //     tabs: [
              //       Tab(text: '热门'),
              //       Tab(text: '关注'),
              //       Tab(text: '话题'),
              //       Tab(text: '同城'),
              //     ],
              //   ),
              // ),
            )
          ];
        },
        body: TabBarView(
          controller: this._tabController,
          children: [
            CommunityListView(HomeListType.hot),
            CommunityListView(HomeListType.foucs),
            CommunityListView(HomeListType.topic),
            CommunityListView(HomeListType.local),
          ],
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: 4,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         brightness: Brightness.light,
  //         title: Container(
  //           padding: EdgeInsets.symmetric(horizontal: 15),
  //           child: TabBar(
  //             labelColor: Z6Color.darkGray,
  //             labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //             unselectedLabelColor: Z6Color.kgray,
  //             indicatorColor: Z6Color.deep_kgray,
  //             indicatorSize: TabBarIndicatorSize.label,
  //             indicatorWeight: 2,
  //             indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
  //             tabs: [
  //               Tab(text: '热门'),
  //               Tab(text: '关注'),
  //               Tab(text: '话题'),
  //               Tab(text: '同城'),
  //             ],
  //           ),
  //         ),
  //         backgroundColor: Z6Color.white,
  //         elevation: 0,
  //       ),
  //       body: TabBarView(children: [
  //         CommunityListView(HomeListType.hot),
  //         CommunityListView(HomeListType.foucs),
  //         CommunityListView(HomeListType.topic),
  //         CommunityListView(HomeListType.local),
  //       ]),
  //     ),
  //   );
  // }
}
