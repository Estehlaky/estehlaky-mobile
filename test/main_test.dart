import 'dart:io';

import 'package:estehlaky/config/l10n/generated/app_localizations.dart';
import 'package:estehlaky/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  late Directory tempDirectory;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    tempDirectory = await Directory.systemTemp.createTemp('estehlaky_test_');

    Hive.init(tempDirectory.path);
    await Hive.openBox('settings');
  });

  tearDownAll(() async {
    await Hive.close();
    await tempDirectory.delete(recursive: true);
  });

  group('MyApp Widget Tests', () {
    testWidgets('should build the application successfully', (tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(MyApp), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);

      // Finish the splash navigation delay if the initial route is SplashView.
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('should configure MaterialApp.router correctly', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      expect(materialApp.routerConfig, isNotNull);
      expect(materialApp.debugShowCheckedModeBanner, isFalse);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('should configure application localization', (tester) async {
      await tester.pumpWidget(const MyApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      expect(materialApp.localizationsDelegates, isNotEmpty);
      expect(materialApp.supportedLocales, AppLocalizations.supportedLocales);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('should provide light and dark themes', (tester) async {
      await tester.pumpWidget(const MyApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, isNotNull);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });
  });
}
