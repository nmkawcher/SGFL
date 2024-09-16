import 'package:get/get.dart';
import 'depot_controller.dart';

class DepotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DepotController>(
      () => DepotController(),
    );
  }
}
