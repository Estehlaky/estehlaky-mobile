import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/config/storage/settings_storage_service.dart';
import 'package:estehlaky/core/constant/app_router.dart';
import 'package:estehlaky/core/ui/app_theme.dart';
import 'package:estehlaky/core/ui/theme_cubit.dart';
import 'package:estehlaky/firebase_options.dart';
import 'package:estehlaky/shared/settings/language_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsStorage = SettingsStorageService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit(settingsStorage)),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                locale: locale,
                theme: AppTheme.light(locale: locale),
                darkTheme: AppTheme.dark(locale: locale),
                themeMode: themeMode,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}