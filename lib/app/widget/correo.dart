import 'package:flutter/material.dart';

class EmailFields extends StatelessWidget {
  final TextEditingController emailController;

  const EmailFields({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      decoration: const InputDecoration(labelText: 'Email'),
    );
  }
}
