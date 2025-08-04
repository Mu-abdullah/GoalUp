import 'package:flutter/material.dart';

import '../../../../../core/language/lang_keys.dart';
import '../cubits/update_cubit/update_cubit.dart';
import 'edit_player_form_field.dart';

class EditPlayerFrom extends StatelessWidget {
  const EditPlayerFrom({super.key, required this.cubit});
  final UpdateCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        EditPlayerFromField(
          controller: cubit.academy,
          lable: LangKeys.academy,
          type: TextInputType.name,
          enabled: false,
        ),
        EditPlayerFromField(
          controller: cubit.id,
          lable: LangKeys.id,
          type: TextInputType.name,
          enabled: false,
        ),

        EditPlayerFromField(
          controller: cubit.name,
          lable: LangKeys.name,
          type: TextInputType.name,
        ),
        EditPlayerFromField(
          controller: cubit.phone,
          lable: LangKeys.phone,
          type: TextInputType.number,
          isNumber: true,
        ),
        EditPlayerFromField(
          controller: cubit.nidController,
          lable: LangKeys.nid,
          type: TextInputType.number,
        ),
      ],
    );
  }
}
