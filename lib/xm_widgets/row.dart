// import 'package:flutter/material.dart';

// class XMRow extends Row {
//   MainAxisAlignment mainAxisAlignment;
//   XMRow({this.mainAxisAlignment});
//   Widget build(XMRow()) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(width: xwWidth(72)),
//         xwText('矿工费用：', 40),
//         Expanded(
//             child: RichText(
//           text: TextSpan(
//             text: '$used\n',
//             style: TextStyle(color: Color(0xffa3b7cb), fontSize: xwSp(36)),
//             children: <TextSpan>[
//               TextSpan(
//                   text: gas,
//                   style:
//                       TextStyle(color: Color(0xff657890), fontSize: xwSp(36))),
//             ],
//           ),
//         )),
//         SizedBox(width: xwWidth(72)),
//       ],
//     );
//   }
// }
