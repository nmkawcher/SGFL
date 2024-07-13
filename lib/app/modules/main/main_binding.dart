import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../order/order_controller.dart';
import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
      fenix: true,
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
      fenix: true,
    );
    Get.lazyPut<OrderController>(
      () => OrderController(),
      fenix: true,
    );
  }
}
