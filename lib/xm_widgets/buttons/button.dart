import 'package:flutter/material.dart';
import 'package:framework/xm_application/app_enum.dart';
import 'package:framework/xm_utils/screen.dart';
import 'package:framework/xm_widgets/widgets_config.dart';

enum XMBtnLvl {
  Normal, //一般
  Warning, //警告
  Danger, //危险
}

enum XMBtnSize {
  XM980_120,
  XM480_100,
}

class XMBtn {
  XMAPPStyle appStyle = XMCtlsConfig.appStyle;

  static Widget create({
    double width, //按钮尺寸
    double height,
    String title = '',
    Function onPressed,
    bool waiting,
    XMBtnLvl lvl, //等级
    double radius = 5, //按钮圆角
    Color titleColor = Colors.black, //文字颜色
    double fontSize = 42, //字体大小
    Color backgroundColor = Colors.white,
    Widget child,
  }) {
    child = child ??
        Center(
          child: Text(
            title,
            style: TextStyle(color: titleColor, fontSize: xmSp(fontSize)),
          ),
        );

    width = null != width ? xmDp(width) : xmDp(980);
    height = null != height ? xmDp(height) : xmDp(120);

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: child,
        ));
  }

  static Widget normal(String title, Function onPressed,
      {bool waiting, double width, double height}) {
    return create(
        title: title,
        onPressed: onPressed,
        lvl: XMBtnLvl.Normal,
        waiting: waiting,
        width: width,
        height: height);
  }

  static warning(String title, Function onPressed,
      {bool waiting, double width, double height}) {
    return create(
        title: title,
        onPressed: onPressed,
        lvl: XMBtnLvl.Warning,
        waiting: waiting,
        width: width,
        height: height);
  }

  static Widget danger(String title, Function onPressed,
      {bool waiting, double width, double height}) {
    return create(
        title: title,
        onPressed: onPressed,
        lvl: XMBtnLvl.Danger,
        waiting: waiting,
        width: width,
        height: height);
  }
}
