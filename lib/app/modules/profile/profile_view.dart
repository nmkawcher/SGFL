import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/app/core/base/base_view.dart';
import '../../core/utils/dialog_helper.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/profile_image.dart';
import 'profile_controller.dart';

class ProfileView extends BaseView<ProfileController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text(appLocalization.profile,style: const TextStyle(color: Colors.white)),
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.primary,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
  }

  @override
  Widget body(BuildContext context) {
    double defaultSize = Get.width * 0.024;
    double profileSize= defaultSize * 14;
    double coverHeight= defaultSize * 10;
    double topPos = coverHeight * 0.25;

    return Obx(() => RefreshIndicator(
      onRefresh: () async{},
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(height: coverHeight, color: AppColors.primary,),
              Positioned( top: topPos,left: 0,right: 0,
                child: Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      ProfileCircleImage(
                          profileSize: profileSize, imageUrl: '',
                          localImage: controller.selectedImagePath.value
                      ),
                      Positioned(bottom: 2, right: 4,
                        child: GestureDetector(
                          onTap: (){DialogHelper.onDefaultButtonSheet(bottomSheetBar(),dialogHeight: Get.height * 0.35);},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: defaultSize * 0.5, color: Colors.white,),
                                borderRadius: const BorderRadius.all(Radius.circular(50),),
                                color: AppColors.grayLight2),
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(Icons.edit, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          const Text('Mr.William',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('01619963332',style: TextStyle(fontSize: 16)),

        ],
      ),
    ));
  }

  Widget bottomSheetBar(){
    return Container(
      margin:  const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          bottomSheetItem(
              icon: Icons.camera_alt_rounded,
              title: appLocalization.takePicture,
              onClick: ()async{
                controller.choosePhoto('camera');
              }
          ),
          bottomSheetItem(
              icon: Icons.photo_library_rounded,
              title: appLocalization.choosePicture,
              onClick: ()async{
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
              padding: const EdgeInsets.only(left: 32,top: 16,bottom: 16),
              child: Row(
                children: [
                  Icon(icon,color: Colors.black),
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

