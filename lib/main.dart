import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:keep/base/tabs.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:keep/base/route.dart';

void main() {
  runApp(Keep());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  // if (Platform.isAndroid) {
  //   SystemUiOverlayStyle systemUiOverlayStyle =
  //       SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // }
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Color(0xFF000000),
  //   systemNavigationBarDividerColor: null,
  //   statusBarColor: null,
  //   systemNavigationBarIconBrightness: Brightness.light,
  //   statusBarIconBrightness: Brightness.dark,
  //   statusBarBrightness: Brightness.light,
  // ));
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class Keep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return new MaterialApp(
    //   routes: {
    //     "/": (_) => new WebviewScaffold(
    //           url: "https://www.baidu.com",
    //           appBar: new AppBar(
    //             title: new Text("Widget webview"),
    //           ),
    //         ),
    //   },
    // );
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      navigatorObservers: [routeObserver],

      // onGenerateRoute: onGenerateRoute,
      home: Tabs(),
    );
  }
}
