abstract class OnboardingRepository {
  bool hasSeenOnboarding();

  Future<void> completeOnboarding();
}
