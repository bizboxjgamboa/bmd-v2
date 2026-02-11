import 'package:bmd_v2/app/routing/navigation_extensions.dart';
import 'package:bmd_v2/core/widgets/password_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Email or Username'),
          textInputAction: TextInputAction.next,
        ),
        const PasswordField(labelText: 'Password'),
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (bool? value) {
                // setState(() {
                //   isChecked = value!;
                // });
              },
            ),
            Text(
              'Remember for 30 Days',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
        FilledButton(
          onPressed: () => {context.goHome()},
          child: Text(
            'Sign in',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
