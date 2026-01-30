import 'package:bmd_v2/app/routing/app_route_tree.dart';
import 'package:bmd_v2/core/routing/app_routes.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash.path,
  redirect: (context, state) {
    debugPrint('📍 Route change to: ${state.uri}');
    return null;
  },
  routes: appRouteTree,
);
