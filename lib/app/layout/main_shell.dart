import 'package:bmd_v2/app/layout/main_tab.dart';
import 'package:bmd_v2/app/routing/navigation_extensions.dart';
import 'package:bmd_v2/app/shell_appbar/main_appbar_defaults.dart';
import 'package:bmd_v2/app/shell_appbar/main_appbar_overrides.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final tab = mainTabs[navigationShell.currentIndex];

    return ValueListenableBuilder<Map<MainTab, MainAppBarOverrideData?>>(
      valueListenable: mainAppBarOverrideStore,
      builder: (context, map, _) {
        final defaults = mainAppBarDefaultsForBranch(context, tab);
        final override = map[tab];

        return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                FilledButton(
                  onPressed: () {
                    context.goLogin();
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            title: override?.title ?? Text(defaults.title),
            actions: override?.actions ?? defaults.actions,
          ),

          body: SafeArea(child: navigationShell),
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              if (index == navigationShell.currentIndex) return;

              navigationShell.goBranch(index, initialLocation: false);
            },
            destinations: const [
              // should be equal to mainTabs
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: 'Schedule',
              ),
              NavigationDestination(
                icon: Icon(Icons.assignment_outlined),
                selectedIcon: Icon(Icons.assignment),
                label: 'Visits',
              ),
              NavigationDestination(
                icon: Icon(Icons.message_outlined),
                selectedIcon: Icon(Icons.message),
                label: 'Messages',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
