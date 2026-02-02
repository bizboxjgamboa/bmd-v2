import 'package:bmd_v2/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension AppNavigation on BuildContext {
  void goLogin() => goNamed(AppRoutes.login.name);
  void goHome() => goNamed(AppRoutes.home.name);
  // void pushSetting() => pushNamed(AppRoutes.X.name);
}
