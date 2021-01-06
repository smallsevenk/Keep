import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework/public.dart';
import 'dart:ui' as ui show window;

num xmDp(num w) => ScreenUtil().setWidth(w);

/// 原尺寸.
num xmSourceDp(num w) => w / ScreenUtil().scaleWidth;

/// 字体.
num xmSp(num s) => ScreenUtil().setSp(s);

/// 屏幕宽.
num xmSW() => ScreenUtil.screenWidthDp;

/// 屏幕高.
num xmSH() => ScreenUtil.screenHeightDp;

Size xmSize(num w, num h) => Size(xmDp(w), xmDp(h));
Size xmSize2(Size size) => Size(xmDp(size.width), xmDp(size.height));
EdgeInsets xmLTRB(num l, num t, num r, num b) =>
    EdgeInsets.fromLTRB(xmDp(l), xmDp(t), xmDp(r), xmDp(b));
num xmAppBarH = xmDp(170);

class Screen {
  static double get width {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.width;
  }

  static double get height {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.height;
  }

  static double get scale {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.devicePixelRatio;
  }

  static double get textScaleFactor {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.textScaleFactor;
  }

  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.bottom;
  }

  static updateStatusBarStyle(SystemUiOverlayStyle style) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}
// class XMScreenUtil {
//   static const double defaultWidth = 1080;

//   static XMScreenUtil _instance;
//   static Size screenSize;

//   /// UI设计中手机尺寸 , px
//   double _uiWidthPx;

//   XMScreenUtil._();

//   factory XMScreenUtil() {
//     return _instance;
//   }

//   static void init(
//       {double width = defaultWidth, bool allowFontScaling = false}) {
//     if (_instance == null) {
//       _instance = XMScreenUtil._();
//     }
//     _instance._uiWidthPx = width;
//     Toast.show(window.physicalSize.toString());
//     screenSize = window.physicalSize;
//   }

//   /// 实际的dp与UI设计px的比例
//   double scale() => screenSize.width / _uiWidthPx;

//   double getDp(double px) => px * scale() / window.devicePixelRatio;
// }

// double xmDp(double w) => XMScreenUtil().getDp(w);
// double get xmScreenW => XMScreenUtil.screenSize.width / window.devicePixelRatio;
// double get xmScreenH =>
//     XMScreenUtil.screenSize.height / window.devicePixelRatio;
// Size xmSize(double w, double h) => Size(xmDp(w), xmDp(h));
// Size xmSizeWithSize(Size size) => Size(xmDp(size.width), xmDp(size.height));
// EdgeInsets xmEIFromLTRB(double l, double t, double r, double b) =>
//     EdgeInsets.fromLTRB(xmDp(l), xmDp(t), xmDp(r), xmDp(b));

// double xmAppBarHeight = 66.0;
