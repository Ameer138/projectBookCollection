  import 'package:flutter/material.dart';
  import 'screens/bookcollectionpage.dart';

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Book Collection',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BookCollectionPage(),
        debugShowCheckedModeBanner: false,
      );
    }
  }
