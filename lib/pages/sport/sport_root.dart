import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SportPage extends StatefulWidget {
  SportPage({Key key}) : super(key: key);

  _SportPageState createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
//热门活动
  _hotActivity() {
    List _activities = [
      {'title': 'Keep 马拉松 | 跑过暑假', 'num': '37071'},
      {'title': 'Keep 马拉松 | 跑过暑假', 'num': '37071'},
      {'title': 'Keep 马拉松 | 跑过暑假', 'num': '37071'},
      {'title': 'Keep 马拉松 | 跑过暑假', 'num': '37071'}
    ];
    return SafeArea(
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 197 / 154,
          crossAxisSpacing: ScreenUtil().setWidth(16),
          mainAxisSpacing: ScreenUtil().setHeight(40),
          children: _activities.map((v) {
            int _idx = _activities.indexOf(v);
            double _leftPadding = ScreenUtil().setWidth(40);
            double _rightPadding = 0;
            var img =
                'imgs/explore_hot_activity_0' + (_idx + 1).toString() + '.png';
            if ((_idx % 2).isOdd) {
              _rightPadding = _leftPadding;
              _leftPadding = 0;
            }
            return Container(
              color: Colors.orange,
              padding: EdgeInsets.fromLTRB(_leftPadding, 0, _rightPadding, 0),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    child: Image(image: AssetImage(img)),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  Text(v['title'], style: TextStyle())
                ],
              ),
            );
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: _hotActivity(),
      ),
    );
  }
}
