import 'package:flutter/material.dart';

class DarkModePyramidsWaveWidget extends StatelessWidget {
  final double height;

  const DarkModePyramidsWaveWidget({super.key, this.height = 150});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: screenWidth,
      height: height,
      child: CustomPaint(painter: _DarkModePyramidsWavePainter()),
    );
  }
}

class _DarkModePyramidsWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Dark Mode Night Sky Base (Fades smoothly from transparent top to midnight blue)
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF020617).withValues(alpha: 0.0),
          const Color(0xFF091534),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), skyPaint);

    // 2. Subtle Horizon Glow Behind the Pyramids
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, 0.2),
        radius: 0.85,
        colors: [
          const Color(0xFF1D4ED8).withValues(alpha: 0.22),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), glowPaint);

    // 3. The Three Giza Pyramids (With 3D Lit & Shaded Faces)
    // Great Pyramid (Center-Left)
    _drawPyramid(
      canvas: canvas,
      apex: Offset(w * 0.36, h * 0.22),
      baseLeft: Offset(w * 0.14, h * 0.82),
      baseRight: Offset(w * 0.56, h * 0.82),
      ridgeBottom: Offset(w * 0.43, h * 0.82),
      litColor: const Color(0xFF1E3F7A),
      shadedColor: const Color(0xFF10244A),
    );

    // Khafre Pyramid (Center-Right)
    _drawPyramid(
      canvas: canvas,
      apex: Offset(w * 0.62, h * 0.30),
      baseLeft: Offset(w * 0.44, h * 0.82),
      baseRight: Offset(w * 0.80, h * 0.82),
      ridgeBottom: Offset(w * 0.68, h * 0.82),
      litColor: const Color(0xFF19366B),
      shadedColor: const Color(0xFF0D1E3F),
    );

    // Menkaure Pyramid (Smaller, Far Left)
    _drawPyramid(
      canvas: canvas,
      apex: Offset(w * 0.16, h * 0.46),
      baseLeft: Offset(w * 0.03, h * 0.82),
      baseRight: Offset(w * 0.28, h * 0.82),
      ridgeBottom: Offset(w * 0.20, h * 0.82),
      litColor: const Color(0xFF23488A),
      shadedColor: const Color(0xFF122852),
    );

    // 4. Power Transmission Towers & Subtle Wires (Estehlaky Electricity Theme)
    _drawPowerTower(canvas, Offset(w * 0.84, h * 0.28), h * 0.48);
    _drawPowerTower(canvas, Offset(w * 0.08, h * 0.36), h * 0.40);

    final wirePaint = Paint()
      ..color = const Color(0xFF60A5FA).withValues(alpha: 0.25)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final wirePath = Path()
      ..moveTo(0, h * 0.44)
      ..quadraticBezierTo(w * 0.04, h * 0.47, w * 0.08, h * 0.42)
      ..quadraticBezierTo(w * 0.46, h * 0.56, w * 0.84, h * 0.35)
      ..quadraticBezierTo(w * 0.92, h * 0.39, w, h * 0.33);

    canvas.drawPath(wirePath, wirePaint);

    // 5. Dark Mode Gold / Amber Sweeping Wave (Right Side)
    final goldWavePaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFB45309), // Deep bronze amber
          Color(0xFFF59E0B), // Glowing dark gold
          Color(0xFFFBBF24), // Soft gold tip
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    final goldPath = Path()
      ..moveTo(w * 0.42, h * 0.96)
      ..cubicTo(w * 0.64, h * 0.78, w * 0.82, h * 0.36, w, h * 0.14)
      ..lineTo(w, h * 0.38)
      ..cubicTo(w * 0.82, h * 0.56, w * 0.64, h * 0.92, w * 0.42, h * 0.99)
      ..close();

    canvas.drawPath(goldPath, goldWavePaint);

    // 6. Dark Mode Deep Midnight Blue Foreground Wave
    final darkBlueWavePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF041233), Color(0xFF0D2861)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    final darkBluePath = Path()
      ..moveTo(0, h * 0.66)
      ..cubicTo(w * 0.25, h * 0.46, w * 0.46, h * 1.04, w, h * 0.42)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(darkBluePath, darkBlueWavePaint);
  }

  /// Helper to draw a 3D two-toned pyramid
  void _drawPyramid({
    required Canvas canvas,
    required Offset apex,
    required Offset baseLeft,
    required Offset baseRight,
    required Offset ridgeBottom,
    required Color litColor,
    required Color shadedColor,
  }) {
    // Left (moonlit) face
    final litPath = Path()
      ..moveTo(apex.dx, apex.dy)
      ..lineTo(baseLeft.dx, baseLeft.dy)
      ..lineTo(ridgeBottom.dx, ridgeBottom.dy)
      ..close();
    canvas.drawPath(litPath, Paint()..color = litColor);

    // Right (shadowed) face
    final shadedPath = Path()
      ..moveTo(apex.dx, apex.dy)
      ..lineTo(ridgeBottom.dx, ridgeBottom.dy)
      ..lineTo(baseRight.dx, baseRight.dy)
      ..close();
    canvas.drawPath(shadedPath, Paint()..color = shadedColor);
  }

  /// Helper to draw minimalist electricity lattice towers
  void _drawPowerTower(Canvas canvas, Offset topCenter, double towerHeight) {
    final towerPaint = Paint()
      ..color = const Color(0xFF254E96).withValues(alpha: 0.65)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final bottomY = topCenter.dy + towerHeight;
    final halfBase = towerHeight * 0.14;

    // Main A-frame legs
    canvas.drawLine(
      topCenter,
      Offset(topCenter.dx - halfBase, bottomY),
      towerPaint,
    );
    canvas.drawLine(
      topCenter,
      Offset(topCenter.dx + halfBase, bottomY),
      towerPaint,
    );

    // Upper & lower cross-arms
    final arm1Y = topCenter.dy + towerHeight * 0.22;
    final arm2Y = topCenter.dy + towerHeight * 0.40;
    canvas.drawLine(
      Offset(topCenter.dx - halfBase * 1.1, arm1Y),
      Offset(topCenter.dx + halfBase * 1.1, arm1Y),
      towerPaint,
    );
    canvas.drawLine(
      Offset(topCenter.dx - halfBase * 1.4, arm2Y),
      Offset(topCenter.dx + halfBase * 1.4, arm2Y),
      towerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
