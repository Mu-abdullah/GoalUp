import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sport/core/extextions/extentions.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_text.dart';
import '../../../../../core/style/widgets/app_text_form_felid.dart';
import '../../data/model/get_players_model.dart';
import '../widgets/coach_player_listview_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.search, required this.players});
  final List<GetPlayersModel> players;
  final String? search;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController controller;
  late List<GetPlayersModel> _filteredPlayers;

  @override
  void initState() {
    controller = TextEditingController(text: widget.search ?? '');
    _filteredPlayers = widget.players;
    controller.addListener(_filterPlayers);
    super.initState();
  }

  void _filterPlayers() {
    final query = controller.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredPlayers = widget.players;
      } else {
        _filteredPlayers =
            widget.players.where((player) {
              return player.player!.contains(query) == true;
            }).toList();
      }
    });
  }

  @override
  void dispose() {
    controller.removeListener(_filterPlayers);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LangKeys.search),
      body: Padding(
        padding: AppPadding.symmetric(),
        child: Column(
          children: [
            // Search field
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AppTextFormField(
                      controller: controller,
                      type: TextInputType.text,
                      label: LangKeys.name,
                      hint: LangKeys.name,
                      prefix: const Icon(HugeIcons.strokeRoundedSearch01),
                      validate: (_) => null,
                      onChange: (_) => _filterPlayers(),
                    ),
                  ),
                ),
                controller.text.isNotEmpty
                    ? InkWell(
                      onTap: () => controller.clear(),
                      child: Icon(HugeIcons.strokeRoundedCancelCircle),
                    )
                    : const SizedBox(),
              ],
            ),

            // Results count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    '${context.tr(LangKeys.player)} (${_filteredPlayers.length})',
                    fontSize: 14,
                    tr: false,
                    color: Colors.grey,
                  ),
                  if (controller.text.isNotEmpty)
                    TextButton(
                      onPressed: () => controller.clear(),
                      child: AppText(LangKeys.clear),
                    ),
                ],
              ),
            ),

            // Players list
            Expanded(
              child:
                  _filteredPlayers.isEmpty
                      ? Center(child: AppText(LangKeys.noDataFound))
                      : ListView.builder(
                        itemCount: _filteredPlayers.length,
                        itemBuilder: (context, index) {
                          final player = _filteredPlayers[index];
                          return CoachPlayerItem(player: player);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
