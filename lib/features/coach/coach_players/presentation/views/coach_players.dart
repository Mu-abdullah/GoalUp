import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/coach_players_cubit/coach_players_cubit.dart';

class CoachPlayers extends StatelessWidget {
  const CoachPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachPlayersCubit, CoachPlayersState>(
      builder: (context, state) {
        return Column(children: []);
      },
    );
  }
}
