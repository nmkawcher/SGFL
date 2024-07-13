import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/order_model.dart';

import '/app/core/base/base_controller.dart';

class OrderDetailsController extends BaseController {

  var orderArgus = Get.arguments;
  Order get order => orderArgus as Order;

  int get progressStep {
    const statusSteps = {'new': 0, 'confirmed': 1, 'delivered': 3};
    return statusSteps[order.status] ?? 2;
  }


}
