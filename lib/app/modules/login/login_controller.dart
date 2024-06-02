import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/routes/app_pages.dart';

import '/app/core/base/base_controller.dart';
import '../../data/local/preference/preference_manager.dart';

class LoginController extends BaseController {

  var isHide = true.obs;
  var isRemember = true.obs;
  var sliderIndex = 0.obs;
  final validationKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void onInit()async {
    super.onInit();
    preference.setBool(PreferenceManager.keyRemember, isRemember.value);
    getLanguage();
  }

  @override
  void onReady() async {
    super.onReady();
    bool checkRemember = await preference.getBool(PreferenceManager.keyRemember);
    isRemember.value = checkRemember;
    if(checkRemember == true){
      phoneNumberController.text = await preference.getString(PreferenceManager.keyUser);
      passwordController.text = await preference.getString(PreferenceManager.keyPassword);
    }else{
      preference.clear();
    }
  }

  void saveLoginData() async {
    if (validationKey.currentState!.validate()) {
      validationKey.currentState!.save();
      Get.offAllNamed(Routes.HOME);
    }
  }


  @override
  void onClose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
