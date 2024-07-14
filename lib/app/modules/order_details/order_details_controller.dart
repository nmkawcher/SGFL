import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/baseResponse_model.dart';
import 'package:sgfl_sales/app/data/model/order_model.dart';

import '../../data/local/preference/preference_manager.dart';
import '../../data/repository/repository.dart';
import '/app/core/base/base_controller.dart';

class OrderDetailsController extends BaseController {

  var title = 'Requisition';
  var orderArgus = Get.arguments;
  var isAdmin = false.obs;
  var selectedItemId = 0.obs;
  final Rx<Order> _rxOrder = Order().obs;
  Order get order => _rxOrder.value;
  final GlobalKey<FormState> orderFormKey = GlobalKey<FormState>();
  final TextEditingController receivedQtyController = TextEditingController();

  int get progressStep {
    const statusSteps = {'new': 0, 'confirmed': 1, 'delivered': 3};
    return statusSteps[order.status] ?? 2;
  }

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData()async {
    var userType = await preference.getString(PreferenceManager.keyUserType);
    title = userType == 'Contractor' ? "Request":"Requisition";
    isAdmin.value = progressStep == 0 && userType == 'Admin';
    _rxOrder.value = orderArgus as Order;
  }

  final Repository _repository = Get.find(tag: (Repository).toString());

  void confirmOrder(String status) {
    if(order.id != null) {
      var service = _repository.orderConfirm(order.id!, status);
      callDataService(service, onSuccess: _handleResponseSuccess);
    }
  }

  void _handleResponseSuccess(BaseResponseModel result) async {
    Get.back(result: true);
  }

  void receivedQuantity(int itemId) {
    if(orderFormKey.currentState!.validate()) {
      orderFormKey.currentState!.save();
      selectedItemId.value = itemId;
      var service = _repository.orderItemUpdate(order.id!, itemId, receivedQtyController.text);
      callDataService(service, onSuccess: _handleResSuccess);
    }
  }

  void _handleResSuccess(BaseResponseModel result) async {
    for(var oi in _rxOrder.value.orderItems!){
      for(var il in oi.itemLorries!){
        if(selectedItemId.value == il.id){
          il.quantityReceived = receivedQtyController.text;
        }
      }
    }
    receivedQtyController.clear();
    _rxOrder.refresh();
    Get.back();
  }


}
