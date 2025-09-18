import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final TextInputType keyboard;

  const CampoTexto({
    super.key,
    required this.controller,
    required this.label,
    this.obscure = false,
    this.keyboard = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        obscureText: obscure,
        keyboardType: keyboard,
      ),
    );
  }
}
