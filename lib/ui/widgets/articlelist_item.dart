import 'package:flutter/material.dart';
import 'package:flutter_provider_template/core/models/ArticleModel.dart';
import 'package:flutter_provider_template/utils/route_util.dart';
import 'package:flutter_provider_template/utils/timeline_util.dart';

class ArticleListItem extends StatelessWidget {

  final Article article;
  final int index;
  final int length;
  final Function onTap;
  const ArticleListItem({Key key, this.article, this.onTap, this.index, this.length}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return new InkWell(
        onTap: () {
          RouteUtil.toWebView(context,article.title,article.link);
        },
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      article.author,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                        child: Text(
                          TimelineUtil.format(article.publishTime),
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12),
                        )),
                  ],
                )),
            Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          article.title,
                          maxLines: 2,
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ))
                  ],
                )),
            Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      article.superChapterName,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )),
          ],
        ),
      );

    //return null;
  }

}
