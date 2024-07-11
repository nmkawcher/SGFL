import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';
import '../../data/model/order_model.dart';
import '../../data/repository/repository.dart';

class OrderController extends BaseController with GetSingleTickerProviderStateMixin{

  late TabController tabController;
  final tabs = [const Tab(text: 'Pending'), const Tab(text: 'Processing'), const Tab(text: 'Completed'),];

  final _rxOrderData = OrderModel().obs;
  OrderModel get orderData => _rxOrderData.value;
  RxList<Order> orderList = RxList.empty();

  RxList<Order> pendingOrderList = RxList.empty();
  RxList<Order> processingOrderList = RxList.empty();
  RxList<Order> completedOrderList = RxList.empty();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  final Repository _repository = Get.find(tag: (Repository).toString());

  void fetchOrderData() {
    var queryParam = {'type': 'processing'};
    var service = _repository.getOrderData(query: queryParam);
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  void _handleResponseSuccess(OrderModel result) async {
    _rxOrderData.value = result;
    orderList.assignAll(_rxOrderData.value.data ?? []);
    if(orderList.isNotEmpty){
      pendingOrderList.assignAll(orderList.where((element) => element.status == 'confirmed').toList());
      processingOrderList.assignAll(orderList.where((element) => element.status == 'processing').toList());
      completedOrderList.assignAll(orderList.where((element) => element.status == 'shipped').toList());
    }
  }
}
