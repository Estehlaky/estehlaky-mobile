
import 'package:flutter/material.dart';

abstract final class AppColors {
  // Neutrals and blues
  static const blue172B4D = Color(0xFF172B4D);
  static const blue18263E = Color(0xFF18263E);
  static const blue50647F = Color(0xFF50647F);
  static const blue2463B4 = Color(0xFF2463B4);
  static const blue12368C = Color(0xFF12368C);
  static const blue00358E = Color(0xFF00358E);
  static const blue0754CD = Color(0xFF0754CD);
  static const blue003696 = Color(0xFF003696);
  static const blue0067EC = Color(0xFF0067EC);
  static const blue006BF0 = Color(0xFF006BF0);
  static const blue0648B8 = Color(0xFF0648B8);
  static const blue245FA7 = Color(0xFF245FA7);
  static const blue2160B2 = Color(0xFF2160B2);
  static const blue009AFF = Color(0xFF009AFF);
  static const blue009CFF = Color(0xFF009CFF);
  static const blue00A2F4 = Color(0xFF00A2F4);
  static const blue4686FF = Color(0xFF4686FF);
  static const blue8DBBFF = Color(0xFF8DBBFF);
  static const blue9FC8FF = Color(0xFF9FC8FF);
  static const blue81B3FF = Color(0xFF81B3FF);
  static const blueA1B4D4 = Color(0xFFA1B4D4);
  static const blueB2C3DF = Color(0xFFB2C3DF);
  static const blueC6D4E5 = Color(0xFFC6D4E5);
  static const blueC9D8EB = Color(0xFFC9D8EB);
  static const blueBDCCDF = Color(0xFFBDCCDF);
  static const blueD5DFED = Color(0xFFD5DFED);
  static const blueD8E8FF = Color(0xFFD8E8FF);
  static const blueDCEAFF = Color(0xFFDCEAFF);
  static const blueE3EFFF = Color(0xFFE3EFFF);
  static const blueE6EEF9 = Color(0xFFE6EEF9);
  static const blueE7EFFB = Color(0xFFE7EFFB);
  static const blueEAF2FF = Color(0xFFEAF2FF);
  static const blueEDF3FF = Color(0xFFEDF3FF);
  static const blueF5F8FD = Color(0xFFF5F8FD);
  static const blueF8FBFF = Color(0xFFF8FBFF);

  static const blue354B6B = Color(0xFF354B6B);
  static const blue2B3B55 = Color(0xFF2B3B55);
  static const blue0C1425 = Color(0xFF0C1425);
  static const blue101C30 = Color(0xFF101C30);
  static const blue182944 = Color(0xFF182944);
  static const blue182E4B = Color(0xFF182E4B);
  static const blue20334F = Color(0xFF20334F);
  static const blue243D61 = Color(0xFF243D61);
  static const blue1F4275 = Color(0xFF1F4275);
  static const blue1F529E = Color(0xFF1F529E);
  static const blue072660 = Color(0xFF072660);
  static const blue041A50 = Color(0xFF041A50);
  static const blue041A5A = Color(0xFF041A5A);
  static const blue071022 = Color(0xFF071022);
  static const blue12396C = Color(0xFF12396C);

  // White, black and neutral colors
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  // Gold and yellow colors
  static const goldFFA000 = Color(0xFFFFA000);
  static const goldFFAE00 = Color(0xFFFFAE00);
  static const goldFFB500 = Color(0xFFFFB500);
  static const goldFFB800 = Color(0xFFFFB800);
  static const goldFFA700 = Color(0xFFFFA700);
  static const goldFF9D00 = Color(0xFFFF9D00);
  static const goldFFA900 = Color(0xFFFFA900);
  static const goldFFAB00 = Color(0xFFFFAB00);
  static const goldFFB300 = Color(0xFFFFB300);
  static const goldFFBD00 = Color(0xFFFFBD00);
  static const goldFFBF00 = Color(0xFFFFBF00);
  static const goldFFBB18 = Color(0xFFFFBB18);
  static const goldFFD43B = Color(0xFFFFD43B);
  static const goldFFD675 = Color(0xFFFFD675);
  static const goldF6C85D = Color(0xFFF6C85D);
  static const goldFFF1CF = Color(0xFFFFF1CF);
  static const goldFFF0C8 = Color(0xFFFFF0C8);
  static const goldFFEDBF = Color(0xFFFFEDBF);
  static const goldFFF8E7 = Color(0xFFFFF8E7);
  static const goldF5E4BA = Color(0xFFF5E4BA);
  static const brown352600 = Color(0xFF352600);
  static const brown392F1E = Color(0xFF392F1E);
  static const brown58441F = Color(0xFF58441F);
  static const brown55421F = Color(0xFF55421F);
  static const brown2F281B = Color(0xFF2F281B);
  static const brown765212 = Color(0xFF765212);
  static const brown906000 = Color(0xFF906000);

  // Green and red colors
  static const green4B982D = Color(0xFF4B982D);
  static const green68BE32 = Color(0xFF68BE32);
  static const green6DC534 = Color(0xFF6DC534);
  static const greenA8DF50 = Color(0xFFA8DF50);
  static const greenC4F111 = Color(0xFFC4F111);
  static const green0F2E1A = Color(0xFF0F2E1A);
  static const green295B21 = Color(0xFF295B21);
  static const greenDEF1CE = Color(0xFFDEF1CE);
  static const redFF304F = Color(0xFFFF304F);

  // Shadow color: same RGB, two measured opacities.
  static const shadowBlue9 = Color(0x1712368C);
  static const shadowBlue10 = Color(0x1A12368C);

  // Semantic palettes: suggested mappings from the supplied inventory.
  static const AppColorPalette light = AppColorPalette(
    primary: blue2463B4,
    accent: goldFFA000,
    background: blueF5F8FD,
    surface: white,
    textPrimary: blue172B4D,
    textSecondary: blue50647F,
    textTertiary: Color(0xFF71829B),
    border: blueC6D4E5,
    error: redFF304F,
    success: green4B982D,
    warning: goldFFA000,
    info: blue009CFF,
    shadow: shadowBlue9,
  );

  static const AppColorPalette dark = AppColorPalette(
    primary: blue8DBBFF,
    accent: goldFFA000,
    background: blue0C1425,
    surface: blue18263E,
    textPrimary: blueEDF3FF,
    textSecondary: blueA1B4D4,
    textTertiary: Color(0xFF536887),
    border: blue354B6B,
    error: redFF304F,
    success: green6DC534,
    warning: goldFFA000,
    info: blue009CFF,
    shadow: shadowBlue10,
  );
}

@immutable
class AppColorPalette {
  final Color primary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color border;
  final Color error;
  final Color success;
  final Color warning;
  final Color info;
  final Color shadow;

  const AppColorPalette({
    required this.primary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.border,
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
    required this.shadow,
  });
}
