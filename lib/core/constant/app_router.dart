import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const splash = '/';
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
      // SPLASH
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return const Scaffold(body: Center(child: Text('Splash Screen')));
        },
      ),

      // LOGIN
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          return const Scaffold(body: Center(child: Text('Login Screen')));
        },
      ),

      // SIGN UP
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) {
          return const Scaffold(body: Center(child: Text('Sign Up Screen')));
        },
      ),

      // FORGET PASSWORD
      GoRoute(
        path: AppRoutes.forgetPassword,
        builder: (context, state) {
          return const Scaffold(
            body: Center(child: Text('Forget Password Screen')),
          );
        },
      ),

      // RESET PASSWORD
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) {
          return const Scaffold(
            body: Center(child: Text('Reset Password Screen')),
          );
        },
      ),
    ],
  );
}
