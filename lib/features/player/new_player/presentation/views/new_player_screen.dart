import 'package:flutter/material.dart';

import '../../../../../core/language/lang_keys.dart';
import '../../../../../core/style/custom_widgets/custom_app_bar.dart';

class NewPlayerScreen extends StatelessWidget {
  const NewPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LangKeys.newPlayer),
      body: Column(children: []),
    );
  }
}
