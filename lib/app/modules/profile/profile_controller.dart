import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/values/app_colors.dart';
import '../../data/model/profile_model.dart';
import '../../data/repository/repository.dart';
import '../../routes/app_pages.dart';
import '/app/core/base/base_controller.dart';

class ProfileController extends BaseController {

  var isProfileEdit = false.obs;
  var selectedImagePath = ''.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final  GlobalKey<FormState> profileGlobalKey = GlobalKey<FormState>();


  var reqProfile = ProfileModel().obs;
  final Rx<ProfileModel> _rxProfile = ProfileModel().obs;
  ProfileModel get profile => _rxProfile.value;

  final Repository _repository = Get.find(tag: (Repository).toString());

  void fetchProfileData() {
    var service = _repository.getProfileData();
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  @override
  void onReady() {
    super.onReady();
    ever(isProfileEdit, (value){
      if(value){
        nameController.text = _rxProfile.value.name ?? '';
        emailController.text = _rxProfile.value.email ?? '';
      }
    });
  }

  void updateProfileData() {
    if (profileGlobalKey.currentState!.validate()) {
      profileGlobalKey.currentState!.save();
      var service = _repository.updateProfileData(reqProfile.value);
      callDataService(service, onSuccess: _handleResponseSuccess,  onError: _handelError);
    }
  }

  void _handelError(error) {
    reqProfile.value = ProfileModel();
  }

  void _handleResponseSuccess(ProfileModel result) async {
    _rxProfile.value = result;
    isProfileEdit.value = false;
  }

  void logoutRequest() {
    var service = _repository.logoutReqData();
    callDataService(service, onSuccess: _handleLogoutSuccess);
  }

  void _handleLogoutSuccess(result) {
    preference.clear();
    Get.offAllNamed(Routes.LOGIN);
  }

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
         cropStyle: CropStyle.rectangle,
         aspectRatioPresets: [CropAspectRatioPreset.square],
         activeControlsWidgetColor: AppColors.primary,
         toolbarColor: AppColors.primary,
         toolbarWidgetColor: Colors.white,
         initAspectRatio: CropAspectRatioPreset.square,
         lockAspectRatio: false,
       ),
       IOSUiSettings(
         title: 'Cropper',
         cropStyle: CropStyle.rectangle,
         aspectRatioPresets: [CropAspectRatioPreset.square],
         aspectRatioLockEnabled: false,
       ),
     ]);

      if(croppedFile != null){
        selectedImagePath.value = croppedFile.path;
        reqProfile.value.image =  await dio.MultipartFile.fromFile(croppedFile.path);
        updateProfileData();
      }
   }

  SnackbarController submitDialog(){
    return Get.showSnackbar(
      const GetSnackBar(
        message: ' ',
        messageText: Text('Profile Updated Successfully !',textAlign:TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.green,
        overlayColor: Colors.transparent,
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 20,),
        borderRadius: 10,
      ),
    );

  }

}
