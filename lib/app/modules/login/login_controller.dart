import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/local/db/sqlite_table.dart';
import 'package:sgfl_sales/app/routes/app_pages.dart';
import '../../data/model/login_model.dart';
import '../../data/repository/repository.dart';
import '/app/core/base/base_controller.dart';
import '../../data/local/preference/preference_manager.dart';

class LoginController extends BaseController {

  var isHide = true.obs;
  var isRemember = true.obs;
  final validationKey = GlobalKey<FormState>();
  var loginRequest = LoginModel().obs;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Repository _repository = Get.find(tag: (Repository).toString());



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
      phoneNumberController.text = await preference.getString(PreferenceManager.keyPhone);
      passwordController.text = await preference.getString(PreferenceManager.keyPassword);
    }else{
      preference.clear();
    }
  }

  void saveLoginData() async {
    loginRequest.value.phoneNo = phoneNumberController.text;
    loginRequest.value.password = passwordController.text;

    if (validationKey.currentState!.validate()) {
      validationKey.currentState!.save();
      fetchLoginData(loginRequest.value);
    }
  }

  void fetchLoginData(LoginModel loginRequest) {
    var loginService = _repository.loginResponse(loginRequest);
    callDataService(loginService, onSuccess: _handleResponseSuccess);
  }

  void _handleResponseSuccess(LoginModel result) async {
    preference.setString(PreferenceManager.keyAccessToken, result.token ??'');
    preference.setBool(PreferenceManager.keyRemember, isRemember.value);
    preference.setString(PreferenceManager.keyPhone, loginRequest.value.phoneNo ??'');
    preference.setString(PreferenceManager.keyPassword, loginRequest.value.password ??'');
    preference.setString(PreferenceManager.keyUserType, result.data?.role ?? '');
    preference.setInt(PreferenceManager.keyUserID, result.data?.id ?? 0);
    preference.setInt(PreferenceManager.keyOrganizationId, result.organisation?.id ?? 0);
    dbManager.insertItems(tableUser, result.data!.toJson());
    if(result.organisation!= null && result.data?.role != 'Admin') {
      dbManager.insertItems(tableOrganization, result.organisation!.toJson());
    }

    Get.offAllNamed(Routes.MAIN);
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
