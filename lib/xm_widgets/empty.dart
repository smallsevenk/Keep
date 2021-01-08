import 'package:flutter/cupertino.dart';

import '../public.dart';

class XMEmpty {
  static Widget show(
    String tip, {
    Function onTap,
    String des,
    String iconImgPath,
    double width,
    Size imgSize,
    double marginTop,
    double iconTxtMargin,
    Widget custom,
  }) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Column(
        children: [
          SizedBox(width: width ?? xmSW(), height: marginTop ?? xmDp(590)),
          null != iconImgPath
              ? Image(
                  // color: XColor.grayColor,
                  image: AssetImage(iconImgPath),
                  width: null != imgSize ? imgSize.width : 40,
                  height: null != imgSize ? imgSize.height : 40)
              : SizedBox(),
          null != iconImgPath
              ? SizedBox(height: xmDp(iconTxtMargin ?? 60))
              : SizedBox(),
          XMText.create(tip, ftSize: 44, color: Color(0xffC6C6C6)),
          null != des ? SizedBox(height: xmDp(27)) : SizedBox(),
          null != des
              ? XMText.create(des, ftSize: 35, color: Color(0xffC6C6C6))
              : SizedBox(),
          null != custom ? SizedBox(height: xmDp(27)) : SizedBox(),
          null != custom ? custom : SizedBox(),
        ],
      ),
    );
  }
}
