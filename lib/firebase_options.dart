// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyC0qWYhG4cQXZEMP6MEJvZZ-h9ETzQAxnE',
    appId: '1:375443505459:web:2ca4df7f148fc4cf457e46',
    messagingSenderId: '375443505459',
    projectId: 'bmicalculator-98535',
    authDomain: 'bmicalculator-98535.firebaseapp.com',
    storageBucket: 'bmicalculator-98535.appspot.com',
    measurementId: 'G-5BHD45G5FM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIaQPPiYXOSp4XdDQUQs53qSssvB-1d7Y',
    appId: '1:375443505459:android:35e7d7a5ccd6d83e457e46',
    messagingSenderId: '375443505459',
    projectId: 'bmicalculator-98535',
    storageBucket: 'bmicalculator-98535.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAz6ogpheFmtWjH784lcJNvcqEmUfBchXM',
    appId: '1:375443505459:ios:6848f5f59b788921457e46',
    messagingSenderId: '375443505459',
    projectId: 'bmicalculator-98535',
    storageBucket: 'bmicalculator-98535.appspot.com',
    iosBundleId: 'com.example.bmicalculator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAz6ogpheFmtWjH784lcJNvcqEmUfBchXM',
    appId: '1:375443505459:ios:6848f5f59b788921457e46',
    messagingSenderId: '375443505459',
    projectId: 'bmicalculator-98535',
    storageBucket: 'bmicalculator-98535.appspot.com',
    iosBundleId: 'com.example.bmicalculator',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC0qWYhG4cQXZEMP6MEJvZZ-h9ETzQAxnE',
    appId: '1:375443505459:web:20ddf40b198872d8457e46',
    messagingSenderId: '375443505459',
    projectId: 'bmicalculator-98535',
    authDomain: 'bmicalculator-98535.firebaseapp.com',
    storageBucket: 'bmicalculator-98535.appspot.com',
    measurementId: 'G-E20PLF66N8',
  );
}
