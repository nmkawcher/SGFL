import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_btn.dart';
import 'change_password_controller.dart';

class ChangePasswordView extends BaseView<ChangePasswordController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
     return AppBar(
       title: Text(appLocalization.changePassword,style: const TextStyle(color: Colors.black)),
       elevation: 0,
       centerTitle: true,
       backgroundColor: Colors.transparent,
       iconTheme: const IconThemeData(color: Colors.black),
       systemOverlayStyle: const SystemUiOverlayStyle(
           statusBarColor: Colors.transparent,
           statusBarIconBrightness: Brightness.dark),
     );
  }
  @override
  Widget body(BuildContext context) {
      return  Obx(() => SingleChildScrollView(
        padding: const EdgeInsets.only(top:20, left: 16,right: 16),
        child: Form(
          key: controller.changePassFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  controller: controller.currentPasswordFieldController,
                  obscureText: controller.isCurrentPassword.value,
                  onChanged:(value){controller.passReqModel.value.oldPassword = value;},
                  validator: (value) {
                    if(value!.isEmpty) return appLocalization.requiredField;
                    if(value.length < 6 ) return appLocalization.passwordSixCharactersMinimum;
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:  InputDecoration(
                      hintStyle: const TextStyle(color: AppColors.gray, fontSize: 14, fontWeight: FontWeight.w600),
                      contentPadding: const EdgeInsets.all(16),
                      hintText: '• • • • • •',
                      label:  Text(appLocalization.currentPassword),
                      suffixIcon: GestureDetector(
                          onTap: () {controller.isCurrentPassword.value = !controller.isCurrentPassword.value;},
                          child: Icon(controller.isCurrentPassword.value ? Icons.visibility_off : Icons.visibility)),
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))))
              ),
              const SizedBox(height: 24),
              Text(appLocalization.setNewPassword,textAlign:TextAlign.start, style: const TextStyle(fontSize: 16,color: AppColors.gray)),
              const SizedBox(height: 16),
              TextFormField(
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  controller: controller.newPasswordFieldController,
                  obscureText: controller.isHideNewPassword.value,
                  onChanged:(value){controller.passReqModel.value.newPassword = value;},
                  validator: (value) {
                    if(value!.isEmpty) return appLocalization.requiredField;
                    if(value.length < 6 ) return appLocalization.passwordSixCharactersMinimum;
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:  InputDecoration(
                      hintStyle: const TextStyle(color: AppColors.gray, fontSize: 14, fontWeight: FontWeight.w600),
                      contentPadding: const EdgeInsets.all(16),
                      hintText: '• • • • • •',
                      label:  Text(appLocalization.newPassword),
                      suffixIcon: GestureDetector(
                          onTap: () {controller.isHideNewPassword.value = !controller.isHideNewPassword.value;},
                          child: Icon(controller.isHideNewPassword.value ? Icons.visibility_off : Icons.visibility)),
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))))
              ),
              const SizedBox(height: 16),
              TextFormField(
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  controller: controller.confirmPasswordController,
                  obscureText: controller.isHideConfirmPassword.value,
                  onChanged:(value){controller.passReqModel.value.confirmPassword = value;},
                  validator: (value) {
                    if(value!.isEmpty) return appLocalization.requiredField;
                    if(value != controller.passReqModel.value.newPassword) return appLocalization.passwordNotMatch;
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:  InputDecoration(
                      hintStyle: const TextStyle(color: AppColors.gray, fontSize: 14, fontWeight: FontWeight.w600),
                      contentPadding: const EdgeInsets.all(16),
                      hintText: '• • • • • •',
                      label:  Text(appLocalization.confirmPassword),
                      suffixIcon: GestureDetector(
                          onTap: () {controller.isHideConfirmPassword.value = !controller.isHideConfirmPassword.value;},
                          child: Icon(controller.isHideConfirmPassword.value ? Icons.visibility_off : Icons.visibility)),
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))))
              ),
              const SizedBox(height: 32),
              DefaultAppBtn(
                title: appLocalization.setPassword,
                textSize:16,
                onClick: (){controller.setNewPassBtn();},
              )
            ],
          ),
        ),
      ),
    );
  }

}
