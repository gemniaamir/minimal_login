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
    apiKey: 'AIzaSyATgbsFITNfQMOjxSYlu9UapLIbehmgD5c',
    appId: '1:980611337582:web:965795f1ed62c05eac057f',
    messagingSenderId: '980611337582',
    projectId: 'socialloginapps-a7f1f',
    authDomain: 'socialloginapps-a7f1f.firebaseapp.com',
    storageBucket: 'socialloginapps-a7f1f.appspot.com',
    measurementId: 'G-0V3ZD05WVT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDfqRns-56FKJObdVf3x2srmP0woiuEUA',
    appId: '1:980611337582:android:5cb3f2b3718d581dac057f',
    messagingSenderId: '980611337582',
    projectId: 'socialloginapps-a7f1f',
    storageBucket: 'socialloginapps-a7f1f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChOOqehMqilRuPvqR68aqQLp9Uo2AbxUg',
    appId: '1:980611337582:ios:b5fbe7dd4e722b92ac057f',
    messagingSenderId: '980611337582',
    projectId: 'socialloginapps-a7f1f',
    storageBucket: 'socialloginapps-a7f1f.appspot.com',
    androidClientId: '980611337582-kgdqtvh0vvtpvpc44vc589bj1uhvc84a.apps.googleusercontent.com',
    iosClientId: '980611337582-eqt7sra4ajkruvumo1k2oo6niafm265q.apps.googleusercontent.com',
    iosBundleId: 'com.example.minimalLogin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChOOqehMqilRuPvqR68aqQLp9Uo2AbxUg',
    appId: '1:980611337582:ios:b5fbe7dd4e722b92ac057f',
    messagingSenderId: '980611337582',
    projectId: 'socialloginapps-a7f1f',
    storageBucket: 'socialloginapps-a7f1f.appspot.com',
    androidClientId: '980611337582-kgdqtvh0vvtpvpc44vc589bj1uhvc84a.apps.googleusercontent.com',
    iosClientId: '980611337582-eqt7sra4ajkruvumo1k2oo6niafm265q.apps.googleusercontent.com',
    iosBundleId: 'com.example.minimalLogin',
  );
}
