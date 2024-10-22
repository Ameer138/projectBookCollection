import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(EasyApp());
}

class EasyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
