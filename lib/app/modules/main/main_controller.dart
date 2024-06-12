import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';

class MainController extends BaseController {

  var bottomNavIndex = 0.obs;
  final iconList = [Icons.home_filled, Icons.list_alt_rounded].obs;
  final pageList = ["Home", "Order"].obs;


}
