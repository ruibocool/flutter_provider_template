import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_template/core/models/WxArticleContentModel.dart';
import 'package:flutter_provider_template/core/models/WxArticleTitleModel.dart';
import 'package:flutter_provider_template/core/services/api.dart';
import 'package:flutter_provider_template/core/viewmodels/wx_article_view_model.dart';
import 'package:flutter_provider_template/utils/route_util.dart';
import 'package:flutter_provider_template/utils/timeline_util.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_widget.dart';

class WxArticlePageUI extends StatefulWidget {
  const WxArticlePageUI({Key key, this.labelId}) : super(key: key);

  final String labelId;

  @override
  State<StatefulWidget> createState() {
    return _MyTabbedPageState();
  }
}

class _MyTabbedPageState extends State<WxArticlePageUI>
    with TickerProviderStateMixin {
  List<WxArticleTitleData> _datas = new List();
  TabController _tabController;

  Future<void> _getData() async {
    WxArticleTitleModel success = await Api().getWxArticleTitle();
    setState(() {
      _datas = success.data;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController = new TabController(vsync: this, length: _datas.length);
    return BaseWidget<WxArticleViewModel>(
      model: WxArticleViewModel(api: Provider.of<Api>(context)),
      builder: (context, model, child) => Scaffold(
        appBar: new AppBar(
          elevation: 0.4,
          title: new TabBar(
            controller: _tabController,
            tabs: _datas.map((WxArticleTitleData item) {
              return Tab(
                text: item.name,
              );
            }).toList(),
            isScrollable:
                true, //水平滚动的开关，开启后Tab标签可自适应宽度并可横向拉动，关闭后每个Tab自动压缩为总长符合屏幕宽度的等宽，默认关闭
          ),
          automaticallyImplyLeading: false, //设置没有返回按钮
        ),
        body: new TabBarView(
          controller: _tabController,
          children: _datas.map((item) {
            return NewsList(
              id: item.id,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NewsList extends StatefulWidget {
  final int id;

  @override
  NewsList({Key key, this.id}) : super(key: key);

  _NewsListState createState() => new _NewsListState();
}

class _NewsListState extends State<NewsList> {
  int _page = 1; //加载的页数
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  Future<Null> _getData(WxArticleViewModel model) async {
    _page = 1;
    int _id = widget.id;
    model.wxArticleContentDatasList.clear();
    model.getWxContent(_id, _page);
    _refreshController.refreshCompleted();
  }

  Future<Null> _getMore(WxArticleViewModel model) async {
    _page++;
    int _id = widget.id;
    model.getWxContent(_id, _page);
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<WxArticleViewModel>(
      model: WxArticleViewModel(api: Provider.of<Api>(context)),
      builder: (context, model, child) => Scaffold(
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Container(
                  child: CircularProgressIndicator(),
                );
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
          onRefresh: () => _getData(model),
          onLoading: () => _getMore(model),
          child: model.wxArticleContentDatasList == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (context, index) =>
                      _newsRow(model.wxArticleContentDatasList[index]),
                  itemExtent: 100.0,
                  itemCount: model.wxArticleContentDatasList.length,
                ),
        ),
      ),
    );
  }

  Widget _newsRow(WxArticleContentDatas item) {
    return InkWell(
      onTap: () {
        RouteUtil.toWebView(context, item.title, item.link);
      },
      child: new Card(
        child: new Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      item.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ))
                  ],
                )),
            new Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        TimelineUtil.format(item.publishTime),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }
}
