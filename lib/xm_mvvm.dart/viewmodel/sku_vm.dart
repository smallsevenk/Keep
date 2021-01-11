import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:framework/public.dart';
import 'package:framework/xm_mvvm.dart/view/explore/sku.dart';
import 'package:framework/xm_utils/toast.dart';

class SKUVm {
  SKUPageState st;
  //  **商品规格  ：
  // 款式 ： F    M
  // 颜色 ： R    G    B
  // 尺寸 ： L    X    S

  List skus = [
    'header',
    '选择款式',
    [
      -1,
      ['女', '男']
    ],
    '选择颜色',
    [
      -1,
      [
        '粉色',
        '黑色',
        '深花灰',
        '橡胶粉',
        '松石蓝',
        '圣紫色',
        '麻灰色',
      ]
    ],
    '选择尺寸',
    [
      -1,
      ['S', 'M', 'L']
    ],
    'showInfo',
    'btn'
  ];

  List data = [
    ['女_黑色_L', 1, 100],
    ['女_黑色_M', 2, 200],
    ['女_黑色_S', 3, 300],
    ['女_圣紫色_L', 4, 400],
    ['女_圣紫色_M', 5, 500],
    ['女_深花灰_L', 7, 700],
    ['女_深花灰_M', 8, 800],
    ['女_深花灰_S', 9, 900],
    ['男_黑色_L', 10, 1000],
    ['男_黑色_M', 11, 1100],
    ['男_黑色_S', 12, 1200],
    ['男_圣紫色_L', 13, 1300],
    ['男_圣紫色_M', 14, 1400],
    ['男_圣紫色_S', 15, 1500],
    ['男_深花灰_L', 16, 1600],
    ['男_深花灰_M', 17, 1700],
    ['男_深花灰_S', 18, 1800],
  ];

  List banners = [
    {
      'url':
          'https://gd3.alicdn.com/imgextra/i3/3010695444/O1CN01IB62Qv1q5OonPD2Vv_!!3010695444.jpg',
      'activity': null
    },
    {
      'url':
          'https://gd3.alicdn.com/imgextra/i3/3010695444/O1CN01yUGwq61q5OokiQi1q_!!3010695444.jpg',
      'activity': null
    },
  ];
  TextEditingController ctr = TextEditingController(text: '1');

  List tempSku = [];
  XMRefreshWidget skuWid;
  SKUVm(this.st) {
    curr();
  }

  bool has(int row, int col) {
    var temp = skus[row][0];
    if (skus[row][0] == col) {
      skus[row][0] = -1;
    } else {
      skus[row][0] = col;
    }
    curr();
    var result = true;
    if (tempSku.length <= 0) {
      result = false;
    }
    skus[row][0] = temp;
    curr();
    return result;
  }

  void typeOnTap(int row, int col) {
    var temp = skus[row][0];
    if (skus[row][0] == col) {
      skus[row][0] = -1;
    } else {
      skus[row][0] = col;
    }
    curr();
    if (tempSku.length <= 0) {
      Toast.show('该商品已售罄！');

      skus[row][0] = temp;
      curr();
    }
    st.setState(() {});
    skuWid.reload();
  }

  void curr({int idx = 2, List source}) {
    source = source ?? data;
    if (idx == 8) {
      tempSku = source;
    } else {
      String type = skus[idx][0] == -1 ? '' : skus[idx][1][skus[idx][0]];
      var temp = [];
      if (type.isEmpty) {
        temp = source;
      } else {
        for (var sku in source) {
          String skuKey = sku[0];
          if (type.isNotEmpty && skuKey.contains(type)) {
            temp.add(sku);
          }
        }
      }

      idx += 2;
      curr(idx: idx, source: temp);
    }
  }

  String get showInfo {
    Decimal minPrice;
    Decimal maxPrice = Decimal.zero;
    Decimal amount = Decimal.zero;

    for (var sku in tempSku) {
      minPrice = minPrice ?? Decimal.fromInt(sku[2]);
      minPrice = minPrice > Decimal.fromInt(sku[2])
          ? Decimal.fromInt(sku[2])
          : minPrice;
      maxPrice = maxPrice > Decimal.fromInt(sku[2])
          ? maxPrice
          : Decimal.fromInt(sku[2]);

      amount += Decimal.fromInt(sku[1]);
    }
    var price = (minPrice == maxPrice
        ? maxPrice.toString()
        : minPrice.toString() + '-' + maxPrice.toString());
    return '价格:${price.toString()} 库存:${amount.toString()}件';
  }

  String get choiceInfo {
    String choiceInfo = '';
    for (var idx in [2, 4, 6]) {
      String type = skus[idx][0] == -1 ? '' : skus[idx][1][skus[idx][0]];
      if (type.isNotEmpty) {
        if (choiceInfo.isNotEmpty) {
          choiceInfo = choiceInfo + ' ; ';
        }
        choiceInfo = choiceInfo + type;
      }
    }
    if (choiceInfo.isEmpty) {
      choiceInfo = '请选择规格';
    } else {
      choiceInfo = '已选择:' + choiceInfo;
    }
    return choiceInfo;
  }
}
