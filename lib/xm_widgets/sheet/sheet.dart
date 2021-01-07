import 'package:flutter/material.dart';

import '../../public.dart';

typedef void XMSheetCloseHandler<T extends Object>({T result});

enum XMSheetNavLeftStyle {
  None, //没有按钮
  Close, //关闭
  Back, //回退
}

class XMSheet {
  static XMRefreshWidget _modalWid;

  static List<XMRefreshWidget> _widgets = [];

  static XMSheetCloseHandler _closeHandler;

  static PageController pageCtr = PageController();

  static BuildContext ctxt;

  static bool showing = false;

  static present(BuildContext context, XMRefreshWidget rootWid,
      {bool isDismissible = true, XMSheetCloseHandler closeHandler}) {
    showing = true;
    _widgets = [rootWid];
    _closeHandler = closeHandler;
    _modalWid = XMRefreshWidget(
      builder: (cntext) {
        return WillPopScope(
          onWillPop: () async => false, //防止用户通过物理键disminss
          child: Column(
            children: [
              _expandedWid(isDismissible),
              Container(
                width: xmSW(),
                constraints: BoxConstraints(
                  minHeight: 0,
                  maxHeight: xmSH() - ScreenUtil.statusBarHeight - xmAppBarH,
                ),
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageCtr,
                  children: _widgets.map(
                    (wid) {
                      return Column(
                        children: [
                          _expandedWid(isDismissible),
                          wid,
                        ],
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isScrollControlled: true,
        builder: (context) {
          ctxt = context;
          return _modalWid;
        });
  }

  static _expandedWid(bool isDismissible) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (isDismissible) {
            close();

            xmKeyboradHide();
          }
        },
        child: Container(margin: EdgeInsets.all(0)),
      ),
    );
  }

  static push(XMRefreshWidget pushWid) {
    _widgets.add(pushWid);
    _modalWid.reload();
    if (pageCtr.hasClients) {
      pageCtr.animateToPage(pageCtr.page.toInt() + 1,
          duration: Duration(milliseconds: 250), curve: Curves.easeIn);
    }
  }

  static pop() {
    if (pageCtr.hasClients && pageCtr.page > 0) {
      pageCtr
          .animateToPage(pageCtr.page.toInt() - 1,
              duration: Duration(milliseconds: 250), curve: Curves.easeOut)
          .whenComplete(() {
        _widgets.removeLast();
      });
    }
  }

  static reload({remodal = false, List<int> resubs}) {
    if (null != resubs)
      resubs.forEach((idx) {
        _widgets[idx].reload();
      });
    else
      _widgets.forEach((wid) {
        wid.reload();
      });
    _modalWid.reload();
  }

  static reloadByKeys(List<Key> keys) {
    _widgets.forEach((wid) {
      if (keys.contains(wid.reloadKey)) {
        wid.reload();
      }
    });

    _modalWid.reload();
  }

  static bool hasKey(Key key) {
    bool has = false;
    _widgets.forEach((wid) {
      if (key == wid.reloadKey) {
        has = true;
      }
    });
    return has;
  }

  static close({dynamic info}) {
    _widgets.clear();
    xmPop();

    showing = false;

    if (_closeHandler != null) {
      if (null != info) {
        _closeHandler(result: info);
      } else {
        _closeHandler();
      }
    }
    ctxt = null;
    _closeHandler = null;
    _modalWid = XMRefreshWidget(builder: (ctx) => SizedBox.shrink());
  }
}

XMRefreshWidget sheetWidget(SheetWidgetBuildData sb) {
  return XMRefreshWidget(
      key: sb.key,
      builder: (BuildContext context) {
        bool leftOffstage = false;
        Widget leftWid = CloseButton(
          onPressed: () {
            XMSheet.close();
          },
        );
        if (sb.navLeftStyle == XMSheetNavLeftStyle.None) {
          leftOffstage = true;
        } else if (sb.navLeftStyle == XMSheetNavLeftStyle.Back) {
          leftOffstage = false;
          leftWid = BackButton(
            onPressed: () {
              if (null != sb.navLeftOnPressed) {
                sb.navLeftOnPressed();
              }
              XMSheet.pop();
            },
          );
        }
        var content = sb.content == null ? SizedBox.shrink() : sb.content();
        if (null != sb.safe ? sb.safe() : true) {
          content = SafeArea(child: content);
        }
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(xmDp(25)))),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Container(
                    width: xmSW(),
                    height: xmAppBarH,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: XMColor.lineColor))),
                    child: Center(
                        child: XMText.create(
                      sb.title() ?? '',
                      ftSize: 54,
                    )),
                  ),
                  Offstage(
                    offstage: leftOffstage,
                    child: Row(children: [SizedBox(width: xmDp(20)), leftWid]),
                  ),
                ],
              ),
              Container(
                constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: xmSH() -
                        ScreenUtil.statusBarHeight -
                        xmAppBarH * 2 -
                        MediaQuery.of(context).padding.bottom),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) => content,
                ),
              ),
            ],
          ),
        );
      });
}

class SheetWidgetBuildData {
  Key key;
  String Function() title;
  Widget Function() content;
  XMSheetNavLeftStyle navLeftStyle = XMSheetNavLeftStyle.Close;
  void Function() navLeftOnPressed;
  bool Function() safe;

  SheetWidgetBuildData(
    this.key, {
    this.title,
    this.content,
    this.navLeftStyle,
    this.navLeftOnPressed,
    this.safe,
  });
}
