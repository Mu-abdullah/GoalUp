import 'package:flutter/material.dart';

import '../../features/admin/admin_academies/presentation/views/admin_academies.dart';
import '../../features/admin/admin_home/presentation/views/admin_home.dart';
import '../../features/auth/presentation/refactor/check_role.dart';
import '../../features/auth/presentation/views/auth_screen.dart';
import '../../features/auth/presentation/views/user_auth_screen.dart';
import '../../features/coach/coach_home_screen/presentation/views/coach_home_screen.dart';
import '../../features/coach/coach_players/data/model/get_players_model.dart';
import '../../features/coach/coach_players/presentation/refactor/search_screen.dart';
import '../../features/player/new_player/presentation/views/new_player_nid_screen.dart';
import '../../features/player/new_player/presentation/views/new_player_screen.dart';
import '../../features/player/player_profile/presentation/views/player_profile.dart';
import '../../features/player/player_rating/presentation/view/player_rating_screen.dart';
import '../app/image/image_preview.dart';
import '../app/language/language_screen.dart';
import '../app/no_internet/no_internet_screen.dart';
import 'base_routes.dart';
import 'routes_name.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final args = settings.arguments as Map<String, dynamic>?;

  switch (settings.name) {
    ///////// basic routes
    case RoutesNames.imagePreview:
      return BaseRoute(
        page: PreviewImage(
          imageUrl: args?['imageUrl'] as String?,
          title: args?['title'] as String?,
          imagesList:
              (args?['imagesList'] as List?)?.whereType<String>().toList(),
        ),
      );

    case RoutesNames.language:
      return BaseRoute(page: LanguageScreen());

    case RoutesNames.noInternet:
      return BaseRoute(page: NoInternetScreen());

    case RoutesNames.auth:
      return BaseRoute(page: const AuthScreen());
    case RoutesNames.userAuthScreen:
      return BaseRoute(page: const UserAuthScreen());

    case RoutesNames.checkRole:
      return BaseRoute(page: CheckRole(uid: args?['uid']));

    /////////
    /////////[admin feature routes]////////////
    /////////

    case RoutesNames.adminHome:
      return BaseRoute(page: const AdminHome());

    case RoutesNames.adminAcademies:
      return BaseRoute(page: const AdminAcademies());

    /////////
    /////////[coach feature routes]////////////
    /////////
    case RoutesNames.coachHome:
      // Assuming you have a coach home screen, you can add it here.
      return BaseRoute(
        page: CoachHomeScreen(isAdmin: args?['isAdmin'] ?? false),
      ); // Placeholder for coach home
    case RoutesNames.searchScreen:
      // Assuming you have a coach home screen, you can add it here.
      return BaseRoute(
        page: SearchScreen(
          search: args?['search'] ?? '',
          players: args?['players'] ?? List<GetPlayersModel>.empty(),
        ),
      ); // Placeholder for coach home
    /////////
    /////////[player feature routes]////////////
    /////////
    case RoutesNames.playerProfile:
      return BaseRoute(
        page: PlayerProfile(
          isCoach: args?['isCoach'] ?? false,
          playerId: args?['playerId'] ?? '',
          enrollmentDate: args?['enrollmentDate'] ?? '',
        ),
      );
    case RoutesNames.newPlayer:
      return BaseRoute(
        page: NewPlayerScreen(nid: args?['nid'], player: args?['player']),
      );

    case RoutesNames.playerRatingScreen:
      return BaseRoute(page: PlayerRatingScreen());

    case RoutesNames.newPlayerNidScreen:
      return BaseRoute(page: NewPlayerNidScreen());
    default:
      return BaseRoute(page: const MaterialApp());
  }
}
