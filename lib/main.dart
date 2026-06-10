// 1. Package Imports
import 'package:flutter/material.dart';

// 2. The Main Function Entry Point
void main() {
  runApp(const MyApp());
}

// 3. The Root Widget Definition
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
