import 'package:atrons_mobile/providers/app_provider.dart';
import 'package:atrons_mobile/providers/user_provider.dart';
import 'package:atrons_mobile/utils/api.dart';
import 'package:atrons_mobile/utils/router.dart';
import 'package:atrons_mobile/views/auth/login.dart';
import 'package:atrons_mobile/views/auth/signup.dart';
import 'package:atrons_mobile/views/home_screen.dart';
import 'package:atrons_mobile/views/verification/verification_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), _checkAppStateAndNavigate);
    super.initState();
  }

  _checkAppStateAndNavigate() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final state = await appProvider.getAppState();

    switch (state) {
      case AppState.FIRST_TIME_OPENED:
        MyRouter.pushPageReplacement(context, SignupPage());
        break;
      case AppState.ON_VERIFICATION_PAGE:
        await userProvider.fetchUserInfo();
        Api.setAuthToken(userProvider.user.token);
        MyRouter.pushPageReplacement(context, VerificationPage());
        break;
      case AppState.LOGGED_IN:
        await userProvider.fetchUserInfo();
        Api.setAuthToken(userProvider.user.token);
        MyRouter.pushPageReplacement(context, HomeScreen());
        break;
      case AppState.LOGGED_OUT:
        MyRouter.pushPageReplacement(context, LoginPage());
        break;
      default:
        print('this should never happen');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "This is supposed to be the splash screen",
          ),
        ),
      ),
    );
  }
}
