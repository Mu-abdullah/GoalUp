import 'package:flutter/material.dart';

import '../../../../../core/style/widgets/app_text.dart';

class PlayerName extends StatelessWidget {
  const PlayerName({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AppText(name, translate: false, fontSize: 28, maxLines: 3),
        ),
      ],
    );
  }
}
