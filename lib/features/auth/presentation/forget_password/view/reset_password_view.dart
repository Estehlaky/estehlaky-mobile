import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/core/constant/app_images.dart';
import 'package:estehlaky/core/constant/app_router.dart';
import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:estehlaky/core/utils/app_gradient_button.dart';
import 'package:estehlaky/core/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    final localization = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: colors.onPrimary,
        iconTheme: IconThemeData(color: colors.primary),
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;

              final horizontalPadding = screenWidth < 360
                  ? 18.0
                  : screenWidth < 600
                  ? 28.0
                  : 40.0;

              final contentWidth = screenWidth > 600 ? 500.0 : double.infinity;

              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 20,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth < 360 ? 150 : 200,
                          height: screenWidth < 360 ? 100 : 125,
                          child: Image.asset(
                            AppImages.passwordReset,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: screenWidth < 600 ? 24 : 32),

                        Text(
                          localization.resetPassword,
                          textAlign: TextAlign.center,
                          style: AppStyles.style(
                            locale: locale,
                            fontSize: screenWidth < 360
                                ? AppStyles.s24
                                : AppStyles.s28,
                            fontWeight: AppStyles.extraBold,
                            color: colors.onSurface,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          localization.enterPhoneToReceiveOtp,
                          textAlign: TextAlign.center,
                          style: AppStyles.style(
                            locale: locale,
                            fontSize: AppStyles.s14,
                            fontWeight: AppStyles.bold,
                            color: colors.onSurfaceVariant,
                          ),
                        ),

                        SizedBox(height: screenWidth < 600 ? 32 : 40),

                        CustomTextField(
                          controller: _phoneController,
                          hintText: localization.phoneNumber,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),

                        SizedBox(height: screenWidth < 600 ? 24 : 32),

                        AppGradientButton(
                          text: localization.sendCode,
                          onPressed: () {
                            context.push(AppRoutes.newPassword);
                          },
                        ),

                        SizedBox(height: screenWidth < 600 ? 24 : 32),

                        GestureDetector(
                          onTap: () => context.go(AppRoutes.login),
                          child: Text(
                            localization.backToLogin,
                            textAlign: TextAlign.center,
                            style: AppStyles.style(
                              locale: locale,
                              fontSize: AppStyles.s14,
                              fontWeight: AppStyles.bold,
                              color: colors.onSurface,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
