import 'package:bmd_v2/app/routing/navigation_extensions.dart';
import 'package:bmd_v2/core/widgets/password_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Text('Remember for 30 Days'),
          ],
        ),
        FilledButton(
          onPressed: () => {context.goHome()},
          child: const Text('Sign in'),
        ),
      ],
    );
  }
}
