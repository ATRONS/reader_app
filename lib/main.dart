import 'package:atrons_mobile/view_models/app_provider.dart';
import 'package:atrons_mobile/view_models/detail_provider.dart';
import 'package:atrons_mobile/view_models/material_provider.dart';
import 'package:atrons_mobile/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './theme/app_theme.dart';
import './utils/constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AppProvider()),
        ChangeNotifierProvider(create: (ctx) => MaterialProvider()),
        ChangeNotifierProvider(create: (ctx) => DetailProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: CustomTheme.lightTheme,
      home: LoginPage(),
    );
  }
}
