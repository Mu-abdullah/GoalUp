import 'package:flutter/material.dart';
import 'package:sport/features/auth/presentation/refactor/check_role.dart';

import '../../features/admin/admin_academies/presentation/views/admin_academies.dart';
import '../../features/admin/admin_countries/presentation/views/admin_countries.dart';
import '../../features/admin/admin_home/presentation/views/admin_home.dart';
import '../../features/auth/presentation/views/auth_screen.dart';
import '../../features/auth/presentation/views/user_auth_screen.dart';
import '../../features/coach/coach_home_screen/presentation/views/coach_home_screen.dart';
import '../../features/player/new_player/presentation/views/new_player_nid_screen.dart';
import '../../features/player/new_player/presentation/views/new_player_screen.dart';
import '../../features/player/player_profile/presentation/views/player_profile.dart';
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

    case RoutesNames.adminCountries:
      return BaseRoute(page: const AdminCountries());

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
    /////////
    /////////[player feature routes]////////////
    /////////
    case RoutesNames.playerProfile:
      return BaseRoute(
        page: PlayerProfile(
          isAdmin: args?['isAdmin'] ?? false,
          playerId: args?['playerId'],
        ),
      );
    case RoutesNames.newPlayer:
      return BaseRoute(
        page: NewPlayerScreen(nid: args?['nid'], player: args?['player']),
      );

    case RoutesNames.newPlayerNidScreen:
      return BaseRoute(page: NewPlayerNidScreen());
    default:
      return BaseRoute(page: const MaterialApp());
  }
}
