import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/language/lang_keys.dart';
import '../../../../core/style/color/app_color.dart';
import '../../../../core/style/widgets/app_text.dart';
import '../cubits/auth_cubit/auth_cubit.dart';

class RemmberMe extends StatefulWidget {
  const RemmberMe({super.key});

  @override
  State<RemmberMe> createState() => _RemmberMeState();
}

class _RemmberMeState extends State<RemmberMe> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Row(
      spacing: 10,
      children: [
        Checkbox(
          value: cubit.isRemmber,
          activeColor: AppColors.black,
          shape: const CircleBorder(),
          checkColor: AppColors.white,
          onChanged: (v) {
            setState(() {
              cubit.isRemmber = v!;
            });
          },
        ),
        AppText(LangKeys.remeberMe),
      ],
    );
  }
}
