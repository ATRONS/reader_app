import 'package:atrons_mobile/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  User get user => _user;

  Future fetchUserInfo() {
    return Future.delayed(Duration(seconds: 1), () {
      _user = User();
    });
  }
}
