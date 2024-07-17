import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/modules/order/order_controller.dart';

import '../../data/local/preference/preference_manager.dart';
import '/app/core/base/base_controller.dart';

class MainController extends BaseController {

  var isContractor = false.obs;
  var isAdmin = false.obs;
  var bottomNavIndex = 0.obs;
  var iconList = [Icons.home_filled, Icons.shopping_cart].obs;
  var pageList = ["Home", "Requisition"].obs;

  final OrderController orderController = Get.find();
  void setBottomNavIndex(int index) {
    bottomNavIndex.value = index;
    orderController.onRefreshAllData();
  }

  void loadInitialData() async {
    var userType = await preference.getString(PreferenceManager.keyUserType);
    isContractor.value = userType == 'Contractor';
    isAdmin.value = userType == 'Admin';
    pageList[1] = isContractor.value ? "Request":"Requisition";
    iconList[1] = isContractor.value ? Icons.directions_bus_sharp:Icons.shopping_cart;
  }

}
