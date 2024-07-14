import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/core/values/app_images.dart';
import 'package:sgfl_sales/app/core/widget/custom_btn.dart';

import '../../core/widget/custom_inputField.dart';
import '../../routes/app_pages.dart';
import '/app/core/base/base_view.dart';
import '../../core/utils/dialog_helper.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/profile_image.dart';
import 'profile_controller.dart';

class ProfileView extends BaseView<ProfileController> {
  ProfileView() {
    controller.loadInitialData();
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text(controller.isProfileEdit.value ?
        appLocalization.editProfile : appLocalization.profile,
          style: const TextStyle(color: Colors.black)),
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.colorGrayBG,
      iconTheme: const IconThemeData(color: Colors.black),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    double defaultSize = Get.width * 0.024;
    var decoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );
    return Obx(() => RefreshIndicator(
          onRefresh: () async {controller.fetchProfileData();},
          child: SingleChildScrollView(
            child: Container(
              height: Get.height,
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.profileGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ProfileCircleImage(profileSize: 90,
                            imageUrl: controller.profile.avatar ?? "",
                            localImage: controller.selectedImagePath.value),
                        Visibility(
                          visible: controller.isProfileEdit.value,
                          child: Positioned(bottom: -8, right: -8,
                            child: GestureDetector(
                              onTap: () {DialogHelper.onDefaultButtonSheet(bottomSheetBar(), dialogHeight: Get.height * 0.35);},
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: defaultSize * 0.5, color: Colors.white,),
                                    borderRadius: const BorderRadius.all(Radius.circular(50),),
                                    color: AppColors.orange),
                                child: const Padding(padding: EdgeInsets.all(2.0),
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Visibility(
                      visible: controller.isProfileEdit.isFalse,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(controller.profile.name ?? "", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(controller.profile.email ?? "", style: const TextStyle(fontSize: 14, color: AppColors.gray)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Visibility(
                      visible: controller.isProfileEdit.isFalse,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: decoration,
                        child: Column(
                          children: [
                            profileTill(AppImages.designation, controller.profile.designation ?? ""),
                            const SizedBox(height: 10),
                            const Divider(color: AppColors.grayLight2,),
                            const SizedBox(height: 10),
                            profileTill(AppImages.phone, controller.profile.phoneNo ?? ""),
                            controller.organisation.name == null
                                ? Container()
                                :Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    const Divider(color: AppColors.grayLight2,),
                                    const SizedBox(height: 10),
                                    profileTill(AppImages.office, controller.organisation.name ?? ""),
                                  ],
                                ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: controller.isProfileEdit.isFalse,
                      child: Column(
                        children: [
                          Container(
                            decoration: decoration,
                            child: ListTile(
                              title: const Text('Edit Profile', style: TextStyle(color: AppColors.gray, fontSize: 16, fontWeight: FontWeight.w500)),
                              leading: const Icon(Icons.person_outline, color: Colors.black, size: 24),
                              onTap: () async {controller.isProfileEdit(true);},
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: decoration,
                            child: ListTile(
                              title: const Text('Change Password', style: TextStyle(color: AppColors.gray, fontSize: 16, fontWeight: FontWeight.w500)),
                              leading: const Icon(Icons.password_rounded, color: Colors.black, size: 24),
                              onTap: () async {Get.toNamed(Routes.CHANGE_PASSWORD);},
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: decoration,
                            child: ListTile(
                              title: const Text('Logout', style: TextStyle(color: AppColors.gray, fontSize: 16, fontWeight: FontWeight.w500)),
                              leading: Image.asset(AppImages.logout, width: 24, height: 24),
                              onTap: () async {controller.logoutRequest();},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.isProfileEdit.isTrue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Change Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 16),
                          DefaultInputFiled(
                           txtController: controller.nameController,
                            onChanged: (String value) { controller.reqProfile.value.name = value;},
                            labelText: 'Full Name',
                          ),
                          DefaultInputFiled(
                            txtController: controller.emailController,
                            onChanged: (String value) { controller.reqProfile.value.email = value; },
                            labelText: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 32),
                          DefaultAppBtn(title: appLocalization.submit, onClick: (){
                            controller.updateProfileData();
                          }),
                          const SizedBox(height: 8),
                          DefaultAppBtn(
                              title: appLocalization.noTakeMwBack,
                              backgroundColor: AppColors.grayLight2,
                              onClick: (){controller.isProfileEdit.value = false;})
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget profileTill(String icon, String title) {
    return Row(
      children: [
        Image.asset(icon, width: 20, height: 20),
        const SizedBox(width:16),
        Text(title, style: const TextStyle(color: AppColors.gray, fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget bottomSheetBar() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          bottomSheetItem(
              icon: Icons.camera_alt_rounded,
              title: appLocalization.takePicture,
              onClick: () async {
                controller.choosePhoto('camera');
              }),
          bottomSheetItem(
              icon: Icons.photo_library_rounded,
              title: appLocalization.choosePicture,
              onClick: () async {
                controller.choosePhoto('gallery');
              }),
          const Divider(thickness: 1),
        ],
      ),
    );
  }

  Widget bottomSheetItem({
    required IconData icon,
    required String title,
    required GestureTapCallback? onClick,
  }) {
    return Column(
      children: [
        const Divider(thickness: 1),
        InkWell(
          onTap: onClick,
          splashColor: AppColors.primary15,
          highlightColor: AppColors.primary.withOpacity(0.1),
          child: Ink(
            child: Container(
              padding: const EdgeInsets.only(left: 32, top: 16, bottom: 16),
              child: Row(
                children: [
                  Icon(icon, color: Colors.black),
                  const SizedBox(width: 16),
                  Text(title, style: const TextStyle(color: Colors.black, fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
