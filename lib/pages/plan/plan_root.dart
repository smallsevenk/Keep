import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlanPage extends StatefulWidget {
  PlanPage({Key key}) : super(key: key);

  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('safsd'),
      ),
      body: IconButton(
        icon: Text('data'),
        onPressed: () {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: Color(0xFF000000),
            systemNavigationBarDividerColor: null,
            statusBarColor: null,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ));
        },
      ),
    );
  }
}
