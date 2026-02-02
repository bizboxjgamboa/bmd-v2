class AppRoute {
  final String name;
  final String path;

  const AppRoute(this.name, this.path);
}

abstract class AppRoutes {
  static const splash = AppRoute('splash', '/splash');

  static const login = AppRoute('login', '/login');

  static const home = AppRoute('home', '/');

  static const schedule = AppRoute('schedule', '/schedule');

  static const visits = AppRoute('visits', '/visits');

  static const messages = AppRoute('messages', '/messages');

  static const profile = AppRoute('profile', '/profile');
}
