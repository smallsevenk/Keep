import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/public.dart';

import 'package:framework/xm_mvvm.dart/view/base.dart';
import 'package:framework/xm_mvvm.dart/viewmodel/home_vm.dart';

class HomePage extends XMBasePage {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends XMBasePageState {
  HomeVm vm;

  @override
  void initState() {
    super.initState();
    vm = HomeVm();
  }

  @override
  Widget build(BuildContext context) {
    title = 'Home';
    return super.build(context);
  }

  @override
  buildBody() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                        child: _tabbar(),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          top: xmDp(32),
                          bottom: xmDp(20),
                          left: xmDp(18),
                        )),
                    Container(height: 1, color: XMColor.lineColor),
                  ],
                );
              }, childCount: 1),
            ),
          ),
        ];
      },
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: TabBarView(
          controller: vm.tabCtr,
          children: vm.list.map(
            (e) {
              var list = e[1];
              return ListView.separated(
                  itemBuilder: (ctx, idx) {
                    var data = list[idx];
                    return ListTile(
                      title: XMText.create(data['title']),
                      onTap: data['tap'],
                    );
                  },
                  separatorBuilder: (ctx, idx) {
                    return Divider();
                  },
                  itemCount: list.length);
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _tabbar() {
    return TabBar(
      isScrollable: true,
      controller: vm.tabCtr,
      labelColor: Color(0xff707070),
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: EdgeInsets.symmetric(horizontal: xmDp(15)),
      indicator: BoxDecoration(
          color: Color(0xfff1f1f1),
          borderRadius: BorderRadius.circular(xmDp(14))),
      tabs: vm.list.map((e) {
        return Container(
            width: xmDp(200),
            height: xmDp(80),
            alignment: Alignment.center,
            child: Text(e[0], style: TextStyle(fontSize: xmSp(40))));
      }).toList(),
    );
  }
}
