import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/local/preference/preference_manager.dart';
import '../../data/model/contractor_model.dart';
import '/app/core/base/base_controller.dart';
import '../../data/model/order_model.dart';
import '../../data/repository/repository.dart';

class OrderController extends BaseController with GetSingleTickerProviderStateMixin {

  final isContractor = false.obs;
  late TabController tabController;
  final tabs = [
    const Tab(text: 'Pending'),
    const Tab(text: 'Processing'),
    const Tab(text: 'Completed'),
  ];

  var requestStatus = 'pending';
  final Map<String, RxList<Order>> orderLists = {
    'pending': RxList.empty(),
    'processing': RxList.empty(),
    'completed': RxList.empty(),
  };
  final Map<String, RxList<ContractorOrder>> contractorOrderLists = {
    'pending': RxList.empty(),
    'processing': RxList.empty(),
    'completed': RxList.empty(),
  };

  List<Order> getOrderList(String status) => orderLists[status]!.toList();
  List<ContractorOrder> getContractorOrderList(String status) => contractorOrderLists[status]!.toList();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    loadInitialData();
  }

  void loadInitialData()async {
    var userType = await preference.getString(PreferenceManager.keyUserType);
    isContractor.value = userType == 'Contractor';

    fetchOrderData('pending');
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

  void _handleResponseSuccess(dynamic result) async {
    if(isContractor.value){
      var order = ContractorOrderModel.fromJson(result);
      contractorOrderLists[requestStatus]!.assignAll(order.data!);
      return;
    }else{
      var order = OrderModel.fromJson(result);
      orderLists[requestStatus]!.assignAll(order.data!);
    }
  }
}
