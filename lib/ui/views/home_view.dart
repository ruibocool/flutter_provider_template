import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_template/core/models/user.dart';
import 'package:flutter_provider_template/ui/shared/app_colors.dart';
import 'package:flutter_provider_template/ui/shared/text_styles.dart';
import 'package:flutter_provider_template/ui/shared/ui_helpers.dart';
import 'package:flutter_provider_template/ui/widgets/posts.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UIHelper.verticalSpaceLarge,
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Welcome ${Provider.of<User>(context).getName()}',
              style: headerStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Here are all your posts', style: subHeaderStyle),
          ),
          UIHelper.verticalSpaceSmall,
          Expanded(child: Posts(),)
        ],
      ),
    );
  }
}
