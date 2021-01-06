import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final xmNavGK = new GlobalKey<NavigatorState>();
final NavigatorState xmNav = xmNavGK.currentState;

Future<dynamic> xmPush(Widget page, {bool root = false}) {
  Route route = CupertinoPageRoute(
      builder: (context) => page,
      settings: RouteSettings(name: page.toStringShort()));

  return xmNav.push(route);
}

xmPop<T extends Object>([T result]) {
  xmNav.pop(result);
}

xmPopTo(Widget popWidget) {
  var predicate = ModalRoute.withName(popWidget.toStringShort());
  xmNav.popUntil(predicate);
}

xmPopToRoot() {
  xmNav.popAndPushNamed('/');
}
