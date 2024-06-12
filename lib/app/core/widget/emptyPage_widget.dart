import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../values/app_colors.dart';
import '../values/app_images.dart';

class EmptyPageWidget extends GetView{

  final String iconData;
  final String? message;
  AppLocalizations get appLocalization => AppLocalizations.of(Get.context!)!;

  const EmptyPageWidget({Key? key, this.message, this.iconData = AppImages.emptyIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height/2, width: Get.width,
      child: Stack(
        children: [
          Positioned(
            top: 80, left: 16,right: 16,
              child: Column(
                children: [
                  Lottie.asset(iconData,height: 200,width: 200, repeat: false),
                  Text( message ?? appLocalization.no_data, style: const TextStyle(color: AppColors.gray),)
                ],
              )
          )
        ],
      ),
    );
  }

}