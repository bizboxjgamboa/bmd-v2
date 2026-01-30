class AppRoute {
  final String name;
  final String path;

  const AppRoute(this.name, this.path);
}

abstract class AppRoutes {
  static const splash = AppRoute('splash', '/splash');

  static const login = AppRoute('login', '/login');

  static const home = AppRoute('home', '/home');
}
