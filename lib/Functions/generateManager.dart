import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imdb_proje/AppPages/AccountPage.dart';
import 'package:imdb_proje/AppPages/HomePage.dart';
import 'package:imdb_proje/AppPages/MoviePage.dart';
import 'package:imdb_proje/AppPages/RegisterPage.dart';
import 'package:imdb_proje/AppPages/SearchPage.dart';
import 'package:imdb_proje/AppPages/SignInPage.dart';
import 'package:imdb_proje/Classes/userClass.dart';

import '../Classes/movieClass.dart';

class GenerateManager {
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case "/SignInPage":
        return _routeChosen(SignInPage(), settings);
      case "/RegisterPage":
        return _routeChosen(RegisterPage(), settings);
      case "/SearchPage":
        var argument = settings.arguments as List;
        var parametredekiUser = argument[0];
        var parametredekiList = argument[1];
        return _routeChosen(
          SearchPage(
              suankiUser: parametredekiUser, allMovies: parametredekiList),
          settings,
        );
      case "/HomePage":
        var argument = settings.arguments as List;
        var parametredekiUser = argument[0];
        List<Movie> parametredekiList = argument[1];
        return _routeChosen(
            HomePage(
                suankiUser: parametredekiUser, allMovies: parametredekiList),
            settings);
      case "/MoviePage":
        var argument = settings.arguments as List;
        var parametredekiMovie = argument[0];
        var parametredekiUser = argument[1];
        return _routeChosen(
            MoviePage(
              movie: parametredekiMovie,
              suankiUser: parametredekiUser,
            ),
            settings);
      case "/AccountPage":
        var argument = settings.arguments as List;
        var parametredekiUser = argument[0];
        var parametredekiList = argument[1];
        return _routeChosen(
            AccountPage(
                suankiUser: parametredekiUser, allMovies: parametredekiList),
            settings);
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
