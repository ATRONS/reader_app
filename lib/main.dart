import 'package:atrons_mobile/providers/app_provider.dart';
import 'package:atrons_mobile/providers/detail_provider.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:atrons_mobile/providers/shelf_provider.dart';
import 'package:atrons_mobile/providers/user_provider.dart';
import 'package:atrons_mobile/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './theme/app_theme.dart';
import './utils/constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AppProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => ShelfProvider()),
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
    return Selector<AppProvider, String>(
      builder: (context, data, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Constants.appName,
          theme:
              data == 'dark' ? CustomTheme.darkTheme : CustomTheme.lightTheme,
          home: SplashScreen(),
        );
      },
      selector: (buildContext, providerapp) => providerapp.thethemenow,
    );
  }
}
