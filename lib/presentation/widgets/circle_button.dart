import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? icon;
  final Color color;

  const CircleButton({
    Key? key,
    required this.onPressed,
    this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(1),
        backgroundColor: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
