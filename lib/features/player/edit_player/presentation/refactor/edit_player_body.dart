import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/color/app_color.dart';
import '../../../../../core/style/statics/app_statics.dart';
import '../../../../../core/style/statics/image_test.dart';
import '../cubits/update_cubit/update_cubit.dart';

class EditPlayerScreenBody extends StatelessWidget {
  const EditPlayerScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateCubit, UpdateState>(
      builder: (context, state) {
        var cubit = UpdateCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Statics.defaultSize * 2.5,
                width: Statics.defaultSize * 2.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.black, width: 2),
                  image: DecorationImage(
                    image:
                        cubit.player.image != null &&
                                cubit.player.image!.isNotEmpty
                            ? NetworkImage(cubit.player.image!)
                            : AssetImage(AppImages.player),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
