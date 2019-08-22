import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_template/ui/views/WxArticlePageUI.dart';
import 'package:flutter_provider_template/ui/widgets/BottomNavigationBarDemo.dart';
import 'package:flutter_provider_template/utils/strings.dart';

import 'DrawerWidgetUI.dart';
import 'HomePageUI.dart';
import 'catalog.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  var _pageList = [
    HomePageUI(),
    WxArticlePageUI(),
    MyCatalog(),
  ];
  int _index = 0;
  var _titleList = [
    "首页",
    "公众号",
  ];

  bool _showAppbar = true;
  bool _showDrawer = true;

  void _handleTabChanged(int newValue) {
    setState(() {
      _index = newValue;
      if (_index == 0 || _index == 1) {
        _showAppbar = true;
      } else {
        _showAppbar = false;
      }

      if (_index == 0) {
        _showDrawer = true;
      } else {
        _showDrawer = false;
      }
    });
  }

  Widget _appBarWidget(BuildContext context) {
    return AppBar(
        title: Text(_titleList[_index]),
        elevation: 0.4,
        actions: _actionsWidget());
  }

  List<Widget> _actionsWidget() {
    if (_showDrawer) {
      return [new IconButton(icon: new Icon(Icons.shopping_cart), onPressed: () {
        Navigator.pushNamed(context, '/cart');
      })];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: _showAppbar ? _appBarWidget(context) : null,
            drawer: _showDrawer ? DrawerDemo() : null,
            body: IndexedStack(
              index: _index,
              children: _pageList,
            ),
            bottomNavigationBar: BottomNavigationBarDemo(
              index: _index,
              onChanged: _handleTabChanged,
            ),
          )),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('提示'),
            content: new Text('确定退出应用吗？'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('再看一会'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('退出'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
