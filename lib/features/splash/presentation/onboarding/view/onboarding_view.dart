import 'package:estehlaky/config/di/di.dart';
import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/core/constant/app_images.dart';
import 'package:estehlaky/core/constant/app_router.dart';
import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:estehlaky/core/utils/app_gradient_button.dart';
import 'package:estehlaky/core/utils/app_snack_bar.dart';
import 'package:estehlaky/features/splash/usecases/complete_onboarding_use_case.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  late final CompleteOnboardingUseCase _completeOnboardingUseCase;

  int _currentPage = 0;
  bool _isCompleting = false;

  final List<Map<String, String>> _onboardingPages = [
    {
      'image': AppImages.featureIllustration,
      'title': 'onboardingTitle1',
      'description': 'onboardingDescription1',
    },
    {
      'image': AppImages.featureIllustration2,
      'title': 'onboardingTitle2',
      'description': 'onboardingDescription2',
    },
  ];

  @override
  void initState() {
    super.initState();

    _completeOnboardingUseCase = getIt<CompleteOnboardingUseCase>();
  }

  Future<void> _completeOnboarding() async {
    if (_isCompleting) return;

    setState(() => _isCompleting = true);

    try {
      await _completeOnboardingUseCase();

      if (!mounted) return;

      context.go(AppRoutes.login);
    } catch (error) {
      if (!mounted) return;

      setState(() => _isCompleting = false);

      final localization = AppLocalizations.of(context);
      AppSnackBar.showError(
        context,
        message: localization.onboardingCompletionError,
      );
    }
  }

  void _nextPage() {
    if (_isCompleting) return;

    if (_currentPage < _onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final size = MediaQuery.sizeOf(context);

    final isSmallScreen = size.width < 360;
    final isShortScreen = size.height < 700;

    final horizontalPadding = isSmallScreen ? 16.0 : 23.0;
    final titleSize = isSmallScreen ? 24.0 : AppStyles.s28;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _onboardingPages.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        final page = _onboardingPages[index];

                        final title = switch (page['title']) {
                          'onboardingTitle1' => localization.onboardingTitle1,
                          'onboardingTitle2' => localization.onboardingTitle2,
                          _ => '',
                        };

                        final description = switch (page['description']) {
                          'onboardingDescription1' =>
                            localization.onboardingDescription1,
                          'onboardingDescription2' =>
                            localization.onboardingDescription2,
                          _ => '',
                        };

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Image.asset(
                                page['image']!,
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            ),

                            SizedBox(height: isShortScreen ? 16 : 35),

                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: AppStyles.style(
                                locale: locale,
                                fontSize: titleSize,
                                fontWeight: AppStyles.extraBold,
                                color: colors.onSurface,
                              ),
                            ),

                            SizedBox(height: isShortScreen ? 12 : 24),

                            Text(
                              description,
                              textAlign: TextAlign.center,
                              style: AppStyles.style(
                                locale: locale,
                                fontSize: isSmallScreen
                                    ? AppStyles.s16
                                    : AppStyles.s19,
                                fontWeight: AppStyles.medium,
                                color: colors.onSurfaceVariant,
                              ),
                            ),

                            SizedBox(height: isShortScreen ? 16 : 35),
                          ],
                        );
                      },
                    ),
                  ),

                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingPages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 25 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? colors.primary
                              : colors.outline,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isShortScreen ? 20 : 30),

                  // Gradient button
                  AppGradientButton(
                    text: _currentPage == _onboardingPages.length - 1
                        ? localization.onboardingGetStarted
                        : localization.onboardingNext,
                    isLoading: _isCompleting,
                    onPressed: _nextPage,
                    locale: locale,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _isCompleting ? null : _skipOnboarding,
                      child: Text(
                        localization.onboardingSkip,
                        style: AppStyles.style(
                          locale: locale,
                          fontSize: AppStyles.s16,
                          fontWeight: AppStyles.medium,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
