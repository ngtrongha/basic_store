import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';

import '../data/db/app_database.dart';
import '../router/app_router.dart';

@module
abstract class AppModule {
  @lazySingleton
  Talker get talker => Talker();

  @lazySingleton
  AppRouter get appRouter => AppRouter();

  @lazySingleton
  AppDatabase get database => AppDatabase();
}
