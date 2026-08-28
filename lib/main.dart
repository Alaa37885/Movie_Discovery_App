import 'package:flutter/material.dart';
import 'package:movie_nti_aug/screens/splash_screen.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff101218),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff101218),
          elevation: 0,
        ),

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      home: const SplashScreen(),
    );
  }
}

