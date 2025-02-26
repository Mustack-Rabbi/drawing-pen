import 'package:drawing_pen/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

import 'features/draw/presentation/draw_screen.dart';
import 'features/home/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawing Pen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/home": (context) => const HomeScreen(),
        "/draw": (context) => const DrawScreen(),
      },
    );
  }
}
