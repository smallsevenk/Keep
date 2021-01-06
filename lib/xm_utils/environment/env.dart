// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:framework/xm_utils/environment/evn_model.dart';

// class Env extends StatefulWidget {
//   Env({Key key}) : super(key: key);

//   @override
//   _EnvState createState() => _EnvState();
// }

// class _EnvState extends State<Env> {
//   List<XMEnvModel> envs = [];
//   @override
//   void initState() {
//     super.initState();
//     _fetchEnvs().then((value) {
//       setState(() {});
//     });
//   }

//   Future<void> _fetchEnvs() async {
//     envs = await XWSPUtil.lmEnv();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return xwScaffoldDiy(
//       context,
//       titleWidget: _titleWid(),
//       titleSpace: 0,
//       body: _envList(),
//     );
//   }

//   _titleWid() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         xwText(XWGlobal.lmEnv.name, 54, fontWeight: FontWeight.bold),
//         SizedBox(width: 50)
//       ],
//     );
//   }

//   Widget _envList() {
//     return ListView.separated(
//         shrinkWrap: true,
//         itemBuilder: (ctx, idx) {
//           if (idx == envs.length) {
//             return Container(
//                 padding: EdgeInsets.all(30),
//                 child:
//                     xwButton980_120('新增环境配置', XWBtnLvl.XWBtnLvlInfo, () async {
//                   await XWSPUtil.addLMEnv(XMEnvModel());
//                   await _fetchEnvs();
//                   setState(() {});
//                 }));
//           }
//           return _cell(idx);
//         },
//         separatorBuilder: (ctx, idx) {
//           if (idx == envs.length - 1) {
//             return SizedBox();
//           }
//           return Container(
//               width: xwSWidth(), height: 10, color: XColor.lineColor);
//         },
//         itemCount: envs.length + 1);
//   }

//   Widget _cell(int idx) {
//     XMEnvModel env = envs[idx];
//     var keys = env.toJson().keys.toList();
//     keys.removeRange(0, 1);
//     keys.removeLast();
//     var values = env.toJson().values.toList();
//     values.removeRange(0, 1);
//     values.removeLast();

//     bool hideDel = true;
//     if (env.eidting && env.name != XWGlobal.lmEnv.name && envs.length > 1) {
//       hideDel = false;
//     }

//     return ListView(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       children: [
//         GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             env.hide = !env.hide;
//             if (env.hide) env.eidting = false;
//             setState(() {});
//           },
//           child: Row(
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onDoubleTap: () async {
//                       if (env.name != XWGlobal.lmEnv.name) {
//                         await XWSPUtil.changeEnv(idx);
//                         XWGlobal.lmEnv = env;
//                         Toast.show('切换成功,即将退出App,重启生效!');
//                         setState(() {});
//                         Future.delayed(Duration(seconds: 3), () {
//                           exit(0);
//                         });
//                       } else {
//                         Toast.show('已是${env.name}环境');
//                       }
//                     },
//                     onLongPress: () async {
//                       env.name = env.name + r"'s副本";
//                       env.used = '0';
//                       await XWSPUtil.addLMEnv(env);
//                       await _fetchEnvs();
//                       setState(() {});
//                       Toast.show('基于${env.name}环境克隆完成,请自行编辑');
//                     },
//                     child: Row(
//                       children: <Widget>[
//                         SizedBox(width: 10, height: 50),
//                         Offstage(
//                             offstage: env.eidting,
//                             child: xwText(env.name ?? 'EnvName', 50,
//                                 color: env.name != XWGlobal.lmEnv.name
//                                     ? Colors.black
//                                     : XColor.styleColor,
//                                 fontWeight: FontWeight.bold))
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 100,
//                     child: Offstage(
//                       offstage: !env.eidting,
//                       child: TextField(
//                         style:
//                             TextStyle(color: Colors.grey, fontSize: xwSp(50)),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           contentPadding:
//                               const EdgeInsets.symmetric(vertical: 10.0),
//                         ),
//                         onChanged: (value) {
//                           env.name = value;
//                         },
//                         controller: TextEditingController(text: env.name),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(child: SizedBox()),
//               Offstage(
//                   offstage: hideDel,
//                   child: GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onTap: () async {
//                       await XWSPUtil.delLMEnv(idx);
//                       await _fetchEnvs();
//                       setState(() {});
//                     },
//                     child: Row(
//                       children: [
//                         xwText('删除', 50, fontWeight: FontWeight.bold),
//                         SizedBox(width: 10, height: 50),
//                       ],
//                     ),
//                   )),
//               Offstage(
//                   offstage: env.hide,
//                   child: GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onTap: () async {
//                       if (env.eidting) {
//                         await XWSPUtil.updateLMEnv(idx, env);
//                         xwHideKeyborad(context);
//                       }
//                       env.eidting = !env.eidting;
//                       setState(() {});
//                     },
//                     child: Row(
//                       children: [
//                         xwText(env.eidting ? '完成' : '编辑', 50,
//                             fontWeight: FontWeight.bold),
//                         SizedBox(width: 10, height: 50),
//                       ],
//                     ),
//                   ))
//             ],
//           ),
//         ),
//         Offstage(
//           offstage: env.hide,
//           child: ListView.separated(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (ctx, idx) {
//                 return Column(
//                   children: <Widget>[
//                     Row(children: [
//                       SizedBox(height: 44, width: 20),
//                       xwText(keys[idx] + ' : ', 46,
//                           fontWeight: FontWeight.w600),
//                     ]),
//                     Row(
//                       children: <Widget>[
//                         SizedBox(width: 20),
//                         Offstage(
//                             offstage: env.eidting,
//                             child: Row(
//                               children: <Widget>[
//                                 SizedBox(height: 44),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Clipboard.setData(
//                                         ClipboardData(text: values[idx]));
//                                     Toast.show(values[idx]);
//                                   },
//                                   child: xwText(values[idx], 46),
//                                 ),
//                               ],
//                             )),
//                         Expanded(
//                           child: Offstage(
//                             offstage: !env.eidting,
//                             child: TextField(
//                               style: TextStyle(
//                                   color: Colors.grey, fontSize: xwSp(46)),
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding:
//                                     const EdgeInsets.symmetric(vertical: 10.0),
//                               ),
//                               onChanged: (value) {
//                                 switch (idx) {
//                                   case 0:
//                                     env.baseUrl = value;
//                                     break;
//                                   case 1:
//                                     env.nodeUrl = value;
//                                     break;
//                                   case 2:
//                                     env.userBaseURL = value;
//                                     break;
//                                 }
//                               },
//                               controller:
//                                   TextEditingController(text: values[idx]),
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 );
//               },
//               separatorBuilder: (ctx, idx) {
//                 return Container(
//                     width: xwSWidth(), height: 1, color: XColor.lineColor);
//               },
//               itemCount: keys.length),
//         )
//       ],
//     );
//   }
// }
