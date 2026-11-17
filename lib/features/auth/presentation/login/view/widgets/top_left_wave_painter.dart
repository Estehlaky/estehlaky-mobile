import 'package:flutter/material.dart';

class TopLeftWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Outer Soft Pale-Yellow Ribbon
    final outerYellowPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFDE08D), Color(0xFFFBBF24), Color(0xFFFDE68A)],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final outerYellowPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.96, 0)
      ..cubicTo(
        size.width * 0.78,
        size.height * 0.42, // Control point 1 (upper curve)
        size.width * 0.22,
        size.height * 0.45, // Control point 2 (S-inflection)
        0,
        size.height * 0.98, // End point on left edge
      )
      ..close();

    canvas.drawPath(outerYellowPath, outerYellowPaint);

    // 2. Inner Vibrant Amber-Gold Highlight Ribbon
    final innerAmberPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
        begin: Alignment.centerLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final innerAmberPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.89, 0)
      ..cubicTo(
        size.width * 0.72,
        size.height * 0.36,
        size.width * 0.20,
        size.height * 0.38,
        0,
        size.height * 0.84,
      )
      ..close();

    canvas.drawPath(innerAmberPath, innerAmberPaint);

    // 3. Top Deep Royal Blue Shape
    final bluePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF033088), Color(0xFF0644B3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final bluePath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.84, 0)
      ..cubicTo(
        size.width * 0.68,
        size.height * 0.32,
        size.width * 0.18,
        size.height * 0.33,
        0,
        size.height * 0.76,
      )
      ..close();

    canvas.drawPath(bluePath, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
