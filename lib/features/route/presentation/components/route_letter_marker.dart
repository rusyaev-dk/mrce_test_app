import 'package:flutter/material.dart';

class RouteLetterMarker extends StatelessWidget {
  const RouteLetterMarker({
    required this.letter,
    required this.color,
    this.size = 22,
    super.key,
  });

  final String letter;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: size * 0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.52,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}
