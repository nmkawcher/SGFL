
import 'dart:ui';

import 'package:get/get.dart';
import '../../data/local/preference/preference_manager.dart';
import '/app/core/base/base_controller.dart';
import '../../routes/app_pages.dart';

class SplashScreenController extends BaseController {

  @override
  void onReady() {
    _initialScreen();
    super.onReady();
  }

  _initialScreen()async{
    var token = await preference.getString(PreferenceManager.keyRefreshToken);
    var language = await preference.getString(PreferenceManager.keyLanguage);
    Get.updateLocale(language == 'EN' || language.isEmpty ? const Locale('en') : const Locale('bn'));
    Future.delayed(3.seconds,(){
      if(token.isNotEmpty) {
        Get.offAllNamed(Routes.HOME_Customer);
      } else {
        Get.offAllNamed(Routes.HOME_Customer);
      }
    });
  }

}
