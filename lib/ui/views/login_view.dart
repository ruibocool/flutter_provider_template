import 'package:flutter/material.dart';
import 'package:flutter_provider_template/core/constants/app_contstants.dart';
import 'package:flutter_provider_template/core/viewmodels/login_view_model.dart';
import 'package:flutter_provider_template/ui/shared/app_colors.dart';
import 'package:flutter_provider_template/ui/widgets/login_widget.dart';
import 'package:provider/provider.dart';

import 'base_widget.dart';

class LoginView extends StatelessWidget with LoginWidget{
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model:  LoginViewModel(authenticationService: Provider.of(context)),
      child: header(controller: _controller),
      builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              child,
              model.busy
                  ? CircularProgressIndicator()
                  : FlatButton(
                      color: Colors.white,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        var loginSuccess = await model.login(_controller.text);
                        if (loginSuccess) {
                          Navigator.pushNamed(context, RoutePaths.Home);
                        }
                      },
                    )
            ],
          )),
    );
  }
}
