import 'package:bmd_v2/app/layout/main_shell.dart';
import 'package:bmd_v2/app/routing/route_transitions.dart';
import 'package:bmd_v2/app/splash_page.dart';
import 'package:bmd_v2/core/routing/app_routes.dart';
import 'package:bmd_v2/features/auth/login_page.dart';
import 'package:bmd_v2/features/schedule/shedule_page.dart';
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
    pageBuilder: (context, state) =>
        fadePage(state: state, child: const LoginPage()),
    // routes: [],
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        MainShell(navigationShell: navigationShell),
    branches: [
      // should be equal to mainTabs
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.home.path,
            name: AppRoutes.home.name,
            builder: (context, state) => const Placeholder(child: Text('home')),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.schedule.path,
            name: AppRoutes.schedule.name,
            builder: (context, state) => const SchedulePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.visits.path,
            name: AppRoutes.visits.name,
            builder: (context, state) =>
                const Placeholder(child: Text('visits')),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.messages.path,
            name: AppRoutes.messages.name,
            builder: (context, state) =>
                const Placeholder(child: Text('messages')),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.profile.path,
            name: AppRoutes.profile.name,
            builder: (context, state) =>
                const Placeholder(child: Text('profile')),
          ),
        ],
      ),
    ],
  ),
];
