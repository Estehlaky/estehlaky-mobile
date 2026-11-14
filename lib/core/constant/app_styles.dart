
import 'package:estehlaky/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppStyles {
  static const String inter = 'Inter';
  static const String cairo = 'Cairo';

  static String fontFamily(Locale locale) {
    return locale.languageCode == 'ar' ? cairo : inter;
  }

  // Measured font sizes from Page 1.
  static const double s11 = 11;
  static const double s11_4425 = 11.4425;
  static const double s12 = 12;
  static const double s13 = 13;
  static const double s13_0362 = 13.0362;
  static const double s13_2203 = 13.2203;
  static const double s13_5 = 13.5;
  static const double s13_6364 = 13.6364;
  static const double s14 = 14;
  static const double s14_8571 = 14.8571;
  static const double s15 = 15;
  static const double s15_2089 = 15.2089;
  static const double s15_2567 = 15.2567;
  static const double s15_4237 = 15.4237;
  static const double s16 = 16;
  static const double s16_0952 = 16.0952;
  static const double s16_2953 = 16.2953;
  static const double s16_3066 = 16.3066;
  static const double s16_3636 = 16.3636;
  static const double s16_4211 = 16.4211;
  static const double s16_4789 = 16.4789;
  static const double s17 = 17;
  static const double s17_1638 = 17.1638;
  static const double s17_2254 = 17.2254;
  static const double s17_3816 = 17.3816;
  static const double s17_6271 = 17.6271;
  static const double s17_7273 = 17.7273;
  static const double s18 = 18;
  static const double s18_5714 = 18.5714;
  static const double s19 = 19;
  static const double s19_0909 = 19.0909;
  static const double s19_1579 = 19.1579;
  static const double s19_2254 = 19.2254;
  static const double s19_8095 = 19.8095;
  static const double s20 = 20;
  static const double s20_3833 = 20.3833;
  static const double s20_9780 = 20.9780;
  static const double s21 = 21;
  static const double s21_7270 = 21.7270;
  static const double s21_8182 = 21.8182;
  static const double s21_8947 = 21.8947;
  static const double s21_9718 = 21.9718;
  static const double s22 = 22;
  static const double s22_0339 = 22.0339;
  static const double s23 = 23;
  static const double s24 = 24;
  static const double s25 = 25;
  static const double s25_9091 = 25.9091;
  static const double s26 = 26;
  static const double s28 = 28;
  static const double s28_7368 = 28.7368;
  static const double s28_8380 = 28.8380;
  static const double s29 = 29;
  static const double s30 = 30;
  static const double s31_2544 = 31.2544;
  static const double s32 = 32;
  static const double s33 = 33;
  static const double s37 = 37;
  static const double s38 = 38;
  static const double s38_1818 = 38.1818;
  static const double s51_6376 = 51.6376;
  static const double s55 = 55;

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  static TextStyle style({
    required Locale locale,
    required double fontSize,
    FontWeight fontWeight = regular,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: fontFamily(locale),
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      decoration: decoration,
    );
  }

  static TextTheme textTheme({
    required Locale locale,
    required AppColorPalette colors,
  }) {
    final family = fontFamily(locale);

    TextStyle make(double size, FontWeight weight) {
      return TextStyle(
        fontFamily: family,
        fontSize: size,
        fontWeight: weight,
        color: colors.textPrimary,
      );
    }

    return TextTheme(
      displayLarge: make(s55, bold),
      displayMedium: make(s38, bold),
      displaySmall: make(s32, bold),
      headlineLarge: make(s29, bold),
      headlineMedium: make(s25, bold),
      headlineSmall: make(s23, bold),
      titleLarge: make(s20, bold),
      titleMedium: make(s18, medium),
      titleSmall: make(s16, medium),
      bodyLarge: make(s16, regular),
      bodyMedium: make(s14, regular),
      bodySmall: make(s12, regular),
      labelLarge: make(s14, bold),
      labelMedium: make(s13, medium),
      labelSmall: make(s11, regular),
    );
  }
}
