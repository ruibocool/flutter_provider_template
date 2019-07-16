
// You can also just let this float around in the file without encapsulating
// in a class. Then you'll have to make sure that system wide you don't have
// duplicate variable names.
class RoutePaths {
  static const String Login = '/login';
  static const String Home = '/home';
  static const String Post = '/post';
  static const String Splash = '/splash';
}

class Constant {
  static const String keyLanguage = 'key_language';

  static const int status_success = 0;

  static const String server_address = wan_android;

  static const String wan_android = "http://www.wanandroid.com/";

  static const int type_sys_update = 1;
  static const int type_refresh_all = 5;

  static const String key_theme_color = 'key_theme_color';
  static const String key_guide = 'key_guide';
  static const String key_splash_model = 'key_splash_models';
}