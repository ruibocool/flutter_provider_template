import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_template/core/constants/app_contstants.dart';
import 'package:flutter_provider_template/ui/shared/app_colors.dart';
import 'package:flutter_provider_template/ui/widgets/login_header.dart';

import 'package:flutter_provider_template/core/viewmodels/authentication_service.dart';
import 'base_widget.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AuthenticationService>(
      model: Provider.of<AuthenticationService>(context),
      child: LoginHeader(controller: _controller),
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
                        var loginSuccess = await model.login(int.tryParse(_controller.text));
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
