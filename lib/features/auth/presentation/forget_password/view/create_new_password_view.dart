import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/core/constant/app_images.dart';
import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:estehlaky/core/utils/app_gradient_button.dart';
import 'package:estehlaky/core/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final bool _obscureNewPassword = true;
  final bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
                            AppImages.newPasswordLock,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: screenWidth < 600 ? 24 : 30),

                        Text(
                          localization.createNewPassword,
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
                          localization.enterStrongPassword,
                          textAlign: TextAlign.center,
                          style: AppStyles.style(
                            locale: locale,
                            fontSize: AppStyles.s14,
                            fontWeight: AppStyles.bold,
                            color: colors.onSurfaceVariant,
                          ),
                        ),

                        SizedBox(height: screenWidth < 600 ? 28 : 36),

                        CustomTextField(
                          controller: _newPasswordController,
                          hintText: localization.newPassword,
                          icon: Icons.lock,
                          isPassword: _obscureNewPassword,
                        ),

                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: localization.confirmPassword,
                          icon: Icons.lock,
                          isPassword: _obscureConfirmPassword,
                        ),

                        SizedBox(height: screenWidth < 600 ? 28 : 36),

                        AppGradientButton(
                          text: localization.setPassword,
                          onPressed: () {},
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
