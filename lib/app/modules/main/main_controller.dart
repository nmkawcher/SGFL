import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/local/preference/preference_manager.dart';
import '/app/core/base/base_controller.dart';

class MainController extends BaseController {

  var isContractor = false.obs;
  var bottomNavIndex = 0.obs;
  var iconList = [Icons.home_filled, Icons.shopping_cart].obs;
  var pageList = ["Home", "Requisition"].obs;


  void loadInitialData() async {
    var userType = await preference.getString(PreferenceManager.keyUserType);
    isContractor.value = userType == 'Contractor';
    pageList[1] = isContractor.value ? "Request":"Requisition";
    iconList[1] = isContractor.value ? Icons.directions_bus_sharp:Icons.shopping_cart;
  }

}
