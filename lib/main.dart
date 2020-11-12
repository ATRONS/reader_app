import 'package:flutter/material.dart';

import './theme/app_theme.dart';
import './utils/constants.dart';
import './views/home_screen.dart';

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
