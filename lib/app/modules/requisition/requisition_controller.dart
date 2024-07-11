import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  var productReq = ProductReq().obs;
  var requisitionReq = RequisitionReqModel().obs;
  final RxList<ProductReq> productReqList = RxList.empty();
  TextEditingController notedController = TextEditingController();

  final Repository _repository = Get.find(tag: (Repository).toString());


  void creteRequisition() async {
     var userId = await preference.getInt(PreferenceManager.keyUserID);
     requisitionReq.value.customerId = userId;
     requisitionReq.value.dipoId = depot.id;
     requisitionReq.value.note = notedController.text;
     requisitionReq.value.items = productReqList;
     print(requisitionReq.toJson());
  }




}
