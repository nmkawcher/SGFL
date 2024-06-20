import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../core/base/custom_view.dart';
import '../../core/values/app_colors.dart';
import '../../core/values/app_images.dart';
import 'splash_controller.dart';

class SplashScreenView extends CustomView<SplashScreenController> {

  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget pageScaffold(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context),
      body: SafeArea(top: false, child: body(context)),
    );
  }

  Widget body(BuildContext context) {
    final double bottomHeight = Get.height* 0.04;

    return Container(
      color: AppColors.primary15,
      child: Stack(
        children: [
          Image.asset(AppImages.bgShep,fit: BoxFit.cover,height: Get.height,width: Get.width),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.logo,height: 200,width: 200),
              ],
            ),
          ),
          Positioned(bottom:bottomHeight, left: 0, right: 0,
           child:  Column(
            children: [
              Text(appLocalization.copyright1,textAlign: TextAlign.center,style: const TextStyle(fontSize: 12, color: AppColors.colorDark)),
            ],
          ))
        ],
      ),
    );
  }
}
