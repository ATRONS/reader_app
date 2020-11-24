import 'package:atrons_mobile/providers/user_provider.dart';
import 'package:atrons_mobile/utils/router.dart';
import 'package:atrons_mobile/views/auth/login.dart';
import 'package:atrons_mobile/views/auth/signup.dart';
import 'package:atrons_mobile/views/home_screen.dart';
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
    Provider.of<UserProvider>(context, listen: false)
        .fetchUserInfo()
        .then((value) {
      if (value.length == 0)
        MyRouter.pushPageReplacement(context, LoginPage());
      else
        MyRouter.pushPageReplacement(context, HomeScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 2), () => true),
        builder: (ctx, snapshot) {
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: Text(
                  "This is supposed to be the splash screen",
                ),
              ),
            ),
          );
        });
  }
}
