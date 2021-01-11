export 'widgets_config.dart';
export 'refresh.dart';
export 'sheet/sheet.dart';
export 'buttons/button.dart';
export 'text.dart';
export 'empty.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/public.dart';

xmNetWorkImage(String url, double width,
    {double height, String placeholdlerImgNm = 'icon'}) {
  return CachedNetworkImage(
    width: xmDp(width),
    height: null != height ? xmDp(height) : xmDp(width),
    imageUrl: url,
    fit: BoxFit.cover,
    placeholder: (context, url) {
      return Image(
          width: xmDp(width),
          height: null != height ? xmDp(height) : xmDp(width),
          image: AssetImage('res/imgs/$placeholdlerImgNm.png'));
    },
  );
}
// xwAlert(BuildContext context, Function okHandler,
//     {String title, String content}) {
//   List<Widget> actions = [
//     FlatButton(
//       child: xwText("取消", 44, color: Colors.white),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     ),
//     FlatButton(
//       child: xwText("确定", 44, color: Colors.red),
//       onPressed: () async {
//         await okHandler();
//         Navigator.pop(context);
//       },
//     ),
//   ];
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CupertinoAlertDialog(
//           title: xwText(title ?? '', 54,
//               color: Colors.white, fontWeight: FontWeight.bold),
//           content: xwText(content ?? '', 44, color: Colors.white),
//           actions: actions,
//         );
//       });
// }

// xmExpanded({double w, double h}) {
//   return Expanded(child: SizedBox(width: w, height: h));
// }
