import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState {
  static const KEY = 'app_user_state_key';
  static const FIRST_TIME_OPENED = 'first_time_opened';
  static const LOGGED_OUT = 'user_logged_out';
  static const LOGGED_IN = 'user_logged_in';
}

class AppProvider extends ChangeNotifier {
  AppProvider() {
    checkTheme();
  }

  ThemeData theme = CustomTheme.lightTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String thethemenow;

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

  // change the Theme in the provider and SharedPreferences
  void setTheme(value, c) async {
    theme = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', c);
    thethemenow = c;
    notifyListeners();
  }

  ThemeData getTheme(value) {
    return theme;
  }

  Future<ThemeData> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData t;
    String r = prefs.getString('theme') ?? 'light';

    if (r == 'light') {
      t = CustomTheme.lightTheme;
      setTheme(CustomTheme.lightTheme, 'light');
    } else {
      t = CustomTheme.darkTheme;
      setTheme(CustomTheme.darkTheme, 'dark');
    }

    return t;
  }

  Future<String> getAppState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppState.KEY) ?? AppState.FIRST_TIME_OPENED;
  }

  void setAppState(String state) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppState.KEY, state);
  }
}
