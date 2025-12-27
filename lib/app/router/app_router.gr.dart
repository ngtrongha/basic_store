// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [BackupScreen]
class BackupRoute extends PageRouteInfo<void> {
  const BackupRoute({List<PageRouteInfo>? children})
    : super(BackupRoute.name, initialChildren: children);

  static const String name = 'BackupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BackupScreen();
    },
  );
}

/// generated route for
/// [CreateOrderScreen]
class CreateOrderRoute extends PageRouteInfo<void> {
  const CreateOrderRoute({List<PageRouteInfo>? children})
    : super(CreateOrderRoute.name, initialChildren: children);

  static const String name = 'CreateOrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateOrderScreen();
    },
  );
}

/// generated route for
/// [CustomerFormScreen]
class CustomerFormRoute extends PageRouteInfo<CustomerFormRouteArgs> {
  CustomerFormRoute({Key? key, int? customerId, List<PageRouteInfo>? children})
    : super(
        CustomerFormRoute.name,
        args: CustomerFormRouteArgs(key: key, customerId: customerId),
        initialChildren: children,
      );

  static const String name = 'CustomerFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerFormRouteArgs>(
        orElse: () => const CustomerFormRouteArgs(),
      );
      return CustomerFormScreen(key: args.key, customerId: args.customerId);
    },
  );
}

class CustomerFormRouteArgs {
  const CustomerFormRouteArgs({this.key, this.customerId});

  final Key? key;

  final int? customerId;

  @override
  String toString() {
    return 'CustomerFormRouteArgs{key: $key, customerId: $customerId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomerFormRouteArgs) return false;
    return key == other.key && customerId == other.customerId;
  }

  @override
  int get hashCode => key.hashCode ^ customerId.hashCode;
}

/// generated route for
/// [CustomerListScreen]
class CustomerListRoute extends PageRouteInfo<void> {
  const CustomerListRoute({List<PageRouteInfo>? children})
    : super(CustomerListRoute.name, initialChildren: children);

  static const String name = 'CustomerListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CustomerListScreen();
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
/// [DebtListScreen]
class DebtListRoute extends PageRouteInfo<void> {
  const DebtListRoute({List<PageRouteInfo>? children})
    : super(DebtListRoute.name, initialChildren: children);

  static const String name = 'DebtListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DebtListScreen();
    },
  );
}

/// generated route for
/// [ForgotPasswordScreen]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordScreen();
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
/// [OtpVerificationScreen]
class OtpVerificationRoute extends PageRouteInfo<OtpVerificationRouteArgs> {
  OtpVerificationRoute({
    Key? key,
    String? email,
    String? phone,
    List<PageRouteInfo>? children,
  }) : super(
         OtpVerificationRoute.name,
         args: OtpVerificationRouteArgs(key: key, email: email, phone: phone),
         initialChildren: children,
       );

  static const String name = 'OtpVerificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpVerificationRouteArgs>(
        orElse: () => const OtpVerificationRouteArgs(),
      );
      return OtpVerificationScreen(
        key: args.key,
        email: args.email,
        phone: args.phone,
      );
    },
  );
}

class OtpVerificationRouteArgs {
  const OtpVerificationRouteArgs({this.key, this.email, this.phone});

  final Key? key;

  final String? email;

  final String? phone;

  @override
  String toString() {
    return 'OtpVerificationRouteArgs{key: $key, email: $email, phone: $phone}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OtpVerificationRouteArgs) return false;
    return key == other.key && email == other.email && phone == other.phone;
  }

  @override
  int get hashCode => key.hashCode ^ email.hashCode ^ phone.hashCode;
}

/// generated route for
/// [PaymentSuccessScreen]
class PaymentSuccessRoute extends PageRouteInfo<void> {
  const PaymentSuccessRoute({List<PageRouteInfo>? children})
    : super(PaymentSuccessRoute.name, initialChildren: children);

  static const String name = 'PaymentSuccessRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PaymentSuccessScreen();
    },
  );
}

/// generated route for
/// [ProductFormScreen]
class ProductFormRoute extends PageRouteInfo<ProductFormRouteArgs> {
  ProductFormRoute({Key? key, int? productId, List<PageRouteInfo>? children})
    : super(
        ProductFormRoute.name,
        args: ProductFormRouteArgs(key: key, productId: productId),
        initialChildren: children,
      );

  static const String name = 'ProductFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductFormRouteArgs>(
        orElse: () => const ProductFormRouteArgs(),
      );
      return ProductFormScreen(key: args.key, productId: args.productId);
    },
  );
}

class ProductFormRouteArgs {
  const ProductFormRouteArgs({this.key, this.productId});

  final Key? key;

  final int? productId;

  @override
  String toString() {
    return 'ProductFormRouteArgs{key: $key, productId: $productId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductFormRouteArgs) return false;
    return key == other.key && productId == other.productId;
  }

  @override
  int get hashCode => key.hashCode ^ productId.hashCode;
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
/// [QrPaymentScreen]
class QrPaymentRoute extends PageRouteInfo<void> {
  const QrPaymentRoute({List<PageRouteInfo>? children})
    : super(QrPaymentRoute.name, initialChildren: children);

  static const String name = 'QrPaymentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const QrPaymentScreen();
    },
  );
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterScreen();
    },
  );
}
