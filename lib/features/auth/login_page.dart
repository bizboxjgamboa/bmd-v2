import 'package:bmd_v2/app/layout/guest_shell.dart';
import 'package:bmd_v2/core/layout/scrollable_column.dart';
import 'package:bmd_v2/features/auth/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GuestShell(
      child: ScrollableColumn(
        spacing: null,
        children: [
          const SizedBox(height: 16),
          SvgPicture.asset('assets/svg/bizbox_md.svg'),
          const SizedBox(height: 32),
          Text(
            'Login',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 32),
          const LoginForm(),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text('New here? '),
              TextButton(
                child: const Text('Create account'),
                onPressed: () {
                  // context.pushNamed(AppRoutes.signup.name);
                },
              ),
            ],
          ),
          Center(
            child: TextButton(
              child: const Text('Forgot Password'),
              onPressed: () {
                // context.pushNamed(AppRoutes.forgotPassword.name);
              },
            ),
          ),
        ],
      ),
    );
  }
}
