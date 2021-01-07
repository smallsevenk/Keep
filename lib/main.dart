import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:framework/public.dart';

import 'xm_mvvm.dart/view/tabbar.dart';

const debug = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  // while (window.physicalSize.isEmpty) {}
  // //如果size是0，则设置回调，在回调中runApp
  // if (window.physicalSize.isEmpty) {
  //   window.onMetricsChanged = () async {
  //     //在回调中，size仍然有可能是0
  //     if (!window.physicalSize.isEmpty) {
  //       window.onMetricsChanged = null;
  //       await XMAppGlobal.init();
  //       runApp(new MyApp());
  //     }
  //   };
  // } else {
  //   //如果size非0，则直接runApp
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MaterialApp(
          navigatorKey: xmNavGK,
          title: 'XM',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          home: XMTabbarPage()),
    );
  });
}
