import 'package:flutter/material.dart';
import 'package:keep/base/public.dart';
import 'package:keep/models/hot.dart';
import 'package:keep/network/server.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({Key key}) : super(key: key);

  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  Hot hotInfo;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      Map<String, dynamic> hotJson = await Z6Srv.queryHot();
      print('-------------------------');
      setState(() {
        this.hotInfo = Hot.fromJson(hotJson);
        print(this.hotInfo);
      });
    } catch (e) {
      print(e.toString());
      Toast.show(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TabBar(
              labelColor: Z6Color.darkGray,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: Z6Color.gray,
              indicatorColor: Z6Color.secondary,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
              tabs: [
                Tab(text: '热门'),
                Tab(text: '关注'),
                Tab(text: '话题'),
                Tab(text: '同城'),
              ],
            ),
          ),
          backgroundColor: Z6Color.white,
          elevation: 0,
        ),
        body: TabBarView(children: [
          Text('data'), Text('data'), Text('data'), Text('data'),
          // CommunityListView(HomeListType.hot),
          // CommunityListView(HomeListType.foucs),
          // CommunityListView(HomeListType.topic),
          // CommunityListView(HomeListType.local),
        ]),
      ),
    );
  }
}
