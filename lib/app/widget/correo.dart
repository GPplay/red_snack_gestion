import 'package:flutter/material.dart';

class EmailFields extends StatelessWidget {
  final TextEditingController emailController;

  const EmailFields({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      decoration: const InputDecoration(labelText: 'Email'),
    );
  }
}
