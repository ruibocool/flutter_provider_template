import 'package:fluintl/fluintl.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_template/provider_setup.dart';
import 'package:flutter_provider_template/ui/router.dart';
import 'package:flutter_provider_template/ui/views/home_view.dart';
import 'package:flutter_provider_template/ui/views/splash_page.dart';
import 'package:flutter_provider_template/utils/sp_helper.dart';
import 'package:flutter_provider_template/utils/strings.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_contstants.dart';
import 'core/models/models.dart';
import 'utils/colours.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Locale _locale;
  Color _themeColor = Colors.blue;


  @override
  void initState() {
    super.initState();
    setLocalizedValues(localizedValues);
    _initAsync();
   // _initListener();
  }
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


  void _initAsync() async {
    await SpUtil.getInstance();
    if (!mounted) return;
   // _init();
    _loadLocale();
  }

  void _loadLocale() {
    setState(() {
      LanguageModel model =
      SpHelper.getObject<LanguageModel>(Constant.keyLanguage);
      if (model != null) {
        _locale = new Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }

      String _colorKey = SpHelper.getThemeColor();
      if (themeColorMap[_colorKey] != null)
        _themeColor = themeColorMap[_colorKey];
    });
  }
}
