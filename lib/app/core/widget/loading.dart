import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../values/app_images.dart';
import '/app/core/values/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  AppLocalizations? get appLocalization => AppLocalizations.of(Get.context!);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:   Text('SGFL',style: const TextStyle(color: Colors.white)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.accentPrimary,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Lottie.asset(AppImages.loading)),
          Text(appLocalization!.gettingEverythingReady,style: const TextStyle(fontSize: 16),)
        ],
      ),
    );
  }
}
