import 'package:get_it/get_it.dart';

import '../../../features/coach/coach_profile/data/repo/get_coach_info_repo.dart';
import '../../../features/player/new_player/data/repo/create_player_repo.dart';
import '../../../features/player/new_player/data/repo/get_countries.dart';
import '../../../features/auth/data/repo/auth_repo.dart';
import '../../../features/auth/data/repo/check_role_repo.dart';
import '../../../features/coach/coach_home_page/data/repo/home_academy_repo.dart';
import '../../../features/coach/coach_home_page/data/repo/player_count_repo.dart';
import '../../../features/coach/coach_players/data/repo/get_coach_players.dart';
import '../../../features/player/new_player/data/repo/check_nid_repo.dart';
import '../../../features/player/new_player/data/repo/get_positions.dart';
import '../../../features/player/player_profile/data/repo/cancel_registration_repo.dart';
import '../../../features/player/player_profile/data/repo/get_player_profile_repo.dart';
import '../../../features/player/player_profile/data/repo/get_player_rating_repo.dart';
import '../../../features/player/player_profile/data/repo/player_history_repo.dart';
import '../../../features/player/player_rating/data/repo/save_certina_repo.dart';
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

  locator.registerLazySingleton(() => GetCountries(locator()));
  locator.registerLazySingleton(() => GetCoachPlayers(locator()));
  locator.registerLazySingleton(() => HomeAcademyRepo(locator()));
  locator.registerLazySingleton(() => PlayerCountRepo(locator()));
  locator.registerLazySingleton(() => GetPlayerProfileRepo(locator()));
  locator.registerLazySingleton(() => CheckNidRepo(locator()));
  locator.registerLazySingleton(() => GetPositions(locator()));
  locator.registerLazySingleton(() => CreatePlayerRepo(locator()));
  locator.registerLazySingleton(() => GetCoachInfoRepo(locator()));
  locator.registerLazySingleton(() => CancelRegistrationRepo(locator()));
  locator.registerLazySingleton(() => PlayerHistoryRepo(locator()));
  locator.registerLazySingleton(() => SaveEvaluationsRepo(locator()));
  locator.registerLazySingleton(() => GetPlayerRatingRepo(locator()));
}

void _registerServices() {
  locator.registerLazySingleton(() => GraphQLService());
  locator.registerLazySingleton(() => AuthServices());
  locator.registerLazySingleton(() => SupabaseServicesRepo());
  locator.registerLazySingleton<DataService>(
    () => SupabaseDataService(locator()),
  );
}
