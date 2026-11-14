
import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:estehlaky/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData light({required Locale locale}) {
    return _buildTheme(
      brightness: Brightness.light,
      colors: AppColors.light,
      locale: locale,
    );
  }

  static ThemeData dark({required Locale locale}) {
    return _buildTheme(
      brightness: Brightness.dark,
      colors: AppColors.dark,
      locale: locale,
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required AppColorPalette colors,
    required Locale locale,
  }) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = (isDark
            ? const ColorScheme.dark()
            : const ColorScheme.light())
        .copyWith(
      primary: colors.primary,
      onPrimary: isDark ? AppColors.blue18263E : AppColors.white,
      secondary: colors.accent,
      onSecondary: AppColors.brown352600,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      outline: colors.border,
      onSurfaceVariant: colors.textSecondary,
      error: colors.error,
      onError: AppColors.white,
      shadow: colors.shadow,
    );

    final textTheme = AppStyles.textTheme(
      locale: locale,
      colors: colors,
    );

    final defaultRadius = BorderRadius.circular(12);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      fontFamily: AppStyles.fontFamily(locale),
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      cardColor: colors.surface,

      extensions: [
        AppThemeColors(
          success: colors.success,
          warning: colors.warning,
          info: colors.info,
          textTertiary: colors.textTertiary,
          shadow: colors.shadow,
        ),
      ],

      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 25,
        iconTheme: IconThemeData(
          color: colors.textPrimary,
          size: 20,
        ),
      ),

      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: defaultRadius,
          side: BorderSide(color: colors.border),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 1,
        space: 1,
      ),

      iconTheme: IconThemeData(
        color: colors.textSecondary,
        size: 22,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surface,
        indicatorColor: colors.primary.withValues(alpha: 0.12),
        elevation: 0,
        labelTextStyle: WidgetStatePropertyAll(
          AppStyles.style(
            locale: locale,
            fontSize: AppStyles.s12,
            fontWeight: AppStyles.medium,
            color: colors.textSecondary,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: isDark
              ? AppColors.blue18263E
              : AppColors.white,
          disabledBackgroundColor: colors.border,
          disabledForegroundColor: colors.textSecondary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppStyles.style(
            locale: locale,
            fontSize: AppStyles.s14,
            fontWeight: AppStyles.bold,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.textPrimary,
          side: BorderSide(color: colors.border),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppStyles.style(
            locale: locale,
            fontSize: AppStyles.s14,
            fontWeight: AppStyles.medium,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: AppStyles.style(
          locale: locale,
          fontSize: AppStyles.s14,
          color: colors.textTertiary,
        ),
        labelStyle: AppStyles.style(
          locale: locale,
          fontSize: AppStyles.s14,
          color: colors.textSecondary,
        ),
        errorStyle: AppStyles.style(
          locale: locale,
          fontSize: AppStyles.s12,
          color: colors.error,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colors.primary,
            width: 1.6,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colors.error,
            width: 1.6,
          ),
        ),
      ),
    );
  }
}

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color success;
  final Color warning;
  final Color info;
  final Color textTertiary;
  final Color shadow;

  const AppThemeColors({
    required this.success,
    required this.warning,
    required this.info,
    required this.textTertiary,
    required this.shadow,
  });

  @override
  AppThemeColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? textTertiary,
    Color? shadow,
  }) {
    return AppThemeColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      textTertiary: textTertiary ?? this.textTertiary,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  AppThemeColors lerp(
    covariant AppThemeColors? other,
    double t,
  ) {
    if (other == null) return this;

    return AppThemeColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}
