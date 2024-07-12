import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/baseResponse_model.dart';
import '../../data/local/preference/preference_manager.dart';
import '../../data/model/depot_model.dart';
import '../../data/model/product_model.dart';
import '../../data/model/requisition_model.dart';
import '../../data/repository/repository.dart';
import '/app/core/base/base_controller.dart';

class RequisitionController extends BaseController {

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    _argsDepot = args[0];
    _rxProductList.assignAll(args[1]);
  }

  late var _argsDepot = DepotZone().obs;
  DepotZone get depot => _argsDepot.value;
  final RxList<ProductModel> _rxProductList = RxList.empty();
  List<ProductModel> get productList => _rxProductList;
  final RxList<ProductReq> productReqList = RxList.empty();

  var requisitionReq = RequisitionReqModel().obs;
  TextEditingController notedController = TextEditingController();

  final Repository _repository = Get.find(tag: (Repository).toString());


  void creteRequisition() async {
     var userId = await preference.getInt(PreferenceManager.keyUserID);
     requisitionReq.value.customerId = userId;
     requisitionReq.value.dipoId = depot.id;
     requisitionReq.value.note = notedController.text;
     requisitionReq.value.items = productReqList;
     crateRequisition(requisitionReq.value);
  }

  void crateRequisition(RequisitionReqModel reqModel) {
    var service = _repository.requisitionReqData(reqModel);
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  void _handleResponseSuccess(BaseResponseModel result) async {
    print(result.data);
  }




}
