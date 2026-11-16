import 'dart:async';

import 'package:estehlaky/config/di/di.dart';
import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/core/constant/app_router.dart';
import 'package:estehlaky/features/splash/presentation/onboarding/view/onboarding_view.dart';
import 'package:estehlaky/features/splash/usecases/complete_onboarding_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockCompleteOnboardingUseCase extends Mock
    implements CompleteOnboardingUseCase {}

void main() {
  late MockCompleteOnboardingUseCase mockCompleteOnboarding;
  late AppLocalizations localization;

  setUp(() async {
    mockCompleteOnboarding = MockCompleteOnboardingUseCase();

    await getIt.reset();

    getIt.registerSingleton<CompleteOnboardingUseCase>(mockCompleteOnboarding);

    localization = await AppLocalizations.delegate.load(const Locale('en'));
  });

  tearDown(() async {
    await getIt.reset();
  });

  Future<void> pumpOnboardingView(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/onboarding-test',
      routes: [
        GoRoute(
          path: '/onboarding-test',
          builder: (context, state) => const OnboardingView(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Login Screen'))),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );

    await tester.pumpAndSettle();
  }

  group('OnboardingView', () {
    testWidgets('should display the first onboarding page', (tester) async {
      await pumpOnboardingView(tester);

      expect(find.text(localization.onboardingTitle1), findsOneWidget);

      expect(find.text(localization.onboardingNext), findsOneWidget);

      expect(find.text(localization.onboardingSkip), findsOneWidget);

      verifyNever(() => mockCompleteOnboarding());
    });

    testWidgets('should navigate to the second page when Next is tapped', (
      tester,
    ) async {
      await pumpOnboardingView(tester);

      await tester.tap(find.text(localization.onboardingNext));

      await tester.pumpAndSettle();

      expect(find.text(localization.onboardingTitle2), findsOneWidget);

      expect(find.text(localization.onboardingGetStarted), findsOneWidget);

      verifyNever(() => mockCompleteOnboarding());
    });

    testWidgets('should complete onboarding when Skip is tapped', (
      tester,
    ) async {
      when(() => mockCompleteOnboarding()).thenAnswer((_) async {});

      await pumpOnboardingView(tester);

      await tester.tap(find.text(localization.onboardingSkip));

      await tester.pumpAndSettle();

      verify(() => mockCompleteOnboarding()).called(1);

      expect(find.text('Login Screen'), findsOneWidget);
    });

    testWidgets('should complete onboarding when Get Started is tapped', (
      tester,
    ) async {
      when(() => mockCompleteOnboarding()).thenAnswer((_) async {});

      await pumpOnboardingView(tester);

      // Navigate to the last page.
      await tester.tap(find.text(localization.onboardingNext));

      await tester.pumpAndSettle();

      // Complete onboarding.
      await tester.tap(find.text(localization.onboardingGetStarted));

      await tester.pumpAndSettle();

      verify(() => mockCompleteOnboarding()).called(1);

      expect(find.text('Login Screen'), findsOneWidget);
    });

    testWidgets('should show loading indicator while completing', (
      tester,
    ) async {
      final completer = Completer<void>();

      when(() => mockCompleteOnboarding()).thenAnswer((_) => completer.future);

      await pumpOnboardingView(tester);

      await tester.tap(find.text(localization.onboardingSkip));

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Complete the pending operation.
      completer.complete();

      await tester.pumpAndSettle();

      expect(find.text('Login Screen'), findsOneWidget);
    });

    testWidgets('should prevent multiple completion requests', (tester) async {
      final completer = Completer<void>();

      when(() => mockCompleteOnboarding()).thenAnswer((_) => completer.future);

      await pumpOnboardingView(tester);

      await tester.tap(find.text(localization.onboardingSkip));

      await tester.pump();

      // Skip should be disabled while completing.
      expect(
        tester.widget<TextButton>(find.byType(TextButton)).onPressed,
        isNull,
      );

      verify(() => mockCompleteOnboarding()).called(1);

      completer.complete();

      await tester.pumpAndSettle();
    });

    testWidgets('should show error SnackBar if completion fails', (
      tester,
    ) async {
      when(() => mockCompleteOnboarding()).thenAnswer((_) async {
        throw Exception('Storage error');
      });

      await pumpOnboardingView(tester);

      await tester.tap(find.text(localization.onboardingSkip));

      await tester.pump();

      // Allow the SnackBar animation to start.
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text(localization.onboardingCompletionError), findsOneWidget);

      // The user should be able to retry.
      expect(find.text(localization.onboardingSkip), findsOneWidget);

      verify(() => mockCompleteOnboarding()).called(1);
    });
  });
}
