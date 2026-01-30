import 'package:bmd_v2/app/splash_page.dart';
import 'package:bmd_v2/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> appRouteTree = [
  GoRoute(
    path: AppRoutes.splash.path,
    name: AppRoutes.splash.name,
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: AppRoutes.login.path,
    name: AppRoutes.login.name,
    builder: (context, state) => const Placeholder(),
    // routes: [],
  ),
];
