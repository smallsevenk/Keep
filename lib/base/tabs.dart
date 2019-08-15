import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:keep/base/public.dart';
import 'package:keep/pages/community/comm_root_scene.dart';
import '../pages/explore/explore_root.dart';
import '../pages/sport/sport_root.dart';
import '../pages/plan/plan_root.dart';
import '../pages/me/me_root.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tabs extends StatefulWidget {
  // var tabIndex = 2;
  // Tabs(this.tabIndex);
  @override
  State<StatefulWidget> createState() => TabsState();
}

class TabsState extends State<Tabs> {
  int _tabIndex = 0;
  bool isFinishSetup = false;
  List<Image> _tabImages = [
    Image.asset('imgs/tabs_0_0.png'),
    Image.asset('imgs/tabs_1_0.png'),
    Image.asset('imgs/tabs_2_0.png'),
    Image.asset('imgs/tabs_3_0.png'),
    Image.asset('imgs/tabs_4_0.png'),
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('imgs/tabs_0_1.png'),
    Image.asset('imgs/tabs_1_1.png'),
    Image.asset('imgs/tabs_2_1.png'),
    Image.asset('imgs/tabs_3_1.png'),
    Image.asset('imgs/tabs_4_1.png'),
  ];

  @override
  void initState() {
    super.initState();

    setupApp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setupApp() async {
    // preferences = await SharedPreferences.getInstance();
    setState(() {
      isFinishSetup = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    if (!isFinishSetup) {
      return Container();
    }

    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          KeepCommRootScene(),
          ExploreRootScene(),
          SportPage(),
          PlanPage(),
          MePage(),
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Z6Color.deep_kgray,
        inactiveColor: Z6Color.kgray,
        items: _bottomNavigationBarItem(),
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItem() {
    List titles = ['社区', '探索', '运动', '计划', '我'];
    return titles.map((v) {
      int idx = titles.indexOf(v);
      return BottomNavigationBarItem(
          icon: Container(
            height: 17,
            child: getTabIcon(idx),
          ),
          title: Text(v));
    }).toList();
  }

  Image getTabIcon(int index) {
    if (index == _tabIndex) {
      return _tabSelectedImages[index];
    } else {
      return _tabImages[index];
    }
  }
}
