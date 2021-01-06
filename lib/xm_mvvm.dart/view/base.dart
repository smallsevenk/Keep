import 'package:flutter/material.dart';

import '../../public.dart';

class XMBasePage extends StatefulWidget {
  XMBasePage({Key key}) : super(key: key);

  @override
  XMBasePageState createState() => XMBasePageState();
}

class XMBasePageState extends State<XMBasePage> {
  Scaffold scaffold;
  Widget leading;
  String title;
  Widget titleWidget;
  double titleSpace;
  List<Widget> actions;
  Widget body;
  bool showAppBar;
  List<Widget> footerBtns;
  Widget bottomBar;
  bool rtabp;
  bool autoLeading;
  Color scaffoldColor;
  Color appbarColor;
  double elevation;
  Widget appbarBottomBar;

  @override
  Widget build(BuildContext context) {
    if (!XMAppGlobal.screenInited) {
      ScreenUtil.init(context);
      XMAppGlobal.screenInited = true;
    }

    title = title == null ? '' : title;
    showAppBar = showAppBar ?? true;
    rtabp = rtabp ?? false;
    elevation = elevation ?? 1;
    autoLeading = autoLeading ?? true;

    return Scaffold(
      backgroundColor: scaffoldColor ?? XMColor.themeColor,
      resizeToAvoidBottomPadding: rtabp,
      appBar: showAppBar
          ? AppBar(
              automaticallyImplyLeading: autoLeading,
              leading: leading,
              elevation: elevation,
              centerTitle: true,
              titleSpacing: titleSpace ?? 0,
              title: titleWidget != null
                  ? titleWidget
                  : Text(
                      title,
                      style: TextStyle(fontSize: xmSp(54), color: Colors.black),
                    ),
              backgroundColor: XMColor.navColor,
              actions: actions,
              bottom: appbarBottomBar ?? null,
            )
          : null,
      persistentFooterButtons: footerBtns,
      bottomNavigationBar: null == bottomBar ? null : bottomBar,
      body: Container(
        margin: EdgeInsets.all(0),
        color: XMColor.contentColor,
        child: buildBody(),
      ),
    );
  }

  buildBody() {
    return SizedBox.shrink();
  }
}
