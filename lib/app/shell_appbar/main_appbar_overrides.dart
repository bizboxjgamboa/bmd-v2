import 'package:bmd_v2/app/layout/main_tab.dart';
import 'package:flutter/material.dart';

class MainAppBarOverrideData {
  final Widget? title;
  final List<Widget>? actions;

  const MainAppBarOverrideData({this.title, this.actions});
}

class MainAppBarOverrideStore
    extends ValueNotifier<Map<MainTab, MainAppBarOverrideData?>> {
  MainAppBarOverrideStore() : super(const {});

  MainAppBarOverrideData? getFor(MainTab tab) => value[tab];

  void setFor(MainTab tab, MainAppBarOverrideData? data) {
    value = {...value, tab: data};
  }

  void clearFor(MainTab tab) {
    if (!value.containsKey(tab)) return;
    final next = {...value}..remove(tab);
    value = next;
  }
}

final mainAppBarOverrideStore = MainAppBarOverrideStore();

/// Drop this in any page to override the shell app bar while the page is alive.
class AppBarOverrideScope extends StatefulWidget {
  final MainTab tab;
  final MainAppBarOverrideData data;
  final Widget child;

  const AppBarOverrideScope({
    super.key,
    required this.tab,
    required this.data,
    required this.child,
  });

  @override
  State<AppBarOverrideScope> createState() => _AppBarOverrideScopeState();
}

class _AppBarOverrideScopeState extends State<AppBarOverrideScope> {
  @override
  void initState() {
    super.initState();
    mainAppBarOverrideStore.setFor(widget.tab, widget.data);
  }

  @override
  void didUpdateWidget(covariant AppBarOverrideScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    mainAppBarOverrideStore.setFor(widget.tab, widget.data);
  }

  @override
  void dispose() {
    mainAppBarOverrideStore.clearFor(widget.tab);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
