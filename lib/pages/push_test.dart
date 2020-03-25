import 'package:flutter/material.dart';

class PushTestScene extends StatefulWidget {
  PushTestScene({Key key}) : super(key: key);
  @override
  PushTestSceneState createState() => PushTestSceneState();
}

class PushTestSceneState extends State<PushTestScene> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }
}
