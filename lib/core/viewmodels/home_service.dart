import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_template/core/models/ArticleModel.dart';
import 'package:flutter_provider_template/core/services/api.dart';

class HomeService {
  Api _api;

  HomeService({@required Api api}) : _api = api;
  List<Article> articles;

  StreamController<List<Article> > _homeController =
      StreamController<List<Article> >();

  Stream<List<Article> > get articleStream => _homeController.stream;

  Future getArticles(int userId) async {
    ArticleModel articleModel = await _api.getArticle(userId);
    articles=articleModel.data.datas;
    if(articles==null){
      articles=new List();
    }
    if (articles != null) {
      _homeController.add(articles);
    }
  }
}
