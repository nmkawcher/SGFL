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
  Order get order => orderArgus as Order;

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
  }

  final Repository _repository = Get.find(tag: (Repository).toString());

  void confirmOrder() {
    if(order.id != null) {
      var service = _repository.orderConfirm(order.id!);
      callDataService(service, onSuccess: _handleResponseSuccess);
    }
  }

  void _handleResponseSuccess(BaseResponseModel result) async {
    Get.back(result: true);
  }


}
