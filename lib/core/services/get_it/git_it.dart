import 'package:get_it/get_it.dart';

import '../../../features/admin/admin_countries/data/repo/admin_get_countries.dart';
import '../../../features/auth/data/repo/auth_repo.dart';
import '../../../features/auth/data/repo/check_role_repo.dart';
import '../../../features/coach/coach_players/data/repo/get_coach_players.dart';
import '../graph_ql/graph_ql.dart';
import '../supabase/auth_service/auth_services.dart';
import '../supabase/data_base_services.dart';
import '../supabase/supabase_services_repo.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  _registerRepositories();
  _registerServices();
}

void _registerRepositories() {
  /// [AuthRepo] is responsible for handling authentication-related operations.
  locator.registerLazySingleton(() => AuthRepo(locator()));
  locator.registerLazySingleton(() => CheckRoleRepo(locator()));

  locator.registerLazySingleton(() => AdminGetCountries(locator()));
  locator.registerLazySingleton(() => GetCoachPlayers(locator()));
}

void _registerServices() {
  locator.registerLazySingleton(() => GraphQLService());
  locator.registerLazySingleton(() => AuthServices());
  locator.registerLazySingleton(() => SupabaseServicesRepo());
  locator.registerLazySingleton<DataService>(
    () => SupabaseDataService(locator()),
  );
}
