import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/local/preference/preference_manager.dart';
import '/app/core/base/base_controller.dart';

class MainController extends BaseController {

  var status = 'Requisition'.obs;
  var bottomNavIndex = 0.obs;
  final iconList = [Icons.home_filled, Icons.shopping_cart].obs;
  var pageList = ["Home", "Requisition"].obs;


  void loadInitialData() async {
    var userType = await preference.getString(PreferenceManager.keyUserType);
    status.value = userType == 'Contactor' ? "Request":"Requisition";
    pageList[1] = status.value;
  }

}
