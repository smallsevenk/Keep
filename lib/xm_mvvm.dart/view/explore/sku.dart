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
    vm.skuWid = skuWid();
  }

  @override
  Widget build(BuildContext context) {
    title = 'SKU';
    showAppBar = false;
    scaffoldColor = Colors.white;
    bottomBar = bottom();
    return super.build(context);
  }

  @override
  buildBody() {
    return Container(
      width: xmSW(),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          bannberWid(),
          Image.asset(
            imgPath('sku_detail'),
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    return Container(
        height: xmDp(170),
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Toast.show('客服');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: XMColor.lineColor, width: 1))),
                    ),
                    Image.asset(
                      imgPath('kf'),
                      width: xmDp(70),
                      color: Color(0xff3c3743),
                    ),
                    SizedBox(height: 3),
                    XMText.create('客服', ftSize: 36),
                    SizedBox(height: 3),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Toast.show('购物车');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: XMColor.lineColor, width: 1))),
                    ),
                    Image.asset(
                      imgPath('cart'),
                      width: xmDp(70),
                      color: Color(0xff3c3743),
                    ),
                    SizedBox(height: 3),
                    XMText.create('购物车', ftSize: 36),
                    SizedBox(height: 3),
                  ],
                ),
              ),
            ),
            XMBtn.create(
              width: xmSourceDp(xmSW() / 3),
              height: 170,
              title: '加入购物车',
              fontSize: 48,
              radius: 0,
              titleColor: Colors.white,
              backgroundColor: Color(0xff3c3743),
              onPressed: () {
                XMSheet.present(context, vm.skuWid);
              },
            ),
            XMBtn.create(
              width: xmSourceDp(xmSW() / 3),
              height: 170,
              title: '立即购买',
              fontSize: 48,
              radius: 0,
              titleColor: Colors.white,
              backgroundColor: Color(0xff5cbc86),
              onPressed: () {
                XMSheet.present(context, vm.skuWid);
              },
            ),
          ],
        ));
  }

  Widget skuView(int idx, List sku) {
    return Container(
        margin: EdgeInsets.only(top: xmDp(16), bottom: xmDp(16)),
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
                          color: vm.skus[idx][0] == tag
                              ? Colors.green[50]
                              : Colors.grey[200],
                          border: Border.all(
                              color: vm.skus[idx][0] == tag
                                  ? Color(0xff5cbc86)
                                  : Colors.transparent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(xmDp(40)))),
                      padding: EdgeInsets.fromLTRB(
                          xmDp(60), xmDp(10), xmDp(60), xmDp(10)),
                      child: Text(
                        v,
                        style: TextStyle(
                            fontSize: xmSp(36),
                            color:
                                vm.has(idx, tag) ? Colors.black : Colors.grey),
                      ),
                    ));
              },
            ).toList()));
  }

//bannber图
  Widget bannberWid() {
    double bannerH = xmDp(576);
    if (vm.banners.isEmpty) return SizedBox();
    return Stack(
      children: <Widget>[
        CarouselSlider(
          viewportFraction: 1.0,
          aspectRatio: 1,
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
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 10, height: 150),
            GestureDetector(
                onTap: () {
                  xmPop();
                },
                child: CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.grey[400],
                  child: Image.asset(
                    imgPath('sku_back'),
                    width: 22,
                  ),
                )),
            Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 17,
                backgroundColor: Colors.grey[400],
                child: Image.asset(
                  imgPath('back_home'),
                  width: 22,
                ),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 17,
                backgroundColor: Colors.grey[400],
                child: Image.asset(
                  imgPath('share'),
                  width: 22,
                ),
              ),
            ),
            SizedBox(width: 10),
          ],
        )
      ],
    );
  }

  Widget inputRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            var count = int.parse(vm.ctr.text);
            if (count == 1) {
              Toast.show('最少选择1件');
              return;
            }
            vm.ctr.text = (--count).toString();
            vm.skuWid.reload();
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: xmDp(35),
            child: Image.asset(
              imgPath('count-'),
              color: Colors.white,
              width: xmDp(35),
              height: xmDp(35),
            ),
          ),
        ),
        Container(
          width: xmDp(140),
          height: 100,
          child: Center(
              child: TextField(
            controller: vm.ctr,
            enabled: false,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              color: XMColor.grayColor,
              fontSize: xmSp(46),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 14),
              border: InputBorder.none,
            ),
            // inputFormatters: [XMInputFormatter.numInputFormatter(6)],
          )),
        ),
        GestureDetector(
          onTap: () {
            var count = int.parse(vm.ctr.text);

            vm.ctr.text = (++count).toString();
            vm.skuWid.reload();
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: xmDp(35),
            child: Image.asset(
              imgPath('count+'),
              color: Colors.white,
              width: xmDp(35),
              height: xmDp(35),
            ),
          ),
        ),
      ],
    );
  }

  XMRefreshWidget skuWid() {
    var path = vm.banners[0]['url'];
    return XMRefreshWidget(
      builder: (ctx) {
        return Container(
          color: Colors.white,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(margin8 * 2),
            children: vm.skus.map(
              (sku) {
                int idx = vm.skus.indexOf(sku);
                if (sku == 'showInfo') {
                  return Row(
                    children: <Widget>[
                      XMText.create('购买数量'),
                      Expanded(child: SizedBox()),
                      inputRow()
                    ],
                  );
                }
                if (sku == 'btn') {
                  return XMBtn.create(
                      title: '确定',
                      backgroundColor: Color(0xff5cbc86),
                      titleColor: Colors.white,
                      fontSize: 52,
                      onPressed: () {
                        commingSoon();
                      });
                }
                if ('header' == sku) {
                  var temp0 = vm.showInfo.split(' ')[0].split(':');
                  var temp1 = vm.showInfo.split(' ')[1].split(':');
                  var type0 = vm.choiceInfo.contains(":")
                      ? vm.choiceInfo.split(":")[0] + ' : '
                      : vm.choiceInfo;

                  var type1 = vm.choiceInfo.contains(":")
                      ? vm.choiceInfo.split(":")[1]
                      : '';
                  print(vm.choiceInfo);
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      xmNetWorkImage(
                        path,
                        240,
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 15),
                          RichText(
                            text: TextSpan(
                              text: temp0[0] + ' : ',
                              style: TextStyle(
                                fontSize: xmSp(40),
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: temp0[1],
                                  style: TextStyle(
                                    color: Color(0xff5cbc86),
                                    fontSize: xmSp(40),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              text: temp1[0] + ' : ',
                              style: TextStyle(
                                fontSize: xmSp(40),
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: temp1[1],
                                  style: TextStyle(
                                    color: Color(0xff5cbc86),
                                    fontSize: xmSp(40),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              XMText.create(type0, ftSize: 40),
                              XMText.create(type1,
                                  ftSize: 40, color: Color(0xff5cbc86)),
                            ],
                          )
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          XMSheet.close();
                        },
                        child: Image.asset(
                          imgPath('icon_evaluation_close@3x'),
                          width: xmDp(50),
                          color: XMColor.gray,
                        ),
                      ),
                    ],
                  );
                }
                if (sku is String) {
                  return Row(children: <Widget>[
                    SizedBox(height: xmDp(130)),
                    XMText.create(sku, ftSize: 42)
                  ]);
                }

                return skuView(idx, sku[1]);
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
