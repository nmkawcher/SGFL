import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/baseResponse_model.dart';
import 'package:sgfl_sales/app/data/model/contractor_model.dart';
import 'package:sgfl_sales/app/data/model/unassign_model.dart';

import '/app/core/base/base_controller.dart';
import '../../data/repository/repository.dart';

class AssignController extends BaseController {

  RxList<UnassignedModel> selectedUnassign = RxList.empty();

  final RxList<UnassignedModel> _rxUnassignedList = RxList.empty();
  List<UnassignedModel> get unassignedList => _rxUnassignedList.toList();

  final RxList<Contractor> _rxContractorList = RxList.empty();
  List<Contractor> get contractorList => _rxContractorList.toList();

  final Repository _repository = Get.find(tag: (Repository).toString());

  void loadInitialData() async{
    fetchUnassignedData();
    fetchContractorData();
  }

  void fetchUnassignedData() {
    var service = _repository.getAllUnassigned();
    callDataService(service, onSuccess: _handleResponseSuccess);
  }
  void _handleResponseSuccess(List<UnassignedModel> result) async {
      _rxUnassignedList.assignAll(result);
  }

  void fetchContractorData() {
    var service = _repository.getContractorData();
    callDataService(service, onSuccess: _handleContractorSuccess);
  }
  void _handleContractorSuccess(List<Contractor> result) async {
    _rxContractorList.assignAll(result);
  }

  void assignContractor(List<AssignModel> assignList) {
    var service = _repository.assignOrder(assignList);
    callDataService(service, onSuccess: _handleAssignSuccess);
  }
  void _handleAssignSuccess(BaseResponseModel result) async {
    Get.back(result: result);
  }
}
