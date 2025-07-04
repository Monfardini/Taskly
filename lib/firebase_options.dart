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
    apiKey: 'AIzaSyDGz-K6tqCCVruZlUkK-ygKG8pRS7Dy8XM',
    appId: '1:703907301099:web:c803d86852f66cf78260ae',
    messagingSenderId: '703907301099',
    projectId: 'taskly-8fd0d',
    authDomain: 'taskly-8fd0d.firebaseapp.com',
    storageBucket: 'taskly-8fd0d.appspot.com', // ✅ corrigido
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_uY-4uemlbS2r8tD-TNEjV1o-HNfWr4g',
    appId: '1:703907301099:android:a360260c01a8adee8260ae',
    messagingSenderId: '703907301099',
    projectId: 'taskly-8fd0d',
    storageBucket: 'taskly-8fd0d.appspot.com', // ✅ corrigido
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0gHCHCKLPmTYMr_W7-Rn6E_busj-hSGw',
    appId: '1:703907301099:ios:c1d12d7b8e8429008260ae',
    messagingSenderId: '703907301099',
    projectId: 'taskly-8fd0d',
    storageBucket: 'taskly-8fd0d.appspot.com', // ✅ corrigido
    iosBundleId: 'com.example.meuApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0gHCHCKLPmTYMr_W7-Rn6E_busj-hSGw',
    appId: '1:703907301099:ios:c1d12d7b8e8429008260ae',
    messagingSenderId: '703907301099',
    projectId: 'taskly-8fd0d',
    storageBucket: 'taskly-8fd0d.appspot.com', // ✅ corrigido
    iosBundleId: 'com.example.meuApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDGz-K6tqCCVruZlUkK-ygKG8pRS7Dy8XM',
    appId: '1:703907301099:web:c16c029f4bbfe7568260ae',
    messagingSenderId: '703907301099',
    projectId: 'taskly-8fd0d',
    authDomain: 'taskly-8fd0d.firebaseapp.com',
    storageBucket: 'taskly-8fd0d.appspot.com', // ✅ corrigido
  );
}
