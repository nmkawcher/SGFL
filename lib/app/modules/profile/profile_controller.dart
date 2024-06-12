import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/values/app_colors.dart';
import '/app/core/base/base_controller.dart';

class ProfileController extends BaseController {

  var titleList = ['Edit Profile', 'Edit MAC Address'];
  var innerTitle = 'Edit Profile'.obs;
  var selectedImagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();
  final  GlobalKey<FormState> profileGlobalKey = GlobalKey<FormState>();

  void choosePhoto(String source) async {
    try {
      final pickedFile = await _picker.pickImage(
          source: source == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery
      );

      if (pickedFile != null) {cropImage(pickedFile.path);}

    } catch (error) {
      logger.e('Error choosing from camera >>> $error');
    }
    Get.back();
  }

  void cropImage(String sourcePath) async {
   CroppedFile? croppedFile = await ImageCropper().cropImage(
     sourcePath: sourcePath,
     compressQuality: 20,
     uiSettings: [
       AndroidUiSettings(
         toolbarTitle: 'Cropper',
         cropStyle: CropStyle.circle,
         aspectRatioPresets: [CropAspectRatioPreset.square],
         activeControlsWidgetColor: AppColors.primary,
         toolbarColor: AppColors.primary,
         toolbarWidgetColor: Colors.white,
         initAspectRatio: CropAspectRatioPreset.square,
         lockAspectRatio: false,
       ),
       IOSUiSettings(
         title: 'Cropper',
         cropStyle: CropStyle.circle,
         aspectRatioPresets: [CropAspectRatioPreset.square],
         aspectRatioLockEnabled: false,
       ),
     ],
    );

    if(croppedFile != null){selectedImagePath.value = croppedFile.path;}
   }

}
