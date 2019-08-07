import 'package:flutter/widgets.dart';
import 'package:flutter_provider_template/core/models/ArticleModel.dart';
import 'package:flutter_provider_template/core/services/api.dart';

import 'authentication_service.dart';
import 'base_model.dart';
import 'home_service.dart';


class HomeViewModel extends BaseModel {
  Api _api;
  List<Article> list=new List();
  HomeViewModel({
    @required Api api,
  }) : _api = api;

  Future getArticles(int page) async {
    setBusy(true);
    ArticleModel success = await _api.getArticle(page);
    list.addAll(success.data.datas);
    setBusy(false);
  }
}
