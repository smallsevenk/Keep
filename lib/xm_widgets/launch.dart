import 'package:flutter/material.dart';

import '../public.dart';

class XMLaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            imgPath('wlt_create_logo'),
            width: 200,
            height: 200,
          ),
        ));
  }
}
