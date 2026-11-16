import 'package:estehlaky/config/di/di.dart';
import 'package:estehlaky/features/auth/presentation/login/view/login_view.dart';
import 'package:estehlaky/features/auth/presentation/sign_up/view/signup_view.dart';
import 'package:estehlaky/features/splash/presentation/onboarding/view/onboarding_view.dart';
import 'package:estehlaky/features/splash/presentation/splash/view/splash_view.dart';
import 'package:estehlaky/features/splash/usecases/has_seen_onboarding_use_case.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const onBoarding = '/onBoarding';
  static const login = '/login';
  static const signUp = '/sign-up';
  static const forgetPassword = '/forgot-password';
  static const resetPassword = '/reset-password';
}

abstract final class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) =>
            SplashView(hasSeenOnboarding: getIt<HasSeenOnboardingUseCase>()),
      ),
      GoRoute(
        path: AppRoutes.onBoarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpView(),
      ),
    ],
  );
}
