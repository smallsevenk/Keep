import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:keep/base/tabs.dart';

import 'base/route.dart';

void main() {
  runApp(Keep());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class Keep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
