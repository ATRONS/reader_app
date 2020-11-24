import 'package:atrons_mobile/database/readers.dart';
import 'package:atrons_mobile/models/user.dart';
import 'package:atrons_mobile/utils/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'loading_state.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  User get user => _user;
  final _api = Api();
  final _readersDB = UsersDB();
  AuthenticationState signupStatus = AuthenticationState.unAuthenticated;
  AuthenticationState loginStatus = AuthenticationState.unAuthenticated;

  Future fetchUserInfo() async {
    final usrinfo = await _readersDB.getUser();
    return usrinfo;
  }

  void signupUser(Map<String, String> credentials, dosignup) async {
    signupStatus = AuthenticationState.authenticating;
    notifyListeners();

    await _api.signupReader(credentials).then((Response res) {
      final Map<String, dynamic> body = res.data;

      if (!body['success']) {
        signupStatus = AuthenticationState.failed;
        notifyListeners();
      }

      _user = User.fromJSON(body['data']['user_info']);
      _user.token = body['data']['token'];
      signupStatus = AuthenticationState.success;
      final usr = _user.toUserJSON();

      _readersDB.addUser(usr);
      dosignup();
      notifyListeners();
    }).catchError((err) {
      print(err);
      signupStatus = AuthenticationState.failed;
      notifyListeners();
    });
  }

  void loginUser(String email, String password, dologin) async {
    loginStatus = AuthenticationState.authenticating;
    notifyListeners();
    await _api.loginReader(email, password).then((Response res) {
      final Map<String, dynamic> body = res.data;
      if (!body['success']) {
        loginStatus = AuthenticationState.failed;
        notifyListeners();
      }

      loginStatus = AuthenticationState.success;
      dologin();
      notifyListeners();
    }).catchError((err) {
      print(err);
      loginStatus = AuthenticationState.failed;
      notifyListeners();
    });
  }

  void logoutUser(String token) async {
    await _api.logoutReader(token).then((Response res) {
      final Map<String, dynamic> body = res.data;
      if (!body['success']) {
        print('hard this shuttle');
      }
      print('loggedout successfully');
      _readersDB.removeUser(token);
    }).catchError((err) {
      print(err);
    });
  }
}
