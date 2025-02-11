import 'package:flutter/material.dart';
import 'package:state_restoration/src/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      restorationScopeId: 'rootApp',
      home: HomeScreen(),
    );
  }
}
