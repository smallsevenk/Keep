import 'package:decimal/decimal.dart';
import 'package:framework/xm_mvvm.dart/view/sku.dart';
import 'package:framework/xm_utils/toast.dart';

class SKUVm {
  SKUPageState st;
  //  **商品规格  ：
  // 款式 ： F    M
  // 颜色 ： R    G    B
  // 尺寸 ： L    X    S

  List skus = [
    'banner',
    '款式',
    [
      -1,
      ['F', 'M']
    ],
    '颜色',
    [
      -1,
      [
        'RRRReddddddddddddddddd',
        'Green',
        'Blueeeeeeee',
      ]
    ],
    '尺寸',
    [
      -1,
      ['L', 'X', 'S']
    ],
    'showInfo',
  ];

  List data = [
    ['F_RRRReddddddddddddddddd_L', 1, 100],
    ['F_RRRReddddddddddddddddd_X', 2, 200],
    ['F_RRRReddddddddddddddddd_S', 3, 300],
    ['F_Green_L', 4, 400],
    ['F_Green_X', 5, 500],
    // ['F-Green_S', 6, 600],
    ['F_Blueeeeeeee_L', 7, 700],
    ['F_Blueeeeeeee_X', 8, 800],
    ['F_Blueeeeeeee_S', 9, 900],
    ['M_RRRReddddddddddddddddd_L', 10, 1000],
    ['M_RRRReddddddddddddddddd_X', 11, 1100],
    ['M_RRRReddddddddddddddddd_S', 12, 1200],
    ['M_Green_L', 13, 1300],
    ['M_Green_X', 14, 1400],
    ['M_Green_S', 15, 1500],
    ['M_Blueeeeeeee_L', 16, 1600],
    ['M_Blueeeeeeee_X', 17, 1700],
    ['M_Blueeeeeeee_S', 18, 1800],
  ];

  List banners = [
    {
      'url':
          'https://img.alicdn.com/imgextra/i4/2201483647113/O1CN01kKvCl422PnriptCzA_!!0-item_pic.jpg_430x430q90.jpg',
      'activity': null
    },
    {
      'url':
          'https://img.alicdn.com/imgextra/i4/2201483647113/O1CN01RA7f6x22PnrcsngDy_!!2201483647113.jpg_430x430q90.jpg',
      'activity': null
    },
  ];

  List tempSku = [];

  SKUVm(this.st) {
    curr();
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

    // ignore: invalid_use_of_protected_member
    st.setState(() {});
  }

  void curr({int idx = 2, List source}) {
    source = source ?? data;
    if (idx == 8) {
      tempSku = source;
    } else {
      // tempSku = [];
      String type = skus[idx][0] == -1 ? '' : skus[idx][1][skus[idx][0]];
      // String type2 = skus[4][0] == -1 ? '' : skus[4][1][skus[4][0]];
      // String type3 = skus[6][0] == -1 ? '' : skus[6][1][skus[6][0]];
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

    // var temp4 = [];
    // if (type2.isEmpty) {
    //   temp4 = temp2;
    // } else {
    //   for (var sku in temp2) {
    //     String skuKey = sku[0];
    //     if (type2.isNotEmpty && skuKey.contains(type2)) {
    //       temp4.add(sku);
    //     }
    //   }
    // }

    // var temp6 = [];
    // if (type3.isEmpty) {
    //   temp6 = temp4;
    // } else {
    //   for (var sku in temp4) {
    //     String skuKey = sku[0];
    //     if (type3.isNotEmpty && skuKey.contains(type3)) {
    //       temp6.add(sku);
    //     }
    //   }
    // }

    // return temp6;
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
    return '价格:${price.toString()}  库存: ${amount.toString()}件';
  }
}
