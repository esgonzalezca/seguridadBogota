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
        return macos;
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
    apiKey: 'AIzaSyBrRFYCSXzZSeExgMX4AfnjvFEVgGreSnM',
    appId: '1:1063678274567:web:717c3492ec1f977f194ea2',
    messagingSenderId: '1063678274567',
    projectId: 'authorizationtemplate-7776a',
    authDomain: 'authorizationtemplate-7776a.firebaseapp.com',
    storageBucket: 'authorizationtemplate-7776a.appspot.com',
    measurementId: 'G-PGRFDKVTQG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBe6bRf_3vx3zKdhJXMmlAfngsrKXMDe9k',
    appId: '1:1063678274567:android:1be523249c28f6a9194ea2',
    messagingSenderId: '1063678274567',
    projectId: 'authorizationtemplate-7776a',
    storageBucket: 'authorizationtemplate-7776a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBbtqRScztjYhfK9lzEhRWYdZTeN41blM',
    appId: '1:1063678274567:ios:cc19bb1512980468194ea2',
    messagingSenderId: '1063678274567',
    projectId: 'authorizationtemplate-7776a',
    storageBucket: 'authorizationtemplate-7776a.appspot.com',
    iosClientId: '1063678274567-rv4rhdu1m0gveatj6njl9pt28rfr85lt.apps.googleusercontent.com',
    iosBundleId: 'com.example.startertemplate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBbtqRScztjYhfK9lzEhRWYdZTeN41blM',
    appId: '1:1063678274567:ios:cc19bb1512980468194ea2',
    messagingSenderId: '1063678274567',
    projectId: 'authorizationtemplate-7776a',
    storageBucket: 'authorizationtemplate-7776a.appspot.com',
    iosClientId: '1063678274567-rv4rhdu1m0gveatj6njl9pt28rfr85lt.apps.googleusercontent.com',
    iosBundleId: 'com.example.startertemplate',
  );
}