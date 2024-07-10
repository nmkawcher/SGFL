import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/base/base_controller.dart';
import '../../core/utils/dialog_helper.dart';
import '../../core/values/app_colors.dart';
import '../../data/local/preference/preference_manager.dart';
import '../../data/model/baseResponse_model.dart';
import '../../data/model/reset_pass_model.dart';
import '../../data/repository/repository.dart';

class ChangePasswordController extends BaseController {


  var isHideNewPassword = true.obs;
  var isCurrentPassword = true.obs;
  var isHideConfirmPassword = true.obs;
  final passReqModel = PasswordReqModel().obs;
  final GlobalKey<FormState> changePassFormKey = GlobalKey<FormState>();
  final Repository _repository = Get.find(tag: (Repository).toString());


  final TextEditingController currentPasswordFieldController=TextEditingController();
  final TextEditingController newPasswordFieldController=TextEditingController();
  final TextEditingController confirmPasswordController=TextEditingController();

  void setNewPassBtn()async{
    if (changePassFormKey.currentState!.validate()) {
      changePassFormKey.currentState!.save();
      passwordUpdate(passReqModel.value);
    }
  }
  
  void passwordUpdate(PasswordReqModel reqModel) {
    var service = _repository.updatePassword(reqModel);
    callDataService(service, onSuccess: _handleNewPassSuccess);
  }
  
  _handleNewPassSuccess(BaseResponseModel response) {
    preference.setString(PreferenceManager.keyPassword, passReqModel.value.newPassword ??'');
    DialogHelper.showSuccessDialog(changePasswordDialog(), function: (){
      currentPasswordFieldController.clear();
      newPasswordFieldController.clear();
      confirmPasswordController.clear();
    });
    showSuccessMessage(response.message??"");
  }

  @override
  void onClose() {
    currentPasswordFieldController.dispose();
    newPasswordFieldController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Widget changePasswordDialog(){
    return const SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.cloud_done_rounded,size:50, color: AppColors.green,),
          SizedBox(height: 16),
          Text("Password Change\nSuccessful",textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: AppColors.accentPrimary),),
        ],
      ),
    );
  }
  
}