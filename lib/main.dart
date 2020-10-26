import 'package:atrons_mobile/theme/app_theme.dart';
import 'package:atrons_mobile/utils/constants.dart';
import 'package:atrons_mobile/views/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: CustomTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
