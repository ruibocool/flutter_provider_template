import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_template/core/models/post.dart';
import 'package:flutter_provider_template/core/services/api.dart';

class PostsService {
  Api _api;

  PostsService({@required Api api}) : _api = api;
  List<Post> posts;

  StreamController<List<Post>> _postController = StreamController<List<Post>>();

  Stream<List<Post>> get poster => _postController.stream;

  Future getPosts(int userId) async {
    posts = await _api.getPostsForUser(userId);

    var hasData = posts != null;
    if(hasData){
      _postController.add(posts);
    }
  }
}
