import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

class NewPage extends StatefulWidget {
  @override
  NewPageState createState() => NewPageState();
}

class NewPageState extends State<NewPage> with AutomaticKeepAliveClientMixin {
  String _girlImage;
  String _date;
  //List<GankItem> _gankItems;
  RefreshController _refreshController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
    getNewData();
  }

  Future _onRefresh() async {
    getNewData(date: _date, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        ///content view
        Offstage(
          offstage: _isLoading ? true : false,
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _onRefresh,
            onOffsetChange: null,
            controller: _refreshController,
            child: _buildListView(),
          ),
        ),

        ///loading view
        Offstage(
          offstage: _isLoading ? false : true,
          child: Center(child: CupertinoActivityIndicator()),
        )
      ],
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      /*  itemCount: _gankItems == null ? 0 : _gankItems.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            return _buildImageBanner(context);
          } else {
            GankItem gankItem = _gankItems[i - 1];
            return gankItem.isTitle
                ? GankItemTitle(gankItem.category)
                : GankListItem(gankItem);
          }
        }*/

        );
  }

  Future getNewData({String date, bool isRefresh = false}) async {
    /*_date = date;
    var todayJson;
    if (date == null) {
      todayJson = await GankApi.getTodayData();
    } else {
      todayJson = await GankApi.getSpecialDayData(_date);
    }
    var todayItem = GankPost.fromJson(todayJson);
    setState(() {
      if (mounted) {
        _gankItems = todayItem.gankItems;
        _girlImage = todayItem.girlImage;
        _isLoading = false;
      }
    });
    if (isRefresh) {
      _refreshController.refreshCompleted();
    }*/
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
