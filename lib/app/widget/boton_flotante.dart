import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      child: Icon(icon, color: iconColor),
    );
  }
}
