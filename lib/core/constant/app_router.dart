import 'package:estehlaky/config/di/di.dart';
import 'package:estehlaky/features/auth/presentation/forget_password/view/create_new_password_view.dart';
import 'package:estehlaky/features/auth/presentation/forget_password/view/reset_password_view.dart';
import 'package:estehlaky/features/auth/presentation/forget_password/view/verify_otp_view.dart';
import 'package:estehlaky/features/auth/presentation/forget_password/view/widgets/registration_success_view.dart';
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
  static const verifyOtpView = '/verifyOtpView';
  static const resetPassword = '/reset-password';
  static const newPassword = '/new-password';
  static const registrationSuccess = '/registrationSuccess';
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
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) => const ResetPasswordView(),
      ),
      GoRoute(
        path: AppRoutes.newPassword,
        builder: (context, state) => const CreateNewPasswordView(),
      ),
      GoRoute(
        path: AppRoutes.registrationSuccess,
        builder: (context, state) => const RegistrationSuccessView(),
      ),
      GoRoute(
        path: AppRoutes.verifyOtpView,
        builder: (context, state) =>
            const VerifyOtpView(phoneNumber: '0112528585'),
      ),
    ],
  );
}
