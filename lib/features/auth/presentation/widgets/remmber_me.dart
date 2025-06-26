import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/language/lang_keys.dart';
import '../../../../core/style/color/app_color.dart';
import '../../../../core/style/widgets/app_text.dart';
import '../cubits/remmber_me_cubit/remmber_me_cubit.dart';

class RemmberMe extends StatefulWidget {
  const RemmberMe({super.key, this.color = AppColors.black});
  final Color color;
  @override
  State<RemmberMe> createState() => _RemmberMeState();
}

class _RemmberMeState extends State<RemmberMe> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemmberMeCubit(),
      child: BlocBuilder<RemmberMeCubit, RemmberMeState>(
        builder: (context, state) {
          var cubit = RemmberMeCubit.get(context);
          return Row(
            spacing: 10,
            children: [
              Checkbox(
                value: cubit.isRemmber,
                activeColor: widget.color,
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
        },
      ),
    );
  }
}
