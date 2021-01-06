import 'package:flutter/material.dart';
import 'package:framework/xm_mvvm.dart/view/sku.dart';
import 'package:framework/xm_utils/router.dart';

class HomeVm {
  TabController tabCtr;
  List list = [
    [
      'Widgets',
      [
        {
          'title': 'SKU1',
          'tap': () {
            xmPush(SKUPage());
          }
        }
      ]
    ],
    [
      '知识点',
      [
        {
          'title': 'SKU2',
          'tap': () {
            xmPush(SKUPage());
          }
        }
      ]
    ],
    [
      'MiniApp',
      [
        {
          'title': '电商',
          'tap': () {
            xmPush(SKUPage());
          }
        }
      ]
    ]
  ];

  HomeVm() {
    tabCtr = TabController(vsync: ScrollableState(), length: list.length);
  }
}
