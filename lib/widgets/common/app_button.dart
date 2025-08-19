import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLarge;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLarge = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: isLarge
          ? null
          : ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isLarge ? 18 : 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}