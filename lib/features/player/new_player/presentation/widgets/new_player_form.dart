import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../core/functions/select_data.dart';
import '../../../../../core/language/lang_keys.dart';
import '../cubits/new_player_cubit/new_player_cubit.dart';
import 'new_player_text_form.dart';

class NewPlayerForm extends StatelessWidget {
  const NewPlayerForm({super.key, required this.cubit});

  final NewPlayerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        spacing: 10,
        children: [
          NewPlayerTextForm(
            controller: cubit.id,
            lable: LangKeys.id,
            icon: HugeIcons.strokeRoundedFootballPitch,
            type: TextInputType.text,
            enabled: false,
          ),
          NewPlayerTextForm(
            controller: cubit.academy,
            lable: LangKeys.academy,
            icon: HugeIcons.strokeRoundedFootballPitch,
            type: TextInputType.text,
            enabled: false,
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: NewPlayerTextForm(
                  controller: cubit.firstName,
                  lable: LangKeys.firstName,
                  icon: HugeIcons.strokeRoundedUser,
                  type: TextInputType.name,
                  onChange: () {
                    cubit.romanFirstName = cubit.romanized(
                      cubit.firstName.text,
                    );
                  },
                ),
              ),
              Expanded(
                child: NewPlayerTextForm(
                  controller: cubit.lastName,
                  lable: LangKeys.lastName,
                  icon: HugeIcons.strokeRoundedUser,
                  type: TextInputType.name,
                  onChange: () {
                    cubit.romanLastName = cubit.romanized(cubit.lastName.text);
                  },
                ),
              ),
            ],
          ),
          NewPlayerTextForm(
            controller: cubit.nidController,
            lable: LangKeys.nid,
            icon: HugeIcons.strokeRoundedCreditCard,
            type: TextInputType.number,
          ),
          NewPlayerTextForm(
            controller: cubit.phone,
            lable: LangKeys.phone,
            icon: HugeIcons.strokeRoundedSmartPhone01,
            type: TextInputType.number,
          ),
          NewPlayerTextForm(
            controller: cubit.birth,
            lable: LangKeys.birthDate,
            icon: HugeIcons.strokeRoundedBirthdayCake,
            type: TextInputType.text,
            onTap: () {
              selectData(
                context: context,
                controller: cubit.birth,
                content: LangKeys.birthDate,
              );
            },
          ),
          NewPlayerTextForm(
            controller: cubit.enroll,
            lable: LangKeys.enrollmentDate,
            icon: HugeIcons.strokeRoundedCalendar01,
            type: TextInputType.text,
            onTap: () {
              selectData(
                context: context,
                controller: cubit.enroll,
                content: LangKeys.enrollmentDate,
              );
            },
          ),
        ],
      ),
    );
  }
}
