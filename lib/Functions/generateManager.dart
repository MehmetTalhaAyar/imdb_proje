import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imdb_proje/AppPages/AccountPage.dart';
import 'package:imdb_proje/AppPages/RegisterPage.dart';
import 'package:imdb_proje/AppPages/SignInPage.dart';
import 'package:imdb_proje/Classes/userClass.dart';

class GenerateManager {
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case "/SignInPage":
        return _routeChosen(SignInPage(), settings);
      case "/RegisterPage":
        return _routeChosen(RegisterPage(), settings);
      case "/AccountPage":
        var parametredekiUser = settings.arguments as User;
        return _routeChosen(
            AccountPage(suankiUser: parametredekiUser), settings);
    }
  }

  static Route<dynamic>? _routeChosen(
      Widget chosenPage, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS)
      return CupertinoPageRoute(
          builder: (context) => chosenPage, settings: settings);
    else
      return MaterialPageRoute(
          builder: (context) => chosenPage, settings: settings);
  }
}
