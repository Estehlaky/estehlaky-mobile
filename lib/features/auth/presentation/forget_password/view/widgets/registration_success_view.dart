import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/core/constant/app_images.dart';
import 'package:estehlaky/core/constant/app_router.dart';
import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:estehlaky/core/utils/app_gradient_button.dart';
import 'package:estehlaky/features/auth/presentation/forget_password/view/widgets/pyramids_wave_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class RegistrationSuccessView extends StatelessWidget {
  const RegistrationSuccessView({super.key});

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
          // Bottom Skyline
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black],
                      stops: [0.0, 0.35],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: theme.brightness == Brightness.dark
                      ? DarkModePyramidsWaveWidget(height: 150)
                      : Opacity(
                          opacity: .9,
                          child: Image.asset(
                            AppImages.cairoSkylineGold,
                            width: size.width,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                ),
              ],
            ),
          ),

          // Main Content
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
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 40,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentWidth),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth < 360 ? 150 : 200,
                            height: screenWidth < 360 ? 100 : 125,
                            child: Image.asset(
                              AppImages.registrationSuccess,
                              fit: BoxFit.contain,
                            ),
                          ),

                          SizedBox(height: screenWidth < 600 ? 24 : 32),

                          Text(
                            localization.registrationSuccess,
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

                          const SizedBox(height: 12),

                          Text(
                            localization.enjoyEstehlakyFeatures,
                            textAlign: TextAlign.center,
                            style: AppStyles.style(
                              locale: locale,
                              fontSize: AppStyles.s16,
                              fontWeight: AppStyles.bold,
                              color: colors.onSurfaceVariant,
                            ),
                          ),

                          SizedBox(height: screenWidth < 600 ? 36 : 44),

                          AppGradientButton(
                            text: localization.goToDashboard,
                            onPressed: () {
                              context.go(AppRoutes.login);
                            },
                          ),

                          SizedBox(height: size.height * 0.12),
                        ],
                      ),
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
