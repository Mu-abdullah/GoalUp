import 'package:flutter/material.dart';

import '../../../../../../core/language/lang_keys.dart';
import '../player_item_info.dart';

class PlayerInfoSection extends StatelessWidget {
  const PlayerInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlayerItemInfo(
          icon: Icons.people,
          title: LangKeys.academy,
          value: 'Eagle Academy',
        ),
        // PlayerItemInfo(icon: Icons.numbers, title: 'Shirt Number', value: '10'),
        PlayerItemInfo(
          icon: Icons.flag,
          title: LangKeys.nationality,
          value: 'Egyptian',
        ),
        PlayerItemInfo(
          icon: Icons.location_on,
          title: LangKeys.position,
          value: "مهاجم",
        ),
      ],
    );
  }
}
