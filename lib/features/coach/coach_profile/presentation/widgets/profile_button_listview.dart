import 'package:flutter/material.dart';

import '../../data/repo/profile_btns_list.dart';
import 'profile_button.dart';

class ProfileButtonsListView extends StatelessWidget {
  const ProfileButtonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    var btns = ProfileBtnsList.profileBtnsList(context);
    return Expanded(
      child: ListView.builder(
        itemCount: btns.length,
        itemBuilder: (context, index) {
          var btn = btns[index];
          return ProfileButton(btn: btn);
        },
      ),
    );
  }
}
