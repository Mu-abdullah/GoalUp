import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/services/get_it/git_it.dart';
import '../../../../../core/services/shared_pref/pref_keys.dart';
import '../../../../../core/services/shared_pref/shared_pref.dart';
import '../../../../../core/style/custom_widgets/custom_bottom_sheet.dart';
import '../../data/repo/get_player_profile_repo.dart';
import '../../data/repo/player_history_repo.dart';
import '../cubits/get_player_rating_cubit/get_player_rating_cubit.dart';
import '../cubits/player_history_cubit/player_history_cubit.dart';
import '../cubits/player_profile_cubit/player_profile_cubit.dart';
import '../refactor/player_profile_body.dart';
import '../widgets/player_app_bar/player_profile_app_bar.dart';
import '../widgets/remmber_player.dart';

class PlayerProfile extends StatefulWidget {
  const PlayerProfile({super.key, this.isCoach = false, this.playerId});

  final bool isCoach;
  final String? playerId;

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  String? _playerId;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  Future<void> initPlayer() async {
    String? id = widget.playerId;

    if (!widget.isCoach) {
      // لو مش جاي من البراميتر، نحاول نجيبه من SharedPref
      if (id == null || id.isEmpty) {
        id = await SharedPref.getData(key: PrefKeys.playerID);
      }

      // لو المستخدم مش مفعل rememberPlayer، نعرض البوتوم شيت
      final isRemembered = await SharedPref.getData(
        key: PrefKeys.rememberPlayer,
      );
      if (isRemembered != true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showLanguageBottomSheet(id ?? '');
        });
      }
    }

    if (id != null && id.isNotEmpty) {
      setState(() {
        _playerId = id;
      });
    } else {
      debugPrint("❌ لا يوجد playerId");
    }
  }

  Future<void> _showLanguageBottomSheet(String playerId) async {
    await customShowBottomSheet(
      context: context,
      widget: RemmberPlayer(playerId: playerId),
      title: LangKeys.doYouWantToRememberYou,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_playerId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    var lac = locator<GetPlayerProfileRepo>();
    var history = locator<PlayerHistoryRepo>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  PlayerProfileCubit(lac, isCoach: widget.isCoach)
                    ..getPlayerProfileById(_playerId!),
        ),
        BlocProvider(
          create:
              (context) =>
                  PlayerHistoryCubit(history)..getPlayerHistory(_playerId!),
        ),
        BlocProvider(
          create:
              (context) => GetPlayerRatingCubit()..getPlayerRating(_playerId!),
        ),
      ],
      child: Scaffold(
        appBar: PlayerProfileAppBar(isPlayer: widget.isCoach),
        body: const PlayerProfileBody(),
      ),
    );
  }
}

