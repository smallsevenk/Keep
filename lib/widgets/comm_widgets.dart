import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/base/color.dart';

class commWidgets extends StatelessWidget {
  static _sectionView(title, bool showDetail) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: <Widget>[
          SizedBox(
            width: ScreenUtil().setWidth(28),
            height: ScreenUtil().setWidth(78),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28), color: Z6Color.deep_kgray),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: showDetail
                      ? Container(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                          decoration: BoxDecoration(
                              color: Color(0xff5fc48f),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            '发现课程',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )
                      : Text(''),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(28),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _grayGap() {
    return Container(
      height: ScreenUtil().setHeight(22),
      color: Z6Color.bg_gray,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
