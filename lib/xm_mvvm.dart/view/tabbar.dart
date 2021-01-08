/// Created with VSCode.
/// Author: 淡然
/// Date: 2021-01-05
/// Time: 11:56
/// Email: smallsevenk@vip.qq.com
/// Target: XMTabbar
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/public.dart';
import 'package:framework/xm_mvvm.dart/view/base.dart';

import 'community/comm_root_scene.dart';
import 'explore/explore_root.dart';
import 'me/me_root.dart';
import 'plan/plan_root.dart';
import 'sport/sport_root.dart';

class XMTabbarPage extends XMBasePage {
  XMTabbarPage({Key key}) : super(key: key);
  @override
  _XMTabbarPageState createState() => _XMTabbarPageState();
}

class _XMTabbarPageState extends XMBasePageState {
  List<String> fastInfo = ['社区', '探索', '运动', '计划', '我'];
  int currIdx = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    showAppBar = false;
    bottomBar = tabbarBar();
    return super.build(context);
  }

  @override
  buildBody() {
    return IndexedStack(
      children: <Widget>[
        KeepCommRootScene(),
        ExploreRootScene(),
        SportPage(),
        PlanPage(),
        MePage(),
      ],
      index: currIdx,
    );
  }

  BottomAppBar tabbarBar() {
    return BottomAppBar(
        elevation: 0,
        shape: CircularNotchedRectangle(),
        color: XMColor.navColor,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: xmDp(1), color: XMColor.contentColor),
                  bottom: BorderSide.none)),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _fastEntryView()),
        ));
  }

  //快捷入口
  List<Widget> _fastEntryView() {
    return fastInfo.map((v) {
      int idx = fastInfo.indexOf(v);
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          currIdx = idx;
          setState(() {});
        },
        child: Container(
          height: xmAppBarH,
          child: Container(
              width: xmSW() / fastInfo.length,
              child: Column(
                children: <Widget>[
                  SizedBox(height: xmDp(19)),
                  Container(
                    height: xmDp(55),
                    child: getTabIcon(idx),
                  ),
                  SizedBox(height: xmDp(16)),
                  Text(
                    v,
                    style: TextStyle(
                        color:
                            idx == currIdx ? Colors.black : XMColor.grayColor,
                        fontSize: xmSp(36)),
                  )
                ],
              )),
        ),
      );
    }).toList();
  }

  Image getTabIcon(int index) {
    if (index == currIdx) {
      return Image.asset('res/imgs/tab_$index.png');
    } else {
      return Image.asset('res/imgs/tab_$index.png', color: Colors.grey);
    }
  }
}
