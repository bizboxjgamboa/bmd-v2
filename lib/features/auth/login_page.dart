import 'package:bmd_v2/app/layout/guest_shell.dart';
import 'package:bmd_v2/app/routing/navigation_extensions.dart';
import 'package:bmd_v2/core/layout/scrollable_column.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GuestShell(
      child: ScrollableColumn(
        children: [
          const Text('login to'),
          TextButton(
            onPressed: () {
              context.goHome();
            },
            child: const Text('go to home'),
          ),
        ],
      ),
    );
  }
}
