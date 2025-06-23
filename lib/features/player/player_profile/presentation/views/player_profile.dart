import 'package:flutter/material.dart';

import '../refactor/player_profile_body.dart';

class PlayerProfile extends StatelessWidget {
  const PlayerProfile({super.key, this.isAdmin = false, this.playerId});
  final bool isAdmin;
  final String? playerId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PlayerProfileBody(isAdmin: isAdmin));
  }
}
