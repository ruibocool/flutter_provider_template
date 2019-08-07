import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_template/core/services/api.dart';
import 'package:flutter_provider_template/core/viewmodels/home_view_model.dart';
import 'package:flutter_provider_template/ui/widgets/articlelist_item.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_widget.dart';

class HomePageUI extends StatelessWidget {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  //List<Article> datas=new List();
  int _page = 1; //加载的页数

  void _onLoading(HomeViewModel model) async {
    _page++;
    model.getArticles(_page);
    _refreshController.loadComplete();
  }

  void _onRefresh(HomeViewModel model) async {
    _page = 1;
    model.list.clear();
    model.getArticles(_page);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      model: HomeViewModel(api: Provider.of<Api>(context)),
      builder: (context, model, child) => Scaffold(
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: () => _onRefresh(model),
          onLoading: () => _onLoading(model),
          child: ListView.builder(
            itemBuilder: (c, i) => Card(
              child: ArticleListItem(
                article: model.list[i],
                index: i,
                length: model.list.length,
              ),
            ),
            itemExtent: 100.0,
            itemCount: model.list.length,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
  }
}
