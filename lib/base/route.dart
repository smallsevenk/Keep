import 'package:flutter/material.dart';
import '../base/tabs.dart';
import '../pages/community/community_root.dart';
import '../pages/explore/explore_root.dart';
import '../pages/sport/sport_root.dart';
import '../pages/plan/plan_root.dart';
import '../pages/me/me_root.dart';

import '../pages/push_test.dart';

final routes = {
  '/': (context, {arguments}) => Tabs(),
  '/community_root': (context, {arguments}) => CommunityPage(),
  '/explore_root': (context, {arguments}) => ExploreRootScene(),
  '/sport_root': (context) => SportPage(),
  '/plan_root': (context) => PlanPage(),
  '/me_root': (context) => MePage(),
  '/PushTestScene': (context) => PushTestScene(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  } else {
    final Route route =
        MaterialPageRoute(builder: (context) => pageContentBuilder(context));
    return route;
  }
};
