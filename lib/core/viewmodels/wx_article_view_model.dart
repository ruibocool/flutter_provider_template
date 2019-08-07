
import 'package:flutter/widgets.dart';
import 'package:flutter_provider_template/core/models/WxArticleContentModel.dart';
import 'package:flutter_provider_template/core/models/WxArticleTitleModel.dart';
import 'package:flutter_provider_template/core/services/api.dart';

import 'base_model.dart';

class WxArticleViewModel extends BaseModel {
  Api _api;
  List<WxArticleTitleData> authorList=new List();
  List<WxArticleContentDatas> wxArticleContentDatasList=new List();
  WxArticleViewModel({
    @required Api api,
  }) : _api = api;

  Future<List<WxArticleTitleData>> getWxAuthorTab() async {
    setBusy(true);
    WxArticleTitleModel success = await _api.getWxArticleTitle();
    authorList.clear();
    authorList.addAll(success.data);
    setBusy(false);
    return authorList;
  }
  Future getWxContent(int _id, int _page) async {
    setBusy(true);
    WxArticleContentModel success = await _api.getWxArticleContent(_id, _page);
    wxArticleContentDatasList.addAll(success.data.datas);
    setBusy(false);
  }
}