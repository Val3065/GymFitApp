// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    return android;
  }

  // Opciones Android (desde google-services.json)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMrNMclWYs9QLpQ5cnugotWxbh0g2x_GU',
    appId: '1:540275784924:android:80f5a6249dc6e697734819',
    messagingSenderId: '540275784924',
    projectId: 'gymfit-app-94e3a',
    databaseURL: 'https://gymfit-app-94e3a.firebaseio.com',
  );

  // Opciones Web (generadas desde el mismo proyecto Firebase)
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAMrNMclWYs9QLpQ5cnugotWxbh0g2x_GU',
    appId: '1:540275784924:web:7e8c2a3b9f4d5e6c7a8b',
    messagingSenderId: '540275784924',
    projectId: 'gymfit-app-94e3a',
    authDomain: 'gymfit-app-94e3a.firebaseapp.com',
    storageBucket: 'gymfit-app-94e3a.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );
}