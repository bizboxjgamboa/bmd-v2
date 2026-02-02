import 'package:bmd_v2/app/layout/main_tab.dart';
import 'package:flutter/material.dart';

class MainAppBarDefaults {
  final String title;
  final List<Widget> actions;
  const MainAppBarDefaults(this.title, this.actions);
}

MainAppBarDefaults mainAppBarDefaultsForBranch(
  BuildContext context,
  MainTab tab,
) {
  switch (tab) {
    case MainTab.home:
      // Home
      return MainAppBarDefaults('', [
        IconButton(
          tooltip: 'Notifications',
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => {},
        ),
      ]);
    case MainTab.schedule:
      return const MainAppBarDefaults('Schedule', []);
    case MainTab.visits:
      return const MainAppBarDefaults('Visits', []);
    case MainTab.messages:
      return const MainAppBarDefaults('Messages', []);
    case MainTab.profile:
      return const MainAppBarDefaults('Profile', []);
  }
}
