import 'package:flutter/material.dart';

class PasswordFields extends StatelessWidget {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  const PasswordFields({
    Key? key,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: oldPasswordController,
          decoration: const InputDecoration(labelText: 'Old Password'),
          obscureText: true,
        ),
        TextField(
          controller: newPasswordController,
          decoration: const InputDecoration(labelText: 'New Password'),
          obscureText: true,
        ),
        TextField(
          controller: confirmPasswordController,
          decoration: const InputDecoration(labelText: 'Confirm Password'),
          obscureText: true,
        ),
      ],
    );
  }
}
