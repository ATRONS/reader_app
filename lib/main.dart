import 'package:atrons_mobile/providers/app_provider.dart';
import 'package:atrons_mobile/providers/detail_provider.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
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
    // final providerapp = Provider.of<AppProvider>(context, listen: false);
    // print(providerapp.thethemenow);

    return Selector<AppProvider, String>(
      builder: (context, data, child) {
        // print('$data dollar');
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Constants.appName,
          theme:
              data == 'dark' ? CustomTheme.darkTheme : CustomTheme.lightTheme,
          home: LoginPage(),
        );
      },
      selector: (buildContext, providerapp) => providerapp.thethemenow,
    );
  }
}
