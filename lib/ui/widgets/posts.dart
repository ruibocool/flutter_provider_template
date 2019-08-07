import 'package:flutter/material.dart';
import 'package:flutter_provider_template/core/constants/app_contstants.dart';
import 'package:flutter_provider_template/core/models/post.dart';
import 'package:flutter_provider_template/core/models/user.dart';
import 'package:flutter_provider_template/core/viewmodels/posts_service.dart';
import 'package:flutter_provider_template/ui/widgets/postlist_item.dart';
import 'package:provider/provider.dart';

class Posts extends StatelessWidget {
  const Posts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<PostsService>(context)
        .getPosts(Provider.of<User>(context).getId());
    return Consumer<List<Post>>(
      builder: (context, model, child) => model == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: model.length,
              itemBuilder: (context, index) => PostListItem(
                  post: model[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.Post,
                      arguments: model[index],
                    );
                  })),
    );
  }
}
