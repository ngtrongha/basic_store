import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../data/services/auth_service.dart';
import '../presentation/screens/advanced_reports_screen.dart';
import '../presentation/screens/audit_log_screen.dart';
import '../presentation/screens/customers_list_screen.dart';
import '../presentation/screens/dashboard_screen.dart';
import '../presentation/screens/data_export_screen.dart';
import '../presentation/screens/inventory_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/order_history_screen.dart';
import '../presentation/screens/pos_screen.dart';
import '../presentation/screens/product_list_screen.dart';
import '../presentation/screens/reports_screen.dart';
import '../presentation/screens/scanner_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../presentation/screens/stock_transfers_screen.dart';
import '../presentation/screens/stores_screen.dart';
import '../presentation/screens/suppliers_screen.dart';
import '../presentation/screens/talker_logs_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({AuthGuard? authGuard}) : _authGuard = authGuard ?? AuthGuard();

  final AuthGuard _authGuard;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(
      page: DashboardRoute.page,
      path: '/',
      initial: true,
      guards: [_authGuard],
    ),
    AutoRoute(page: AuditLogRoute.page, path: '/audit', guards: [_authGuard]),
    AutoRoute(page: StoresRoute.page, path: '/stores', guards: [_authGuard]),
    AutoRoute(
      page: StockTransfersRoute.page,
      path: '/stock-transfers',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: ProductListRoute.page,
      path: '/products',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: CustomersListRoute.page,
      path: '/customers',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: InventoryRoute.page,
      path: '/inventory',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: SuppliersRoute.page,
      path: '/suppliers',
      guards: [_authGuard],
    ),
    AutoRoute(page: ReportsRoute.page, path: '/reports', guards: [_authGuard]),
    AutoRoute(
      page: AdvancedReportsRoute.page,
      path: '/advanced-reports',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: DataExportRoute.page,
      path: '/data-export',
      guards: [_authGuard],
    ),
    AutoRoute(page: PosRoute.page, path: '/pos', guards: [_authGuard]),
    AutoRoute(
      page: OrderHistoryRoute.page,
      path: '/orders',
      guards: [_authGuard],
    ),
    AutoRoute(
      page: SettingsRoute.page,
      path: '/settings',
      guards: [_authGuard],
    ),
    AutoRoute(page: ScannerRoute.page, path: '/scanner', guards: [_authGuard]),
    AutoRoute(page: TalkerLogsRoute.page, path: '/logs', guards: [_authGuard]),
  ];
}

class AuthGuard extends AutoRouteGuard {
  AuthGuard({AuthService? authService})
    : _authService = authService ?? AuthService();

  final AuthService _authService;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      resolver.next(true);
      return;
    }
    router.replaceAll([const LoginRoute()]);
    resolver.next(false);
  }
}
