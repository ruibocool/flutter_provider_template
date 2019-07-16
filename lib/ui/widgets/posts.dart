import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_template/core/constants/app_contstants.dart';
import 'package:flutter_provider_template/core/models/user.dart';
import 'package:flutter_provider_template/core/viewmodels/posts_model.dart';
import 'package:flutter_provider_template/ui/views/base_widget.dart';
import 'package:flutter_provider_template/ui/widgets/postlist_item.dart';

import '../../core/services/api.dart';

class Posts extends StatelessWidget {
  const Posts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PostsModel>(
        model: PostsModel(api:Api.getInstance()),
        onModelReady: (model) => model.getPosts(Provider.of<User>(context).getId()),
        builder: (context, model, child) => model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: model.posts.length,
                itemBuilder: (context, index) => PostListItem(
                      post: model.posts[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutePaths.Post,
                          arguments: model.posts[index],
                        );
                      },
                    ),
              ));
  }
}
