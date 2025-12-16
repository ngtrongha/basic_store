// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AdvancedReportsScreen]
class AdvancedReportsRoute extends PageRouteInfo<void> {
  const AdvancedReportsRoute({List<PageRouteInfo>? children})
    : super(AdvancedReportsRoute.name, initialChildren: children);

  static const String name = 'AdvancedReportsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdvancedReportsScreen();
    },
  );
}

/// generated route for
/// [AuditLogScreen]
class AuditLogRoute extends PageRouteInfo<void> {
  const AuditLogRoute({List<PageRouteInfo>? children})
    : super(AuditLogRoute.name, initialChildren: children);

  static const String name = 'AuditLogRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuditLogScreen();
    },
  );
}

/// generated route for
/// [CustomersListScreen]
class CustomersListRoute extends PageRouteInfo<void> {
  const CustomersListRoute({List<PageRouteInfo>? children})
    : super(CustomersListRoute.name, initialChildren: children);

  static const String name = 'CustomersListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CustomersListScreen();
    },
  );
}

/// generated route for
/// [DashboardScreen]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardScreen();
    },
  );
}

/// generated route for
/// [DataExportScreen]
class DataExportRoute extends PageRouteInfo<void> {
  const DataExportRoute({List<PageRouteInfo>? children})
    : super(DataExportRoute.name, initialChildren: children);

  static const String name = 'DataExportRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DataExportScreen();
    },
  );
}

/// generated route for
/// [InventoryScreen]
class InventoryRoute extends PageRouteInfo<void> {
  const InventoryRoute({List<PageRouteInfo>? children})
    : super(InventoryRoute.name, initialChildren: children);

  static const String name = 'InventoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InventoryScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [OrderHistoryScreen]
class OrderHistoryRoute extends PageRouteInfo<void> {
  const OrderHistoryRoute({List<PageRouteInfo>? children})
    : super(OrderHistoryRoute.name, initialChildren: children);

  static const String name = 'OrderHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrderHistoryScreen();
    },
  );
}

/// generated route for
/// [PosScreen]
class PosRoute extends PageRouteInfo<void> {
  const PosRoute({List<PageRouteInfo>? children})
    : super(PosRoute.name, initialChildren: children);

  static const String name = 'PosRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PosScreen();
    },
  );
}

/// generated route for
/// [ProductListScreen]
class ProductListRoute extends PageRouteInfo<void> {
  const ProductListRoute({List<PageRouteInfo>? children})
    : super(ProductListRoute.name, initialChildren: children);

  static const String name = 'ProductListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProductListScreen();
    },
  );
}

/// generated route for
/// [ReportsScreen]
class ReportsRoute extends PageRouteInfo<void> {
  const ReportsRoute({List<PageRouteInfo>? children})
    : super(ReportsRoute.name, initialChildren: children);

  static const String name = 'ReportsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReportsScreen();
    },
  );
}

/// generated route for
/// [ScannerScreen]
class ScannerRoute extends PageRouteInfo<void> {
  const ScannerRoute({List<PageRouteInfo>? children})
    : super(ScannerRoute.name, initialChildren: children);

  static const String name = 'ScannerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ScannerScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}

/// generated route for
/// [StockTransfersScreen]
class StockTransfersRoute extends PageRouteInfo<StockTransfersRouteArgs> {
  StockTransfersRoute({Key? key, int? storeId, List<PageRouteInfo>? children})
    : super(
        StockTransfersRoute.name,
        args: StockTransfersRouteArgs(key: key, storeId: storeId),
        initialChildren: children,
      );

  static const String name = 'StockTransfersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StockTransfersRouteArgs>(
        orElse: () => const StockTransfersRouteArgs(),
      );
      return StockTransfersScreen(key: args.key, storeId: args.storeId);
    },
  );
}

class StockTransfersRouteArgs {
  const StockTransfersRouteArgs({this.key, this.storeId});

  final Key? key;

  final int? storeId;

  @override
  String toString() {
    return 'StockTransfersRouteArgs{key: $key, storeId: $storeId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! StockTransfersRouteArgs) return false;
    return key == other.key && storeId == other.storeId;
  }

  @override
  int get hashCode => key.hashCode ^ storeId.hashCode;
}

/// generated route for
/// [StoresScreen]
class StoresRoute extends PageRouteInfo<void> {
  const StoresRoute({List<PageRouteInfo>? children})
    : super(StoresRoute.name, initialChildren: children);

  static const String name = 'StoresRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StoresScreen();
    },
  );
}

/// generated route for
/// [SuppliersScreen]
class SuppliersRoute extends PageRouteInfo<void> {
  const SuppliersRoute({List<PageRouteInfo>? children})
    : super(SuppliersRoute.name, initialChildren: children);

  static const String name = 'SuppliersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SuppliersScreen();
    },
  );
}

/// generated route for
/// [TalkerLogsScreen]
class TalkerLogsRoute extends PageRouteInfo<void> {
  const TalkerLogsRoute({List<PageRouteInfo>? children})
    : super(TalkerLogsRoute.name, initialChildren: children);

  static const String name = 'TalkerLogsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TalkerLogsScreen();
    },
  );
}
