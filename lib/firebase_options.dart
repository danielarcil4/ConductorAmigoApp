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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLlucelky6C3WlUzWSg9LqlI1iruDhm2c',
    appId: '1:1091142434496:android:04e2304d79cc3cf6d13725',
    messagingSenderId: '1091142434496',
    projectId: 'conductoramigo-b355f',
    storageBucket: 'conductoramigo-b355f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0BbGIZ22w5yyuHo1nDLCd3dS0gsdEj9Y',
    appId: '1:1091142434496:ios:066c5e7aa55278e0d13725',
    messagingSenderId: '1091142434496',
    projectId: 'conductoramigo-b355f',
    storageBucket: 'conductoramigo-b355f.appspot.com',
    androidClientId: '1091142434496-7patpheuj7q62u3uo803hmplk38b7jjb.apps.googleusercontent.com',
    iosClientId: '1091142434496-ud2tao4020gjlmr2mhe2v2efrfsi7lah.apps.googleusercontent.com',
    iosBundleId: 'com.example.conductorAmigo',
  );
}