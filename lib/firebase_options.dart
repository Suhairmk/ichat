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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC1psH98N5l8Aw66pyq4h263fvBVcMq-js',
    appId: '1:589858633575:web:8cfed8fa798b7b440821c2',
    messagingSenderId: '589858633575',
    projectId: 'ichat-1b6d6',
    authDomain: 'ichat-1b6d6.firebaseapp.com',
    storageBucket: 'ichat-1b6d6.appspot.com',
    measurementId: 'G-HVKLV147EH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIVvupsfINy9ARTepNYJKLz8qJ_3Kxg44',
    appId: '1:589858633575:android:ececa717d07c58990821c2',
    messagingSenderId: '589858633575',
    projectId: 'ichat-1b6d6',
    storageBucket: 'ichat-1b6d6.appspot.com',
  );
}
