import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:estehlaky/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 56,
    this.borderRadius = 33,
    this.fontSize = AppStyles.s21,
    this.gradientColors = const [AppColors.blue0754CD, AppColors.blue003696],
    this.locale,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final List<Color> gradientColors;
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    final isDisabled = isLoading || onPressed == null;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Text(
                text,
                style: AppStyles.style(
                  locale: locale ?? Localizations.localeOf(context),
                  fontSize: fontSize,
                  fontWeight: AppStyles.bold,
                  color: AppColors.white,
                ),
              ),
      ),
    );
  }
}
