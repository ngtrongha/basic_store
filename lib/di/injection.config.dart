// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:basic_store/data/db/app_database.dart' as _i378;
import 'package:basic_store/di/app_module.dart' as _i866;
import 'package:basic_store/router/app_router.dart' as _i111;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker/talker.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i993.Talker>(() => appModule.talker);
    gh.lazySingleton<_i111.AppRouter>(() => appModule.appRouter);
    gh.lazySingleton<_i378.AppDatabase>(() => appModule.database);
    return this;
  }
}

class _$AppModule extends _i866.AppModule {}
