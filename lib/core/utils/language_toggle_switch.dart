import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:flutter/material.dart';

class LanguageToggleSwitch extends StatelessWidget {
  final bool isArabic;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;

  const LanguageToggleSwitch({
    super.key,
    required this.isArabic,
    required this.onChanged,
    this.width = 96,
    this.height = 42,
  });

  @override
  Widget build(BuildContext context) {
    final thumbSize = height - 10;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final locale = Localizations.localeOf(context);
    return GestureDetector(
      onTap: () => onChanged(!isArabic),
      child: Directionality(
        // Keeps the left/right slide physics consistent even when the app switches to RTL
        textDirection: TextDirection.ltr,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2),
            // Outer subtle highlight border (neumorphic bottom-right rim)
            border: Border.all(
              color: const Color(0xFFA1B4D4).withValues(alpha: 0.25),
              width: 1.2,
            ),
            // Recessed inner shadow gradient effect
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.outline.withValues(alpha: 0.85),
                colors.surface,
                colors.outline.withValues(alpha: 0.95),
              ],
              stops: [0.0, 0.35, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF102A43).withValues(alpha: 0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Language Labels ("AR" on Left, "EN" on Right)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 220),
                      opacity: isArabic ? 1.0 : 0.0,
                      child: Text(
                        "AR",
                        style: AppStyles.style(
                          locale: locale,
                          fontSize: AppStyles.s15,
                          fontWeight: AppStyles.extraBold,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 220),
                      opacity: isArabic ? 0.0 : 1.0,
                      child: Text(
                        "EN",
                        style: AppStyles.style(
                          locale: locale,
                          fontSize: AppStyles.s15,
                          fontWeight: AppStyles.extraBold,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Sliding Circular Flag Thumb
              AnimatedAlign(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeInOutCubic,
                alignment: isArabic
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: thumbSize,
                  height: thumbSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.22),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: CustomPaint(
                      painter: isArabic
                          ? _EgyptFlagPainter()
                          : _UkFlagPainter(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Crisp Circular Egypt Flag (Red, White, Black + Gold Eagle emblem)
class _EgyptFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stripeHeight = size.height / 3;

    // Top Red Stripe
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, stripeHeight),
      Paint()..color = const Color(0xFFCE1126),
    );

    // Middle White Stripe
    canvas.drawRect(
      Rect.fromLTWH(0, stripeHeight, size.width, stripeHeight),
      Paint()..color = Colors.white,
    );

    // Bottom Black Stripe
    canvas.drawRect(
      Rect.fromLTWH(0, stripeHeight * 2, size.width, stripeHeight),
      Paint()..color = const Color(0xFF111111),
    );

    // Center Gold Eagle of Saladin (minimalist vector emblem)
    final eaglePaint = Paint()
      ..color = const Color(0xFFC09300)
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final eaglePath = Path()
      ..moveTo(cx, cy - stripeHeight * 0.32)
      ..lineTo(cx + stripeHeight * 0.26, cy - stripeHeight * 0.08)
      ..lineTo(cx + stripeHeight * 0.16, cy + stripeHeight * 0.30)
      ..lineTo(cx - stripeHeight * 0.16, cy + stripeHeight * 0.30)
      ..lineTo(cx - stripeHeight * 0.26, cy - stripeHeight * 0.08)
      ..close();

    canvas.drawPath(eaglePath, eaglePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Crisp Circular UK Union Jack Flag (matching the bottom state in your image)
class _UkFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Royal Blue Background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF012169),
    );

    // White Diagonals
    final whiteDiag = Paint()
      ..color = Colors.white
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(Offset.zero, Offset(w, h), whiteDiag);
    canvas.drawLine(Offset(w, 0), Offset(0, h), whiteDiag);

    // Red Diagonals
    final redDiag = Paint()
      ..color = const Color(0xFFC8102E)
      ..strokeWidth = w * 0.08
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(Offset.zero, Offset(w, h), redDiag);
    canvas.drawLine(Offset(w, 0), Offset(0, h), redDiag);

    // White Cross
    final whiteCross = Paint()..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(w * 0.37, 0, w * 0.26, h), whiteCross);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.37, w, h * 0.26), whiteCross);

    // Red Cross
    final redCross = Paint()..color = const Color(0xFFC8102E);
    canvas.drawRect(Rect.fromLTWH(w * 0.42, 0, w * 0.16, h), redCross);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.42, w, h * 0.16), redCross);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
