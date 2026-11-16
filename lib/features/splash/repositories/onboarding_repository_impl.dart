import 'package:estehlaky/config/storage/settings_storage_service.dart';
import 'package:estehlaky/features/splash/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  final SettingsStorageService _storageService;

  OnboardingRepositoryImpl(this._storageService);

  @override
  bool hasSeenOnboarding() {
    return _storageService.hasSeenOnboarding;
  }

  @override
  Future<void> completeOnboarding() {
    return _storageService.setOnboardingCompleted();
  }
}
