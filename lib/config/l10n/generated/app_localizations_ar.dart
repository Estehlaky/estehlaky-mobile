// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'استهلاكي';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get loginRequired => 'تسجيل الدخول مطلوب';

  @override
  String get loginRequiredMessage => 'يرجى تسجيل الدخول لاستخدام هذه الميزة.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get appTagline => 'اعرف .. خطط .. وفر';

  @override
  String get onboardingTitle1 => 'تابع استهلاكك بدقة';

  @override
  String get onboardingDescription1 => 'اعرف رصيد الكهرباء واستهلاكك في أي وقت';

  @override
  String get onboardingTitle2 => 'تحكم في استهلاكك';

  @override
  String get onboardingDescription2 =>
      'راقب استهلاكك اليومي واكتشف طرق التوفير';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingGetStarted => 'ابدأ الآن';

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingCompletionError => 'حدث خطأ ما. حاول مرة أخرى.';
}
