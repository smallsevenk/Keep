import 'package:flutter/material.dart';

class MainCollapsingToolbar extends StatefulWidget {
  @override
  _MainCollapsingToolbarState createState() => _MainCollapsingToolbarState();
}

class _MainCollapsingToolbarState extends State<MainCollapsingToolbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 100.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Collapsing Toolbar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      "https://p.ssl.qhimg.com/dmfd/400_300_/t0120b2f23b554b8402.jpg",
                      fit: BoxFit.cover,
                    )),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.info), text: "Tab 1"),
                      Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: ListView(
            children: <Widget>[
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
              Container(
                height: 50,
                child: Text("Sample text"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
