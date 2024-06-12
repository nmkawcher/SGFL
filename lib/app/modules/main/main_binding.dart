import 'package:get/get.dart';

import '../home/customer_home/customer_home_controller.dart';
import '../order/order_controller.dart';
import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
      fenix: true,
    );
    Get.lazyPut<CustomerHomeController>(
          () => CustomerHomeController(),
      fenix: true,
    );
    Get.lazyPut<OrderController>(
      () => OrderController(),
      fenix: true,
    );
  }
}
