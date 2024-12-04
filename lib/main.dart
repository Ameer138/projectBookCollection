import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import Firebase options
import 'screens/login_page.dart';
import 'screens/BookCollectionPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use FirebaseOptions
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Collection',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Set the initial route to LoginPage
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(), // Initial route connects to LoginPage
        '/home': (context) => BookCollectionPage(), // Home route for navigation after login
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
