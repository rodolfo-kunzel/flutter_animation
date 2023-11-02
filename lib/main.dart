import 'package:flutter/material.dart';
import 'package:flutter_animation/home/home.dart';
import 'package:flutter_animation/splash/spash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          background: Colors.black,
          surface: Color(0xFFD4AF37),
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onBackground: Color(0xFFD4AF37),
          onSurface: Colors.black,
          secondary: Color(0xFFD4AF37),
          error: Colors.red,
          onError: Colors.black,
        ),
      ),
      routes: {
        '/': (context) => const Home(),
        '/home': (context) => const Home(),
      },
    );
  }
}
