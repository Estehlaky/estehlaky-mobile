import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/core/constant/app_images.dart';
import 'package:estehlaky/core/constant/app_router.dart';
import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:estehlaky/core/ui/app_colors.dart';
import 'package:estehlaky/core/utils/app_gradient_button.dart';
import 'package:estehlaky/core/utils/custom_text_field.dart';
import 'package:estehlaky/features/auth/presentation/login/view/widgets/top_left_wave_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    final localization = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background wave
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: Size(size.width * 0.45, size.height * 0.16),
              painter: TopLeftWavePainter(),
            ),
          ),

          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;

              // Responsive horizontal padding
              final horizontalPadding = screenWidth < 360
                  ? 18.0
                  : screenWidth < 600
                  ? 28.0
                  : 40.0;

              // Limit form width on tablets / large screens
              final contentWidth = screenWidth > 600
                  ? 500.0
                  : screenWidth - (horizontalPadding * 2);

              // Responsive logo size
              final logoSize = screenWidth < 360
                  ? 90.0
                  : screenWidth < 600
                  ? 105.0
                  : 120.0;

              // Responsive spacing
              final topSpacing = screenWidth < 360
                  ? 24.0
                  : screenWidth < 600
                  ? 32.0
                  : 48.0;

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
                        SizedBox(height: topSpacing),

                        // Logo
                        SizedBox(
                          width: logoSize,
                          height: logoSize,
                          child: Image.asset(
                            AppImages.estehlakyLogo,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: screenWidth < 600 ? 10 : 14),

                        // App name
                        Text(
                          localization.appName,
                          textAlign: TextAlign.center,
                          style: AppStyles.style(
                            locale: locale,
                            fontSize: screenWidth < 360
                                ? AppStyles.s32
                                : screenWidth < 600
                                ? AppStyles.s37
                                : AppStyles.s38,
                            fontWeight: AppStyles.extraBold,
                            color: colors.onSurface,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // Subtitle
                        Text(
                          localization.electricityUnderstood,
                          textAlign: TextAlign.center,
                          style: AppStyles.style(
                            locale: locale,
                            fontSize: screenWidth < 360
                                ? AppStyles.s20
                                : screenWidth < 600
                                ? AppStyles.s25
                                : AppStyles.s28,
                            fontWeight: AppStyles.bold,
                            color: colors.onSurfaceVariant,
                          ),
                        ),

                        SizedBox(height: screenWidth < 600 ? 24 : 32),

                        // Welcome
                        Text(
                          localization.welcomeBack,
                          textAlign: TextAlign.center,
                          style: AppStyles.style(
                            locale: locale,
                            fontSize: screenWidth < 360
                                ? AppStyles.s21
                                : screenWidth < 600
                                ? AppStyles.s25
                                : AppStyles.s28,
                            fontWeight: AppStyles.extraBold,
                            color: colors.onSurface,
                          ),
                        ),

                        SizedBox(height: screenWidth < 600 ? 20 : 26),

                        // Phone
                        CustomTextField(
                          controller: _phoneController,
                          hintText: localization.phoneNumber,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),

                        const SizedBox(height: 16),

                        // Password
                        CustomTextField(
                          controller: _passwordController,
                          hintText: localization.password,
                          icon: Icons.lock,
                          isPassword: true,
                        ),

                        const SizedBox(height: 12),

                        // Forgot password
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                            child: Text(
                              localization.forgotPassword,
                              style: AppStyles.style(
                                locale: locale,
                                fontSize: AppStyles.s14,
                                fontWeight: AppStyles.bold,
                                color: colors.onSurface,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Sign in
                        AppGradientButton(
                          text: localization.signIn,
                          onPressed: () {},
                        ),

                        SizedBox(height: screenWidth < 600 ? 20 : 26),

                        // Or divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: colors.outlineVariant.withValues(
                                  alpha: 0.3,
                                ),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Text(
                                localization.or,
                                style: AppStyles.style(
                                  locale: locale,
                                  fontSize: AppStyles.s14,
                                  fontWeight: AppStyles.regular,
                                  color: colors.onSurface,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: colors.outlineVariant.withValues(
                                  alpha: 0.3,
                                ),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Google sign in
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: AppColors.blueC6D4E5),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: SvgPicture.asset(
                              AppImages.googleSvg,
                              fit: BoxFit.scaleDown,
                              height: 28,
                              width: 28,
                            ),
                          ),
                        ),

                        SizedBox(height: screenWidth < 600 ? 22 : 28),

                        // Create account
                        GestureDetector(
                          onTap: () {
                            context.push(AppRoutes.signUp);
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: AppStyles.style(
                                locale: locale,
                                fontSize: AppStyles.s14,
                                fontWeight: AppStyles.bold,
                                color: colors.onSurface,
                              ),
                              children: [
                                TextSpan(text: '${localization.newHere} '),
                                TextSpan(
                                  text: localization.createAccount,
                                  style: AppStyles.style(
                                    locale: locale,
                                    fontSize: AppStyles.s14,
                                    fontWeight: AppStyles.extraBold,
                                    color: colors.primary,
                                  ),
                                ),
                              ],
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
