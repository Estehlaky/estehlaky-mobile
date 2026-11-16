import 'package:estehlaky/core/constant/app_images.dart';
import 'package:estehlaky/core/constant/app_router.dart';
import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/features/splash/presentation/splash/view/splash_view.dart';
import 'package:estehlaky/features/splash/usecases/has_seen_onboarding_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockHasSeenOnboardingUseCase extends Mock
    implements HasSeenOnboardingUseCase {}

void main() {
  late MockHasSeenOnboardingUseCase mockHasSeenOnboarding;

  setUp(() {
    mockHasSeenOnboarding = MockHasSeenOnboardingUseCase();
  });

  Future<void> pumpSplashView(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/splash-test',
      routes: [
        GoRoute(
          path: '/splash-test',
          builder: (context, state) =>
              SplashView(hasSeenOnboarding: mockHasSeenOnboarding),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Login Screen'))),
        ),
        GoRoute(
          path: AppRoutes.onBoarding,
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Onboarding Screen'))),
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
  }

  group('SplashView', () {
    testWidgets('should display splash screen branding', (tester) async {
      when(() => mockHasSeenOnboarding()).thenReturn(false);

      await pumpSplashView(tester);

      expect(find.byType(SplashView), findsOneWidget);

      expect(find.byType(Image), findsNWidgets(2));

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  AppImages.estehlakyImage,
        ),
        findsOneWidget,
      );

      // Allow the 3-second navigation timer to finish.
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('should navigate to login when onboarding was completed', (
      tester,
    ) async {
      when(() => mockHasSeenOnboarding()).thenReturn(true);

      await pumpSplashView(tester);

      // Advance through the splash delay.
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.text('Login Screen'), findsOneWidget);

      verify(() => mockHasSeenOnboarding()).called(1);
    });

    testWidgets('should navigate to onboarding on first launch', (
      tester,
    ) async {
      when(() => mockHasSeenOnboarding()).thenReturn(false);

      await pumpSplashView(tester);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.text('Onboarding Screen'), findsOneWidget);

      verify(() => mockHasSeenOnboarding()).called(1);
    });

    testWidgets('should not navigate before the splash delay finishes', (
      tester,
    ) async {
      when(() => mockHasSeenOnboarding()).thenReturn(true);

      await pumpSplashView(tester);

      // Advance 2 seconds: navigation should not happen yet.
      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(SplashView), findsOneWidget);
      expect(find.text('Login Screen'), findsNothing);
      expect(find.text('Onboarding Screen'), findsNothing);

      // The use case should not have been called before 3 seconds.
      verifyNever(() => mockHasSeenOnboarding());

      // Advance the remaining second to complete the pending timer.
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
    });
  });
}
