import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GradientContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [const Color(0xFF121212), Colors.black]
              : [const Color(0xFFF5F5F5), Colors.white],
        ),
      ),
      child: child,
    );
  }
}