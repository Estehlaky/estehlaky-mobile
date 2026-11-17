import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/core/constant/app_router.dart';
import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:estehlaky/core/utils/app_gradient_button.dart';
import 'package:estehlaky/core/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    final localization = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final colors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: colors.onPrimary,
        iconTheme: IconThemeData(color: colors.primary),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final horizontalPadding = width < 360
                ? 18.0
                : width < 600
                ? 28.0
                : 40.0;

            final contentWidth = width > 600
                ? 500.0
                : width - horizontalPadding * 2;

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),

                      Text(
                        localization.createAccount,
                        textAlign: TextAlign.center,
                        style: AppStyles.style(
                          locale: locale,
                          fontSize: screenWidth < 360
                              ? AppStyles.s25
                              : AppStyles.s28,
                          fontWeight: AppStyles.extraBold,
                          color: colors.onSurface,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        localization.signUpSubtitle,
                        textAlign: TextAlign.center,
                        style: AppStyles.style(
                          locale: locale,
                          fontSize: AppStyles.s14,
                          fontWeight: AppStyles.regular,
                          color: colors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 32),

                      CustomTextField(
                        controller: _fullNameController,
                        hintText: localization.fullName,
                        icon: Icons.person,
                      ),

                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _phoneController,
                        hintText: localization.phoneNumber,
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _passwordController,
                        hintText: localization.password,
                        icon: Icons.lock,
                        isPassword: true,
                      ),

                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: localization.confirmPassword,
                        icon: Icons.lock,
                        isPassword: true,
                      ),

                      const SizedBox(height: 28),

                      AppGradientButton(
                        text: localization.createAccount,
                        onPressed: _handleSignUp,
                      ),

                      const SizedBox(height: 24),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localization.byContinuingYouAgree,
                            style: AppStyles.style(
                              locale: locale,
                              fontSize: AppStyles.s14,
                              fontWeight: AppStyles.bold,
                              color: colors.onSurface,
                            ),
                          ),
                          Text(
                            localization.termsAndPrivacyPolicy,
                            style: AppStyles.style(
                              locale: locale,
                              fontSize: AppStyles.s14,
                              fontWeight: AppStyles.bold,
                              color: colors.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleSignUp() {
    final fullName = _fullNameController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (fullName.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return;
    }

    if (password != confirmPassword) {
      return;
    }
    context.go(AppRoutes.registrationSuccess);
  }
}
