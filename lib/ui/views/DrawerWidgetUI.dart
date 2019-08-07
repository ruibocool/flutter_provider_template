import 'package:flutter/material.dart';
import 'package:flutter_provider_template/utils/colours.dart';
import 'package:flutter_provider_template/utils/route_util.dart';

class DrawerDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerDemoState();
  }
}

class DrawerDemoState extends State<DrawerDemo> {
  @override
  void initState() {
    super.initState();
  }

  changeUI() async {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text(
              '主题',
              textAlign: TextAlign.left,
            ),
            leading:
                Icon(Icons.collections, color: Colours.gray_66, size: 22.0),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              '教学',
              textAlign: TextAlign.left,
            ),
            leading:
            Icon(Icons.collections, color: Colours.gray_66, size: 22.0),
            onTap: () {
              RouteUtil.toWebView(context,'各种 XXProvider 的使用姿势',"https://juejin.im/post/5d414d08f265da03b8103c12");
            },
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
