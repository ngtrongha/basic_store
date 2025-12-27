import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/auth_screens.dart';
import '../../features/customers/presentation/screens/customer_screens.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/debts/presentation/screens/debt_screens.dart';
import '../../features/orders/presentation/screens/order_screens.dart';
import '../../features/payments/presentation/screens/payment_screens.dart';
import '../../features/products/presentation/screens/product_screens.dart';
import '../../features/settings/presentation/screens/backup_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    // Auth routes
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: OtpVerificationRoute.page),

    // Main app routes
    AutoRoute(page: DashboardRoute.page),
    AutoRoute(page: ProductListRoute.page),
    AutoRoute(page: ProductFormRoute.page),
    AutoRoute(page: CustomerListRoute.page),
    AutoRoute(page: CustomerFormRoute.page),
    AutoRoute(page: CreateOrderRoute.page),
    AutoRoute(page: DebtListRoute.page),
    AutoRoute(page: QrPaymentRoute.page),
    AutoRoute(page: PaymentSuccessRoute.page),
    AutoRoute(page: BackupRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
