import 'package:flutter/material.dart';

class ImagenPerfil extends StatelessWidget {
  const ImagenPerfil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.purple[100],
            child: const Icon(
              Icons.person,
              size: 60,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'NOMBRE',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
