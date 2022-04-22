import 'package:flutter/material.dart';
import 'package:imdb_proje/AppPages/AccountPage.dart';
import 'package:imdb_proje/AppPages/SignInPage.dart';
import 'package:imdb_proje/Functions/generateManager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'imdb_proje',
      onGenerateRoute: GenerateManager.routeGenerator,
      home: SignInPage(),
    );
  }
}
