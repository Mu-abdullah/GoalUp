import 'package:flutter/material.dart';
import 'package:sport/core/extextions/extentions.dart';

import 'package:hugeicons/hugeicons.dart';

import 'package:lottie/lottie.dart';

import '../../language/lang_keys.dart';
import '../../style/color/app_color.dart';
import '../../style/statics/image_test.dart';
import '../../style/widgets/app_button.dart';
import '../../style/custom_widgets/custom_snack_bar.dart';
import 'connection_controller/connection_controller.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          Lottie.asset(AppJson.noInternet),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppButton(
              onTap: () async {
                await ConnectionController.instance.checkConnection();
                if (ConnectionController.instance.isConnected.value == true) {
                  if (context.mounted) {
                    CustomSnackbar.showTopSnackBar(
                      context,
                      message: context.tr(LangKeys.noInternet),
                      backgroundColor: Colors.green,
                      icon: HugeIcons.strokeRoundedConnect,
                    );
                  }
                } else {
                  if (context.mounted) {
                    CustomSnackbar.showTopSnackBar(
                      context,
                      message: context.tr(LangKeys.noInternet),
                      backgroundColor: AppColors.red,
                      icon: HugeIcons.strokeRoundedWifiError01,
                    );
                  }
                }
              },
              text: LangKeys.tryToConnect,
            ),
          ),
        ],
      ),
    );
  }
}
