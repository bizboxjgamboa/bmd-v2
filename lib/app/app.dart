import 'package:bmd_v2/app/routing/app_router.dart';
import 'package:flutter/material.dart';

class BmdApp extends StatelessWidget {
  const BmdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BizBox MD',
      routerConfig: appRouter,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
    );
  }
}
