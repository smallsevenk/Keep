import 'package:flutter/material.dart';

import 'package:keep/base/public.dart';
import 'package:keep/models/hot.dart';
import 'package:keep/network/server.dart';

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
  // List<CarouselInfo> carouselInfos = [];
  int pageIndex = 1;
  // List<HomeModule> modules = [];
  Hot hotInfo;

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  @override
  bool get wantKeepAlive => true;

  // Future<void> fetchData() async {
  //   try {
  //     var result;
  //     switch (this.widget.type) {
  //       case HomeListType.hot:
  //         result = await Hot.request();
  //         break;
  //       case HomeListType.foucs:
  //         result = await Hot.request();
  //         break;
  //       case HomeListType.topic:
  //         result = await Hot.request();
  //         break;
  //       case HomeListType.local:
  //         result = await Hot.request();
  //         break;
  //       default:
  //         break;
  //     }
  //     // List moduleData = responseJson['module'];
  //     // List<HomeModule> modules = [];
  //     // moduleData.forEach((data) {
  //     //   modules.add(HomeModule.fromJson(data));
  //     // });
  //     print(result);
  //     setState(() {
  //       // this.modules = modules;
  //       // this.carouselInfos = carouselInfos;
  //       this.res = result;
  //     });
  //   } catch (e) {
  //     Toast.show(e.toString());
  //   }
  // }
  Future<void> fetchData() async {
    try {
      Map<String, dynamic> hotJson = await Z6Srv.queryHot();

      setState(() {
        print(hotJson);
        this.hotInfo = Hot.fromJson(hotJson);
      });
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  // Widget bookCardWithInfo(HomeModule module) {
  //   Widget card;
  //   switch (module.style) {
  //     case 1:
  //       card = NovelFourGridView(module);
  //       break;
  //     case 2:
  //       card = NovelSecondHybirdCard(module);
  //       break;
  //     case 3:
  //       card = NovelFirstHybirdCard(module);
  //       break;
  //     case 4:
  //       card = NovelNormalCard(module);
  //       break;
  //   }
  //   return card;
  // }

  List<Widget> _getWrap(int idx) {
    List<Widget> temp = new List<Widget>();
    // res = res ?? {};
    // this.res.forEach((v) {
    //   print(v);
    //   temp.add(Text('v'));
    // });
    return temp;
  }

  Widget buildModule() {
    if (this.widget.type == HomeListType.hot) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Wrap(
              // direction: Axis.vertical,
              children: _getWrap(0),
            ),
          ),
          Expanded(
            child: Wrap(
              direction: Axis.vertical,
              children: _getWrap(0),
            ),
          )
        ],
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
      onRefresh: fetchData,
      child: buildModule(),
    ));
  }
}
