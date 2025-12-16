import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'data/services/database_service.dart';
import 'data/services/settings_service.dart';
import 'data/services/locale_service.dart';
import 'logging/talker.dart';
import 'l10n/app_localizations.dart';
import 'router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.init();
  await DatabaseService.instance.seedIfEmpty();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    talker.handle(details.exception, details.stack, 'FlutterError');
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'PlatformDispatcher');
    return true;
  };

  final dark = await SettingsService.getDarkModeEnabled();
  final locale = await LocaleService.getLocale();
  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver(talker: talker)],
      child: BasicStoreApp(darkMode: dark, locale: locale),
    ),
  );
}

class BasicStoreApp extends StatelessWidget {
  final bool darkMode;
  final Locale locale;
  BasicStoreApp({super.key, required this.darkMode, required this.locale});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(
        navigatorObservers: () => [TalkerRouteObserver(talker)],
      ),
      title: 'Basic Store',
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', ''), Locale('vi', '')],
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
