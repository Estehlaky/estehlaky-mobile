import 'package:estehlaky/config/storage/settings_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
class ThemeCubit extends Cubit<ThemeMode> {
  final SettingsStorageService _storageService;

  ThemeCubit(this._storageService)
      : super(_storageService.getThemeMode());

  Future<void> changeTheme(ThemeMode mode) async {
    await _storageService.saveThemeMode(mode);
    emit(mode);
  }
}