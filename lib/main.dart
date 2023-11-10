import 'package:flutter/material.dart';
import 'package:flutter_animation/feature/home/home.dart';
import 'package:flutter_animation/feature/splash/spash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (context) => const SplashScreen(),
      '/home': (context) => const Home(),
    };
    return MaterialApp(
      themeMode: ThemeMode.dark,
      title: 'Flutter Animation Demo',
      routes: routes,
    );
  }
}
