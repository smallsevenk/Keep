import 'package:carousel_slider/carousel_slider.dart';

/// Created with VSCode.
/// Author: 淡然
/// Date: 2021-01-03
/// Time: 10:21
/// Email: smallsevenk@vip.qq.com
/// Target: SKU
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/public.dart';
import 'package:framework/xm_mvvm.dart/view/base.dart';
import 'package:framework/xm_mvvm.dart/viewmodel/sku_vm.dart';
import 'package:framework/xm_utils/toast.dart';

class SKUPage extends XMBasePage {
  SKUPage({Key key}) : super(key: key);
  @override
  SKUPageState createState() => SKUPageState();
}

class SKUPageState extends XMBasePageState {
  SKUVm vm;
  @override
  void initState() {
    super.initState();
    vm = SKUVm(this);
  }

  @override
  Widget build(BuildContext context) {
    title = 'SKU';
    showAppBar = false;
    bottomBar = Row(
      children: <Widget>[
        XMBtn.create(
          width: xmSourceDp(xmSW() / 2),
          height: 200,
          title: '立即购买',
          fontSize: 48,
          radius: 0,
          backgroundColor: Colors.orange,
        ),
        XMBtn.create(
          width: xmSourceDp(xmSW() / 2),
          height: 200,
          title: '加入购物车',
          fontSize: 48,
          radius: 0,
          backgroundColor: Colors.green,
        ),
      ],
    );
    return super.build(context);
  }

  @override
  buildBody() {
    return Container(
      width: xmSW(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: vm.skus.map(
          (sku) {
            int idx = vm.skus.indexOf(sku);
            if (sku == 'showInfo') {
              return XMText.create('    ' + vm.showInfo);
            }
            if ('banner' == sku) {
              return bannberWid();
            }
            if (sku is String) {
              return XMText.create('    ' + sku);
            }

            return skuView(idx, sku[1]);
          },
        ).toList(),
      ),
    );
  }

  Widget skuView(int idx, List sku) {
    return Container(
        margin: EdgeInsets.only(top: xmDp(16), bottom: xmDp(16), left: 20),
        child: Wrap(
            spacing: xmDp(30),
            runSpacing: xmDp(30),
            alignment: WrapAlignment.start,
            children: sku.map(
              (v) {
                int tag = sku.indexOf(v);

                return GestureDetector(
                    onTap: () {
                      vm.typeOnTap(idx, tag);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: XMColor.lineColor,
                          border: Border.all(
                              color: vm.skus[idx][0] == tag
                                  ? Colors.red
                                  : Colors.transparent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(xmDp(24)))),
                      padding: EdgeInsets.fromLTRB(
                          xmDp(20), xmDp(10), xmDp(20), xmDp(10)),
                      child: Text(
                        v,
                        style: TextStyle(
                          fontSize: xmSp(46),
                        ),
                      ),
                    ));
              },
            ).toList()));
  }

//bannber图
  Widget bannberWid() {
    double bannerH = xmDp(576);
    if (vm.banners.isEmpty) return SizedBox();
    return CarouselSlider(
      viewportFraction: 1.0,
      aspectRatio: 2.0,
      autoPlay: true,
      enlargeCenterPage: false,
      items: vm.banners.map(
        (banner) {
          String url = banner['url'];
          String activity = banner['activity'];
          return new Builder(
            builder: (BuildContext context) {
              return Container(
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (activity.isNotEmpty) {
                        // xwPush(
                        //   context,
                        // XWebView(url: action),
                        // );
                      } else {
                        Toast.show('暂未开放');
                      }
                    },
                    child: Container(
                      width: xmSW(),
                      height: bannerH,
                      child: ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
