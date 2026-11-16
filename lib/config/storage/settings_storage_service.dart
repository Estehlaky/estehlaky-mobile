import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SettingsStorageService {
  static const String _boxName = 'settings';

  static const String _languageKey = 'language';
  static const String _themeKey = 'theme';
  static const String _hasSeenOnboardingKey = 'hasSeenOnboarding';

  Box get _box => Hive.box(_boxName);

  Locale getLanguage() {
    final languageCode = _box.get(_languageKey, defaultValue: 'ar') as String;
    return Locale(languageCode);
  }

  Future<void> saveLanguage(Locale locale) async {
    await _box.put(_languageKey, locale.languageCode);
  }

  ThemeMode getThemeMode() {
    final theme = _box.get(_themeKey, defaultValue: 'system') as String;

    return ThemeMode.values.firstWhere(
      (mode) => mode.name == theme,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    await _box.put(_themeKey, mode.name);
  }

  bool get hasSeenOnboarding {
    return _box.get(_hasSeenOnboardingKey, defaultValue: false) as bool;
  }

  Future<void> setOnboardingCompleted() async {
    await _box.put(_hasSeenOnboardingKey, true);
  }
}
