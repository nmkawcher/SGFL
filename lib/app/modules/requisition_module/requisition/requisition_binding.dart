import 'package:get/get.dart';

import 'requisition_controller.dart';

class RequisitionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequisitionController>(
      () => RequisitionController(),
    );
  }
}
