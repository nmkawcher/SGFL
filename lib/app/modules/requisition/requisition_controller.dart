import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/core/utils/dialog_helper.dart';
import 'package:sgfl_sales/app/data/model/baseResponse_model.dart';
import 'package:sgfl_sales/app/routes/app_pages.dart';
import '../../core/values/app_colors.dart';
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
     var orgID = await preference.getInt(PreferenceManager.keyOrganizationId);
     requisitionReq.value.customerId = orgID;
     requisitionReq.value.dipoId = depot.id;
     requisitionReq.value.note = notedController.text;
     productReqList.removeWhere((element) => element.baseQuantity == 0 && element.upperQuantity == 0);
     requisitionReq.value.items = productReqList;
     if(productReqList.isNotEmpty) {
       crateRequisition(requisitionReq.value);
     }
  }

  void crateRequisition(RequisitionReqModel reqModel) {
    var service = _repository.requisitionReqData(reqModel);
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  void _handleResponseSuccess(BaseResponseModel result) async {
    DialogHelper.showSuccessDialog(successDialog(), function: (){
      Get.until((route)=>Get.currentRoute == Routes.MAIN);
    });
  }


  Widget successDialog(){
    return const SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.oil_barrel_outlined,size:50, color: AppColors.primary,),
          SizedBox(height: 16),
          Text("Your order has been\nPlaced successfully",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,
                  color: AppColors.accentPrimary)
          ),
        ],
      ),
    );
  }

}
