import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge/base/locator/get_it.dart';
import 'package:flutter_ui_challenge/feature/covid/repository/covid_repository.dart';

import 'base/base_request_new.dart';
import 'base/base_theme.dart';
import 'feature/covid/covid_page.dart';

void main() {
  // DI
  GetIt.I.registerSingleton(BaseRequestNew());
  GetIt.I.registerSingleton(CovidRepository());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getThemeByAppTheme(AppThemeDark),
      darkTheme: getThemeByAppTheme(AppThemeDark),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      home: CovidSummaryPage(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return null;
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}