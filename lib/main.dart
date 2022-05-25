import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imdb_proje/AppPages/SignInPage.dart';
import 'package:imdb_proje/Functions/generateManager.dart';
import 'package:imdb_proje/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(drawerTheme: DrawerThemeData(backgroundColor: Colors.teal)),
      title: 'imdb_proje',
      onGenerateRoute: GenerateManager.routeGenerator,
      home: SignInPage(),
    );
  }
}
