import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/core/constant/app_images.dart';
import 'package:estehlaky/core/constant/app_router.dart';
import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:estehlaky/core/utils/app_gradient_button.dart';
import 'package:estehlaky/core/utils/app_snack_bar.dart';
import 'package:estehlaky/features/auth/presentation/forget_password/view/widgets/otp_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class VerifyOtpView extends StatefulWidget {
  final String phoneNumber;

  const VerifyOtpView({super.key, required this.phoneNumber});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  String _otpCode = '';
  void _verifyOtp() {
    if (_otpCode.length != 5) {
      AppSnackBar.showInfo(
        context,
        message: AppLocalizations.of(context).enterCompleteOtp,
      );
      return;
    }
    context.push(AppRoutes.resetPassword);
    // Send OTP to AuthCubit.
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final colors = Theme.of(context).colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: colors.onPrimary,
          iconTheme: IconThemeData(color: colors.primary),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;

              final isSmallScreen = screenWidth < 360;
              final isTablet = screenWidth >= 600;
              final isCompactHeight = screenHeight < 700;

              final horizontalPadding = isSmallScreen
                  ? 18.0
                  : isTablet
                  ? 32.0
                  : 24.0;

              final contentMaxWidth = isTablet ? 460.0 : 420.0;

              final illustrationSize = (screenWidth * 0.32).clamp(100.0, 145.0);

              final topSpacing = (screenHeight * 0.045).clamp(20.0, 48.0);

              final sectionSpacing = isCompactHeight ? 18.0 : 28.0;

              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentMaxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: topSpacing),

                        // Verification Illustration
                        SizedBox(
                          width: illustrationSize * 1.25,
                          height: illustrationSize,
                          child: Image.asset(
                            AppImages.phoneVerification,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: sectionSpacing),

                        // Title
                        Text(
                          localization.verifyPhoneNumber,
                          textAlign: TextAlign.center,
                          style: AppStyles.style(
                            locale: locale,
                            fontSize: isSmallScreen
                                ? AppStyles.s24
                                : AppStyles.s28,
                            fontWeight: AppStyles.extraBold,
                            color: colors.onSurface,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Subtitle
                        Text(
                          '${localization.enterCodeSentTo}\n${widget.phoneNumber}',
                          textAlign: TextAlign.center,
                          style: AppStyles.style(
                            locale: locale,
                            fontSize: AppStyles.s14,
                            fontWeight: AppStyles.bold,
                            color: colors.onSurfaceVariant,
                          ),
                        ),

                        SizedBox(height: sectionSpacing),

                        OtpPin(
                          onChanged: (otp) {
                            _otpCode = otp;
                          },
                          onCompleted: (otp) {
                            _verifyOtp();
                          },
                        ),

                        const SizedBox(height: 12),

                        // Resend Code
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            localization.resendCodeWithTimer('00:45'),
                            style: AppStyles.style(
                              locale: locale,
                              fontSize: AppStyles.s14,
                              fontWeight: AppStyles.bold,
                              color: colors.onSurface,
                            ),
                          ),
                        ),

                        SizedBox(height: sectionSpacing),

                        // Verify Button
                        AppGradientButton(
                          text: localization.verify,
                          onPressed: () => _verifyOtp(),
                        ),

                        const SizedBox(height: 16),

                        // Back Button
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              backgroundColor: colors.onPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                            child: Text(
                              localization.back,
                              style: AppStyles.style(
                                locale: locale,
                                fontSize: AppStyles.s16,
                                fontWeight: AppStyles.bold,
                                color: colors.onSurface,
                              ),
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
        ),
      ),
    );
  }
}
