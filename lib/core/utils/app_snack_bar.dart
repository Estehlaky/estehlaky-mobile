import 'package:flutter/material.dart';

class AppSnackBar {
  AppSnackBar._();

  static void showError(BuildContext context, {required String message}) {
    _show(
      context,
      message: message,
      backgroundColor: Colors.red.shade700,
      icon: Icons.error_outline,
    );
  }

  static void showSuccess(BuildContext context, {required String message}) {
    _show(
      context,
      message: message,
      backgroundColor: Colors.green.shade700,
      icon: Icons.check_circle_outline,
    );
  }

  static void showInfo(BuildContext context, {required String message}) {
    _show(
      context,
      message: message,
      backgroundColor: Colors.blueGrey.shade700,
      icon: Icons.info_outline,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }
}
