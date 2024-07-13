import 'package:get/get.dart';
import 'assign_controller.dart';

class AssignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignController>(
      () => AssignController(),
    );
  }
}
