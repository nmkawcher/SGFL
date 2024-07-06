import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/depot_model.dart';

import '../../data/repository/repository.dart';
import '/app/core/base/base_controller.dart';

class RequisitionController extends BaseController {

  RxInt selectedDepot = 0.obs;
  final RxList<DepotModel> _rxDepotList = RxList.empty();
  List<DepotModel> get depotList => _rxDepotList.toList();

  final Repository _repository = Get.find(tag: (Repository).toString());

  void fetchDepotData() {
    var service = _repository.getAllDepot(depotId: 4);
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  void _handleResponseSuccess(List<DepotModel> result) async {
    _rxDepotList.addAll(result);
  }

}
