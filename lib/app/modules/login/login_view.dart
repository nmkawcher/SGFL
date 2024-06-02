import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/core/values/app_images.dart';

import '../../core/base/custom_view.dart';
import '../../core/utils/helper.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_btn.dart';
import '../../core/widget/custom_textButton.dart';
import 'login_controller.dart';

class LoginView extends CustomView<LoginController> {

  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.black),
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: AppColors.accentPrimary,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                controller.setLocale(controller.language.value == 'EN' ? 1 : 0);
              },
              child: Text(
                controller.language.value == 'EN'
                    ? controller.languageNameList[1]
                    : controller.languageNameList[0],
                style: const TextStyle(color: AppColors.accentPrimary),
              )),
        ),
      ],
    );
  }

  @override
  Widget pageScaffold(BuildContext context) {
    return Scaffold(
        key: customGlobalKey,
        appBar: appBar(context),
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.primary15,
        body: SafeArea(
            top: false,
            child: body(context)
        )
    );
  }

  Widget body(BuildContext context) {

    return Obx(() => Form(
        key: controller.validationKey,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                top: 140, left: 0, right: 0,
                child: Image.asset(AppImages.logo, height: 120,width: 120,)
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 40),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(appLocalization.signIn, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    TextFormField(
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                        controller: controller.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        validator: (value){
                          if(value!.isEmpty){
                            return appLocalization.requiredField;
                          }
                          if(!Helper.phoneNumberCheck(value)) {
                             return appLocalization.invalidPhoneNumber;
                          }
                             return null;
                        },
                        decoration: InputDecoration(
                            counterText: '',
                            labelText: appLocalization.phoneNumber,
                            labelStyle: const TextStyle(fontSize: 14),
                            hintStyle: const TextStyle(color: AppColors.gray, fontSize: 14),
                            contentPadding: const EdgeInsets.all(18),
                            hintText: appLocalization.enterPhoneNumber,
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                        )
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      controller: controller.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.isHide.value,
                      validator: (value) {return value!.isEmpty ? appLocalization.requiredField : null;},
                      decoration: InputDecoration(
                          labelText: appLocalization.password,
                          labelStyle: const TextStyle(fontSize: 14),
                          hintStyle: const TextStyle(color: AppColors.gray, fontSize: 14),
                          contentPadding: const EdgeInsets.all(18),
                          hintText: appLocalization.fillYourPassword,
                          suffixIcon: GestureDetector(
                              onTap: () {controller.isHide.value = !controller.isHide.value;},
                              child: Icon(controller.isHide.value ? Icons.visibility_off : Icons.visibility)),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)))),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          height: 22, width: 22,
                          margin: const EdgeInsets.only(right: 4),
                          child: Checkbox(
                            activeColor: AppColors.primary,
                            side: const BorderSide(width: 1, color: AppColors.gray),
                            value: controller.isRemember.value,
                            onChanged: (value) => controller.isRemember(value),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        Text(appLocalization.rememberMe),
                        const Spacer(),
                        DefaultTextBtn(
                            title: appLocalization.forgotPassword,
                            fontSize: 14,
                            onClick: () {}
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DefaultAppBtn(
                        title: appLocalization.signIn,
                        onClick: () {controller.saveLoginData();}
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
