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
    apiKey: 'AIzaSyDEspUpOghpQHCOQJyxYBQX4Pkh3BCzAcE',
    appId: '1:1024400995104:web:34a4b8099e4a9b778a1d45',
    messagingSenderId: '1024400995104',
    projectId: 'coffeeshopapp-01',
    authDomain: 'coffeeshopapp-01.firebaseapp.com',
    storageBucket: 'coffeeshopapp-01.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNhRBT9NE5DkE17Jt3SlHnoui1zDS1IyE',
    appId: '1:1024400995104:android:dc346b0e230736c98a1d45',
    messagingSenderId: '1024400995104',
    projectId: 'coffeeshopapp-01',
    storageBucket: 'coffeeshopapp-01.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHdI3ibH01T8de1ROG40G8lFrqvoTpWgw',
    appId: '1:1024400995104:ios:17614f648479784d8a1d45',
    messagingSenderId: '1024400995104',
    projectId: 'coffeeshopapp-01',
    storageBucket: 'coffeeshopapp-01.firebasestorage.app',
    iosBundleId: 'com.example.coffeeShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHdI3ibH01T8de1ROG40G8lFrqvoTpWgw',
    appId: '1:1024400995104:ios:17614f648479784d8a1d45',
    messagingSenderId: '1024400995104',
    projectId: 'coffeeshopapp-01',
    storageBucket: 'coffeeshopapp-01.firebasestorage.app',
    iosBundleId: 'com.example.coffeeShop',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDEspUpOghpQHCOQJyxYBQX4Pkh3BCzAcE',
    appId: '1:1024400995104:web:7646fd5de831dfce8a1d45',
    messagingSenderId: '1024400995104',
    projectId: 'coffeeshopapp-01',
    authDomain: 'coffeeshopapp-01.firebaseapp.com',
    storageBucket: 'coffeeshopapp-01.firebasestorage.app',
  );
}