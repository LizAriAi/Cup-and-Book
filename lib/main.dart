import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CupAndBookApp());
}

class CupAndBookApp extends StatelessWidget {
  const CupAndBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cup&Book',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF5F5DC), // Cream/coffee tone
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown[800],
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}