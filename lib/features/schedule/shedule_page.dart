import 'package:bmd_v2/app/layout/main_tab.dart';
import 'package:bmd_v2/app/shell_appbar/main_appbar_overrides.dart';
import 'package:flutter/material.dart';

enum ScheduleView { day, week, month }

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  ScheduleView view = ScheduleView.day;

  @override
  void initState() {
    super.initState();

    // Delay until AFTER first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mainAppBarOverrideStore.setFor(
        MainTab.schedule,
        MainAppBarOverrideData(
          title: _buildTitle(),
          actions: [_buildAddAction()],
        ),
      );
    });
  }

  @override
  void dispose() {
    mainAppBarOverrideStore.clearFor(MainTab.schedule);
    super.dispose();
  }

  Widget _buildTitle() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<ScheduleView>(
        value: view,
        isDense: true,
        items: const [
          DropdownMenuItem(value: ScheduleView.day, child: Text('Day')),
          DropdownMenuItem(value: ScheduleView.week, child: Text('Week')),
          DropdownMenuItem(value: ScheduleView.month, child: Text('Month')),
        ],
        onChanged: (v) {
          if (v == null) return;
          setState(() => view = v);

          // update appbar AFTER state change
          WidgetsBinding.instance.addPostFrameCallback((_) {
            mainAppBarOverrideStore.setFor(
              MainTab.schedule,
              MainAppBarOverrideData(
                title: _buildTitle(),
                actions: [_buildAddAction()],
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildAddAction() {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        // push or custom logic
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Schedule body'));
  }
}
