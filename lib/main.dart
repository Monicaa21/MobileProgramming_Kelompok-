import 'package:flutter/material.dart';
import 'package:aplikasi_tokped/features/navigation/presentation/pages/navigation_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Shop',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 15, 21, 108),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 238, 239, 238),
      ),
      home: const NavigationMenu(),
    );
  }
}