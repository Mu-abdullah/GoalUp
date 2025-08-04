import 'package:flutter/material.dart';

import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/widgets/app_text.dart';

class AppBarActionButton extends StatelessWidget {
  const AppBarActionButton({
    super.key,
    required this.title,
    required this.leading,
    this.trailing = Icons.arrow_forward_ios,
    required this.onTap,
    this.color = AppColors.black,
    this.translate = true,
  });
  final String title;
  final IconData leading;
  final IconData trailing;
  final VoidCallback onTap;
  final Color color;
  final bool translate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leading, color: color),
      title: AppText(title, isBold: true, color: color, tr: translate),
      trailing: Icon(trailing, color: color),
      onTap: onTap,
    );
  }
}
