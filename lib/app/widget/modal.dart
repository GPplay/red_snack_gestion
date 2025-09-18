import 'package:flutter/material.dart';

class ModalOpciones extends StatelessWidget {
  final Function(String) onSelect;

  const ModalOpciones({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text("Crear emprendimiento"),
          onTap: () => onSelect("crear"),
        ),
        ListTile(
          title: const Text("Unirse a un emprendimiento"),
          onTap: () => onSelect("unir"),
        ),
      ],
    );
  }
}
