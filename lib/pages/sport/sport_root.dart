import 'package:flutter/material.dart';

class SportPage extends StatefulWidget {
  SportPage({Key key}) : super(key: key);

  _SportPageState createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(height: 100, color: Colors.red),
            Container(height: 100, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
