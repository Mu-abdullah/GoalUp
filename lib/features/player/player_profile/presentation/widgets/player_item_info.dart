import 'package:flutter/material.dart';

import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/widgets/app_text.dart';

class PlayerItemInfo extends StatelessWidget {
  const PlayerItemInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.onTab,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTab;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Padding(
        padding: AppPadding.symmetric(horizontal: 0, vertical: 6),
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
      ),
    );
  }
}
