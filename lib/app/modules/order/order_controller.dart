import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/base/base_controller.dart';
import '../../data/model/order_model.dart';
import '../../data/repository/repository.dart';

class OrderController extends BaseController with GetSingleTickerProviderStateMixin{

  late TabController tabController;
  final tabs = [const Tab(text: 'Pending'), const Tab(text: 'Processing'), const Tab(text: 'Completed'),];

  var requestStatus = 'pending';
  final Map<String, RxList<Order>> orderLists = {
    'pending': RxList.empty(),
    'processing': RxList.empty(),
    'completed': RxList.empty(),
  };

  List<Order> getOrderList(String status) => orderLists[status]!.toList();

  @override
  void onInit() {
    super.onInit();
    fetchOrderData('pending');
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      var status = tabs[tabController.index].text!.toLowerCase();
      requestStatus = status;
      fetchOrderData(status);
    });
  }

  final Repository _repository = Get.find(tag: (Repository).toString());

  void fetchOrderData(String type) {
    if (orderLists[type]!.isEmpty) {
      var queryParam = {'type': type};
      var service = _repository.getOrderData(query: queryParam);
      callDataService(service, onSuccess: _handleResponseSuccess);
    }
  }

  void _handleResponseSuccess(OrderModel result) async {
    orderLists[requestStatus]!.assignAll(result.data!);
  }
}
