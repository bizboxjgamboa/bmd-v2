import 'package:bmd_v2/app/splash_page.dart';
import 'package:flutter/material.dart';

class BmdApp extends StatelessWidget {
  const BmdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const SplashPage(),
    );
  }
}
