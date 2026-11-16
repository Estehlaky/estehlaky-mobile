import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/core/constant/app_images.dart';
import 'package:estehlaky/core/constant/app_router.dart';
import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:estehlaky/core/ui/app_colors.dart';
import 'package:estehlaky/features/splash/usecases/has_seen_onboarding_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.hasSeenOnboarding});
  final HasSeenOnboardingUseCase hasSeenOnboarding;
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Logo animations
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<Offset> _logoSlide;

  // App name animations
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;

  // Tagline animations
  late final Animation<double> _taglineFade;
  late final Animation<Offset> _taglineSlide;

  // Accent line animation
  late final Animation<double> _lineScale;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    // 1. Logo: Fade + Scale + Slide
    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _logoScale = Tween<double>(begin: 0.72, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutBack),
      ),
    );

    _logoSlide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
          ),
        );

    // 2. App name
    _titleFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 0.65, curve: Curves.easeIn),
    );

    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.25, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    // 3. Tagline
    _taglineFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 0.8, curve: Curves.easeIn),
    );

    _taglineSlide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
          ),
        );

    // 4. Yellow accent line expands from the center
    _lineScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOutCubic),
    );

    _controller.forward();

    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final hasSeenOnboarding = widget.hasSeenOnboarding();

    if (hasSeenOnboarding) {
      context.go(AppRoutes.login);
    } else {
      context.go(AppRoutes.onBoarding);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.blue071022,
              AppColors.blue041A50,
              AppColors.blue00358E,
              AppColors.blue0067EC,
            ],
            stops: [0.0, 0.35, 0.75, 1.0],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Cairo skyline background
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.transparent, AppColors.black],
                    stops: [0.0, 0.35],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  AppImages.cairoSkyline,
                  width: size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),

            // Animated branding
            Positioned(
              top: size.height * 0.24,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Logo
                  FadeTransition(
                    opacity: _logoFade,
                    child: SlideTransition(
                      position: _logoSlide,
                      child: ScaleTransition(
                        scale: _logoScale,
                        child: Image.asset(
                          AppImages.estehlakyImage,
                          width: size.width * 0.72,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // App name
                  FadeTransition(
                    opacity: _titleFade,
                    child: SlideTransition(
                      position: _titleSlide,
                      child: Text(
                        localization.appName,
                        style: AppStyles.style(
                          locale: locale,
                          fontSize: AppStyles.s55,
                          fontWeight: AppStyles.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Tagline
                  FadeTransition(
                    opacity: _taglineFade,
                    child: SlideTransition(
                      position: _taglineSlide,
                      child: Text(
                        localization.appTagline,
                        style: AppStyles.style(
                          locale: locale,
                          fontSize: AppStyles.s23,
                          fontWeight: AppStyles.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Animated yellow accent
                  ScaleTransition(
                    alignment: Alignment.center,
                    scale: _lineScale,
                    child: Container(
                      width: size.width * 0.23,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.goldFFB800,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
