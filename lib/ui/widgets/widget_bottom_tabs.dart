import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final PageController pageController;
  final ValueChanged<int> onTap;

  BottomTabs(this.pageController, this.onTap);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var _bottomTabs = <BottomNavigationBarItem>[
      ///最新
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text("最新"),
      ),

      ///分类
      BottomNavigationBarItem(
        icon: Icon(Icons.category),
        title:
            Text("分类"),
      ),

      ///my
      BottomNavigationBarItem(
        icon: Icon(Icons.account_box),
        title:
            Text("我的"),
      ),
    ];
    return BottomNavigationBar(
      items: _bottomTabs,
      type: BottomNavigationBarType.fixed,
      iconSize: 32,
      currentIndex: currentIndex,
      onTap: (int index) {
        if (widget.onTap != null) {
          currentIndex = index;
          widget.pageController.jumpToPage(index);
          widget.onTap(index);
        }
      },
    );
  }
}
