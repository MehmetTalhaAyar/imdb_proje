// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCMqY5Nz6K-8GrPs3BBrZTgIDyp9l1qNqU',
    appId: '1:939715945948:web:5d846eee1b28d23fe59b19',
    messagingSenderId: '939715945948',
    projectId: 'imdb-proje',
    authDomain: 'imdb-proje.firebaseapp.com',
    storageBucket: 'imdb-proje.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUV0O6zjOENsbpAf8IXaL2xF4kD6XPT98',
    appId: '1:939715945948:android:13c3149770b38d81e59b19',
    messagingSenderId: '939715945948',
    projectId: 'imdb-proje',
    storageBucket: 'imdb-proje.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_kbZZmDnn0ZQ6ZLenq1UEbnK7yjPsGc4',
    appId: '1:939715945948:ios:e34f8536135890eae59b19',
    messagingSenderId: '939715945948',
    projectId: 'imdb-proje',
    storageBucket: 'imdb-proje.appspot.com',
    iosClientId: '939715945948-v8169q8toh6noth1ihvlbbt30mfai2qv.apps.googleusercontent.com',
    iosBundleId: 'com.example.imdbProje',
  );
}
