import 'package:atrons_mobile/utils/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  final _api = Api();
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

  void signupUser(
      String firstname, String lastname, String email, String password) {
    _api
        .signupReader(firstname, lastname, email, password)
        .then((Response res) async {
      final Map<String, dynamic> body = res.data;
      if (!body['success']) {
        print(body['message']);
      }
    }).catchError((err) {
      print(err);
    });
  }
}
