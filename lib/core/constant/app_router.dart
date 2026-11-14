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

      // GoRoute(
      //   path: AppRoutes.splash,
      //   parentNavigatorKey: rootNavigatorKey,
      //   builder: (context, state) {
      //     return const SplashView();
      //   },
      // ),

 
      // GoRoute(
      //   path: AppRoutes.login,
      //   parentNavigatorKey: rootNavigatorKey,
      //   builder: (context, state) {
      //     return LoginView();
      //   },
      // ),

       
      // GoRoute(
      //   path: AppRoutes.signUp,
      //   parentNavigatorKey: rootNavigatorKey,
      //   builder: (context, state) {
      //     return const SignUpView();
      //   },
      // ),

      // FORGET PASSWORD
      // GoRoute(
      //   path: AppRoutes.forgetPassword,
      //   builder: (context, state) {
      //     return ForgetPasswordView();
      //   },
      //   parentNavigatorKey: rootNavigatorKey,
      // ),

     
      StatefulShellRoute.indexedStack(
        branches: [
          // ------------------------------------------------
          // HOME
          // ------------------------------------------------
          StatefulShellBranch(
            routes: [
              // GoRoute(
              //   path: AppRoutes.homeTab,
              //   builder: (context, state) {
              //     return HomeTabView(
              //       pushNotificationsServices:
              //           getIt<PushNotificationsServices>(),
              //     );
              //   },
              // ),
            ],
          ),

          // ------------------------------------------------
          // CATEGORIES
          // ------------------------------------------------
          StatefulShellBranch(
            routes: [
              // GoRoute(
              //   path: AppRoutes.categoriesTab,
              //   builder: (context, state) {
              //     return const CategoriesTabView();
              //   },
              // ),
            ],
          ),

          // ------------------------------------------------
          // CART
          // ------------------------------------------------
          StatefulShellBranch(
            routes: [
              // GoRoute(
              //   path: AppRoutes.cartTab,
              //   builder: (context, state) {
              //     return const CartTabView();
              //   },
              // ),
            ],
          ),

          // ------------------------------------------------
          // PROFILE
          // ------------------------------------------------
          StatefulShellBranch(
            routes: [
              // GoRoute(
              //   path: AppRoutes.profileTab,
              //   builder: (context, state) {
              //     return const ProfileTabView();
              //   },
              // ),
            ],
          ),
        ],
      ),

  
    ],
  );
}
