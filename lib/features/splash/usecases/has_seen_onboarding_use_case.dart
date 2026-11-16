import 'package:injectable/injectable.dart';

import '../repositories/onboarding_repository.dart';

@lazySingleton
class HasSeenOnboardingUseCase {
  final OnboardingRepository _repository;

  HasSeenOnboardingUseCase(this._repository);

  bool call() {
    return _repository.hasSeenOnboarding();
  }
}
