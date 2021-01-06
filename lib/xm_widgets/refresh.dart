import 'package:flutter/material.dart';

abstract class XMRefreshBaseWidget extends StatefulWidget {
  XMRefreshBaseWidget({Key key})
      : super(key: key is GlobalKey ? key : GlobalKey());

  void reload() {
    if (key is! GlobalKey) {
      return;
    }
    final aKey = key as GlobalKey;
    State<StatefulWidget> curSt = aKey.currentState;
    // ignore: invalid_use_of_protected_member
    if (null != curSt) curSt.setState(() {});
  }
}

// ignore: must_be_immutable
class XMRefreshWidget extends XMRefreshBaseWidget {
  final Widget Function(BuildContext cntext) builder;
  Key reloadKey;
  XMRefreshWidget({Key key, @required this.builder})
      : assert(builder != null),
        super(key: key) {
    this.reloadKey = key;
  }

  @override
  State<StatefulWidget> createState() {
    return _XMRefreshWidgetState(builder);
  }
}

class _XMRefreshWidgetState extends State<XMRefreshWidget> {
  final Widget Function(BuildContext cntext) builder;
  _XMRefreshWidgetState(this.builder);

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
