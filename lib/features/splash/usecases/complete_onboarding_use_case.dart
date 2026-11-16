import 'package:injectable/injectable.dart';

import '../repositories/onboarding_repository.dart';

@lazySingleton
class CompleteOnboardingUseCase {
  final OnboardingRepository _repository;

  CompleteOnboardingUseCase(this._repository);

  Future<void> call() {
    return _repository.completeOnboarding();
  }
}
