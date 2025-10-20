import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/services/database_service.dart';
import 'logic/cubits/pos_cubit/pos_cubit.dart';
import 'presentation/screens/product_list_screen.dart';
import 'presentation/screens/pos_screen.dart';
import 'presentation/screens/order_history_screen.dart';
import 'presentation/screens/settings_screen.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'presentation/screens/customers_list_screen.dart';
import 'presentation/screens/inventory_screen.dart';
import 'presentation/screens/suppliers_screen.dart';
import 'presentation/screens/reports_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/audit_log_screen.dart';
import 'presentation/screens/stores_screen.dart';
import 'presentation/screens/stock_transfers_screen.dart';
import 'presentation/screens/advanced_reports_screen.dart';
import 'presentation/screens/data_export_screen.dart';
import 'data/services/auth_service.dart';
import 'data/services/settings_service.dart';
import 'data/services/locale_service.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.init();
  await DatabaseService.instance.seedIfEmpty();

  // Check if user is logged in, otherwise redirect to login
  final authService = AuthService();
  final currentUser = await authService.getCurrentUser();
  final initialRoute = currentUser != null ? '/' : '/login';
  final dark = await SettingsService.getDarkModeEnabled();
  final locale = await LocaleService.getLocale();
  runApp(
    BasicStoreApp(initialRoute: initialRoute, darkMode: dark, locale: locale),
  );
}

class BasicStoreApp extends StatelessWidget {
  final String initialRoute;
  final bool darkMode;
  final Locale locale;
  const BasicStoreApp({
    super.key,
    required this.initialRoute,
    required this.darkMode,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => PosCubit())],
      child: MaterialApp(
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
        initialRoute: initialRoute,
        routes: {
          '/': (_) => const DashboardScreen(),
          '/login': (_) => const LoginScreen(),
          '/audit': (_) => const AuditLogScreen(),
          '/stores': (_) => const StoresScreen(),
          '/stock-transfers': (_) => const StockTransfersScreen(),
          '/products': (_) => const ProductListScreen(),
          '/customers': (_) => const CustomersListScreen(),
          '/inventory': (_) => const InventoryScreen(),
          '/suppliers': (_) => const SuppliersScreen(),
          '/reports': (_) => const ReportsScreen(),
          '/advanced-reports': (_) => const AdvancedReportsScreen(),
          '/data-export': (_) => const DataExportScreen(),
          '/pos': (_) => const PosScreen(),
          '/orders': (_) => const OrderHistoryScreen(),
          '/settings': (_) => const SettingsScreen(),
        },
      ),
    );
  }
}
