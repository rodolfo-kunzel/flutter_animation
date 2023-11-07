import 'package:flutter/material.dart';
import 'package:flutter_animation/feature/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      title: 'Flutter Animation Demo',
      routes: {
        '/': (context) => const Home(),
        '/home': (context) => const Home(),
      },
    );
  }
}
