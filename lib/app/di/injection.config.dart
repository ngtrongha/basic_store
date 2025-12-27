// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/database/app_database.dart' as _i50;
import '../../core/services/backup_service.dart' as _i615;
import '../../features/auth/data/services/auth_service.dart' as _i449;
import '../../features/customers/data/dao/customer_dao.dart' as _i908;
import '../../features/debts/data/dao/debt_dao.dart' as _i837;
import '../../features/orders/data/dao/order_dao.dart' as _i204;
import '../../features/products/data/dao/product_dao.dart' as _i71;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i615.BackupService>(
      () => _i615.BackupService(gh<_i50.AppDatabase>()),
    );
    gh.lazySingleton<_i449.AuthService>(
      () => _i449.AuthService(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i908.CustomerDao>(
      () => _i908.CustomerDao(gh<_i50.AppDatabase>()),
    );
    gh.lazySingleton<_i837.DebtDao>(
      () => _i837.DebtDao(gh<_i50.AppDatabase>()),
    );
    gh.lazySingleton<_i204.OrderDao>(
      () => _i204.OrderDao(gh<_i50.AppDatabase>()),
    );
    gh.lazySingleton<_i71.ProductDao>(
      () => _i71.ProductDao(gh<_i50.AppDatabase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
