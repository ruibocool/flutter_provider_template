import 'package:flutter/material.dart';
import 'package:flutter_provider_template/core/models/user.dart';
import 'package:flutter_provider_template/ui/shared/ui_helpers.dart';
import 'package:flutter_provider_template/ui/views/HomePageUI.dart';
import 'package:flutter_provider_template/ui/widgets/posts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_template/ui/shared/text_styles.dart';

class HomeWidget {
  Widget appbar(int _currentPageIndex, String _currentDate) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Offstage(
        offstage: _currentPageIndex != 0,

        ///标题栏显示当前日期
        child: Text(_currentDate ?? ''),
      ),
      //actions: <Widget>[_buildActions()],
    );
  }

  int _currentIndex = 0;

  ///build main body.
  Widget body(BuildContext context,PageController _pageController) {
    _currentIndex = Provider.of<HomePageIndex>(context).currentIndex;
    return Stack(
      children: <Widget>[
        PageView(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            if (_currentIndex != index) {
              _currentIndex = index;
              Provider.of<HomePageIndex>(context).changePage(index);
            }
          },
          controller: _pageController,
          children: <Widget>[
            HomePageUI(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIHelper.verticalSpaceLarge,
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Welcome ${Provider.of<User>(context).getName()}',
                    style: headerStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('Here are all your posts', style: subHeaderStyle),
                ),
                UIHelper.verticalSpaceSmall,
                Expanded(child: Posts(),)
              ],
            ),
          ],
         /* children: <Widget>[
            NewPage(),
            CategoryPage(),
          ],*/
        )
      ],
    );
  }
}

class HomePageIndex with ChangeNotifier {
  int currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
