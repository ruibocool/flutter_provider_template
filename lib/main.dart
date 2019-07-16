import 'package:flutter/material.dart';
import 'package:flutter_provider_template/ui/views/home_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_template/provider_setup.dart';
import 'package:flutter_provider_template/ui/router.dart';

import 'core/constants/app_contstants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeView(),
        initialRoute: RoutePaths.Splash,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
