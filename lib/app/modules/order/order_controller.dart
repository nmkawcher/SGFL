import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';

class OrderController extends BaseController with GetSingleTickerProviderStateMixin{

  var orderStatus = 'pending'.obs;
  late TabController tabController;
  final tabs = [const Tab(text: 'Pending'), const Tab(text: 'Processing'), const Tab(text: 'Completed'),];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }


}
