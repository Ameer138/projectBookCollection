import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBNAxNlvPYfKigs5GZoecMqz2nInLZlySQ",
    authDomain: "bookcollection-b5b57.firebaseapp.com",
    projectId: "bookcollection-b5b57",
    storageBucket: "bookcollection-b5b57.firebasestorage.app",
    messagingSenderId: "347605077196",
    appId: "1:347605077196:web:61c83ee0ae778ad0fb4669",
    measurementId: "G-7E7EPK7720",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBNAxNlvPYfKigs5GZoecMqz2nInLZlySQ",
    appId: "1:347605077196:web:61c83ee0ae778ad0fb4669",
    messagingSenderId: "347605077196",
    projectId: "bookcollection-b5b57",
    storageBucket: "bookcollection-b5b57.firebasestorage.app",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyBNAxNlvPYfKigs5GZoecMqz2nInLZlySQ",
    appId: "1:347605077196:web:61c83ee0ae778ad0fb4669",
    messagingSenderId: "347605077196",
    projectId: "bookcollection-b5b57",
    storageBucket: "bookcollection-b5b57.firebasestorage.app",
    iosClientId: "your-ios-client-id",
    iosBundleId: "your-ios-bundle-id",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyBNAxNlvPYfKigs5GZoecMqz2nInLZlySQ",
    appId: "1:347605077196:web:61c83ee0ae778ad0fb4669",
    messagingSenderId: "347605077196",
    projectId: "bookcollection-b5b57",
    storageBucket: "bookcollection-b5b57.firebasestorage.app",
    iosClientId: "your-macos-client-id",
    iosBundleId: "your-macos-bundle-id",
  );
}
