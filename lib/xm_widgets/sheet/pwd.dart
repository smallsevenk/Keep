// import 'package:flutter/material.dart';
// import 'package:framework/public.dart';
// import 'package:framework/xm_utils/web3/web3.dart';

// class XMPwd {
//   static String btnTitle;
//   Widget validate() {
//     Widget validateBtn = XMBtn.normal(btnTitle, () async {
//       xwHideKeyborad(_context);
//       if (_pwdCtr.text.length <= 0) {
//         Toast.show('请输入钱包密码');
//         return;
//       }
//       changeStatus(btnTitle: '密码校验中', showIndictor: true);
//       String pwd = _pwdCtr.text ?? '';
//       bool pass = await Web3KeychainManager.getInstance()
//           .verifyPassword(_address.ethAddress, pwd);
//       if (pass) {
//         if (null != _passHandler) {
//           _passHandler(pwd);
//         } else {
//           changeStatus();
//         }
//       } else {
//         changeStatus();
//         Toast.show('校验失败');
//       }
//       _showCtr.text = _pwdCtr.text = '';
//     }, showIndictor: _showIndictor);

//     return xwsheetAppBarBoxRadius(
//         _pwdValidateH,
//         '身份验证',
//         SingleChildScrollView(
//           child: Column(children: [
//             SizedBox(height: xmDp(63)),
//             Stack(
//               children: [
//                 Positioned(
//                   child: Container(
//                     width: xmDp(980),
//                     height: xmDp(150),
//                     decoration: BoxDecoration(
//                         color: XColor.contentColor,
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                   ),
//                 ),
//                 Positioned(
//                   width: xmDp(980),
//                   height: xmDp(150),
//                   child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(width: xmDp(14), height: xmDp(150)),
//                         Image(
//                             width: xmDp(59),
//                             height: xmDp(59),
//                             color: XColor.cyan,
//                             image: AssetImage(imgPath('pwd_validate_icon'))),
//                         Expanded(
//                             child: TextField(
//                           keyboardAppearance: Brightness.dark,
//                           focusNode: pwdFN,
//                           autofocus: true,
//                           style: TextStyle(
//                               fontSize: xmSp(36), color: Colors.transparent),
//                           controller: _pwdCtr,
//                           cursorColor: XColor.cyan,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.only(top: 15),
//                             suffixIcon: _pwdCtr.text.length > 0
//                                 ? GestureDetector(
//                                     behavior: HitTestBehavior.opaque,
//                                     onTap: () {
//                                       _showCtr.text = _pwdCtr.text = '';
//                                       XWSheet.state(() {});
//                                     },
//                                     child: Icon(Icons.cancel,
//                                         color: XColor.grayColor),
//                                   )
//                                 : SizedBox(),
//                             border: InputBorder.none,
//                           ),
//                           onSubmitted: (value) {
//                             XWSheet.state(() {
//                               _pwdValidateH = _pwdValidateMinH;
//                             });
//                           },
//                           onChanged: (v) {
//                             _showCtr.text = ''.padRight(v.length, '• ');
//                             XWSheet.state(() {});
//                           },
//                         ))
//                       ]),
//                 ),
//                 Positioned(
//                     width: xmDp(980),
//                     height: xmDp(150),
//                     child: Container(
//                       margin: EdgeInsets.all(0),
//                       padding: EdgeInsets.only(left: xmDp(75)),
//                       child: TextField(
//                         readOnly: true,
//                         controller: _showCtr,
//                         style: TextStyle(fontSize: xmSp(46)),
//                         decoration: InputDecoration(
//                             contentPadding: EdgeInsets.only(top: 15),
//                             suffixIcon: _pwdCtr.text.length > 0
//                                 ? GestureDetector(
//                                     behavior: HitTestBehavior.opaque,
//                                     onTap: () {
//                                       _showCtr.text = _pwdCtr.text = '';
//                                       XWSheet.state(() {});
//                                     },
//                                     child: Icon(Icons.cancel,
//                                         color: XColor.grayColor),
//                                   )
//                                 : SizedBox(),
//                             border: InputBorder.none,
//                             hintText: '请输入钱包密码',
//                             hintStyle: TextStyle(
//                                 fontSize: xmDp(36), color: XColor.grayColor)),
//                         onTap: () {
//                           if (pwdFN.canRequestFocus && !pwdFN.hasFocus) {
//                             pwdFN.requestFocus();
//                           }
//                           XWSheet.state(() {
//                             _pwdValidateH = _pwdValidateMaxH;
//                           });
//                         },
//                       ),
//                     ))
//               ],
//             ),
//             SizedBox(height: xmDp(54)),
//             Row(children: [
//               SizedBox(width: xmDp(50)),
//               Expanded(
//                 child: xwText(_tip, 44, color: XColor.grayColor, maxLines: 3),
//               ),
//               SizedBox(width: xmDp(50)),
//             ]),
//             SizedBox(height: xmDp(79)),
//             Center(
//               child: Image(
//                 width: xmDp(190),
//                 height: xmDp(190),
//                 color: XColor.cyan,
//                 image: AssetImage(imgPath('ks_danger')),
//               ),
//             ),
//             SizedBox(height: xmDp(133)),
//             validateBtn
//           ]),
//         ),
//         _context,
//         isRoot: !_subSheet);
//   }
// }
