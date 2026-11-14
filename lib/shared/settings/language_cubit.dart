import 'package:estehlaky/config/storage/settings_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  final SettingsStorageService _storageService;

  LanguageCubit(this._storageService)
      : super(_storageService.getLanguage());

  Future<void> changeLanguage(String languageCode) async {
    final locale = Locale(languageCode);

    await _storageService.saveLanguage(locale);
    emit(locale);
  }
}