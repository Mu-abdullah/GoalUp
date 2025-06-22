import 'package:flutter/material.dart';

import '../../../../../core/style/widgets/app_text.dart';

class PlayerItemInfo extends StatelessWidget {
  const PlayerItemInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[900],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: Colors.amber),
          ),
          const SizedBox(width: 15),
          Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(title, fontSize: 12, color: Colors.grey[500]),

              AppText(
                value,
                translate: false,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
