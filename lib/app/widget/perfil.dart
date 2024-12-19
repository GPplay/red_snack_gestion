import 'package:flutter/material.dart';

class ImagenPerfil extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  const ImagenPerfil({
    super.key,
    this.backgroundColor = const Color(0xFFE1BEE7), // Color por defecto
    this.iconColor = Colors.purple, // Color por defecto
    this.textColor = Colors.black, // Color por defecto
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: backgroundColor,
            child: Icon(
              Icons.person,
              size: 60,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'NOMBRE',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
