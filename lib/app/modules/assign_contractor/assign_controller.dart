import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/core/utils/dialog_helper.dart';
import 'package:sgfl_sales/app/data/model/baseResponse_model.dart';
import 'package:sgfl_sales/app/data/model/contractor_model.dart';
import 'package:sgfl_sales/app/data/model/unassign_model.dart';
import '../../core/values/app_colors.dart';
import '/app/core/base/base_controller.dart';
import '../../data/repository/repository.dart';

class AssignController extends BaseController {

  RxInt selectedContractor = 0.obs;
  RxList<UnassignedModel> selectedUnassign = RxList.empty();

  final GlobalKey<FormState> assignFormKey = GlobalKey<FormState>();
  final RxList<UnassignedModel> _rxUnassignedList = RxList.empty();
  List<UnassignedModel> get unassignedList => _rxUnassignedList.toList();
  final RxList<Contractor> _rxContractorList = RxList.empty();
  List<Contractor> get contractorList => _rxContractorList.toList();

  final Repository _repository = Get.find(tag: (Repository).toString());

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }


  void loadInitialData() async{
    fetchUnassignedData();
    fetchContractorData();
  }

  void saveAssign() {
    if (assignFormKey.currentState!.validate()) {
        assignFormKey.currentState!.save();
        RxList<AssignModel> assignList = RxList.empty();
        for (var element in selectedUnassign) {
          assignList.add(AssignModel(
              contractorId: selectedContractor.value,
              itemId: element.id
          ));
        }
        assignContractor(assignList.toList());
    }
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
    DialogHelper.showSuccessDialog(successDialog(), function: (){
      selectedContractor.value = 0;
      selectedUnassign.clear();
      loadInitialData();
    });
  }

  Widget successDialog(){
    return const SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.person_add_rounded,size:50, color: AppColors.primary,),
          SizedBox(height: 16),
          Text("Your order has been\nAssigned to contractor",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,
                color: AppColors.accentPrimary)
          ),
        ],
      ),
    );
  }

}
