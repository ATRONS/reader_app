import 'package:atrons_mobile/database/readers.dart';
import 'package:atrons_mobile/models/user.dart';
import 'package:atrons_mobile/providers/app_provider.dart';
import 'package:atrons_mobile/utils/api.dart';
import 'package:atrons_mobile/utils/router.dart';
import 'package:atrons_mobile/views/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'loading_state.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  User get user => _user;
  final _api = Api();
  final _readersDB = UsersDB();
  AuthenticationState signupStatus = AuthenticationState.unAuthenticated;
  AuthenticationState loginStatus = AuthenticationState.unAuthenticated;

  Future fetchUserInfo() async {
    _user = await _readersDB.getUser();
  }

  void signupUser(Map<String, String> credentials, BuildContext context) async {
    signupStatus = AuthenticationState.authenticating;
    notifyListeners();

    await _api.signupReader(credentials).then((Response res) async {
      final Map<String, dynamic> body = res.data;

      if (!body['success']) {
        signupStatus = AuthenticationState.failed;
        return notifyListeners();
      }

      await _createUser(context, body['data']);
      signupStatus = AuthenticationState.success;
      MyRouter.pushPageReplacement(context, HomeScreen());
    }).catchError((err) {
      print(err);
      signupStatus = AuthenticationState.failed;
      notifyListeners();
    });
  }

  void loginUser(String email, String password, BuildContext context) async {
    loginStatus = AuthenticationState.authenticating;
    notifyListeners();

    await _api.loginReader(email, password).then((Response res) async {
      final Map<String, dynamic> body = res.data;
      if (!body['success']) {
        loginStatus = AuthenticationState.failed;
        return notifyListeners();
      }

      await _createUser(context, body['data']);
      loginStatus = AuthenticationState.success;
      MyRouter.pushPageReplacement(context, HomeScreen());
    }).catchError((err) {
      print(err);
      loginStatus = AuthenticationState.failed;
      notifyListeners();
    });
  }

  void logoutUser() async {
    await _api.logoutReader().catchError((err) => print(err));
  }

  _createUser(BuildContext context, dynamic data) async {
    _user = User.fromJSON(data['user_info']);
    _user.token = data['token'];
    Api.setAuthToken(_user.token);

    final appStateProvider = Provider.of<AppProvider>(context, listen: false);
    await _readersDB.addUser(_user.toUserJSON());
    await appStateProvider.setAppState(AppState.LOGGED_IN);
  }
}
