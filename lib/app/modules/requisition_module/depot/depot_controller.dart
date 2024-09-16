import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../core/values/app_colors.dart';
import '../../../data/local/db/sqlite_table.dart';
import '../../../data/local/preference/preference_manager.dart';
import '../../../data/model/baseResponse_model.dart';
import '../../../data/model/depot_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/model/requisition_model.dart';
import '../../../data/repository/repository.dart';
import '../../../routes/app_pages.dart';
import '../../main/main_controller.dart';
import '/app/core/base/base_controller.dart';

class DepotController extends BaseController {

  RxInt selectedDepot = 0.obs;
  RxBool isUserAdmin = false.obs;
  var selectedDepotZone = DepotZone().obs;

  final RxList<DepotModel> _rxDepotList = RxList.empty();
  List<DepotModel> get depotList => _rxDepotList.toList();

  final Repository _repository = Get.find(tag: (Repository).toString());



  void loadInitialData() async {
    var userType = await preference.getString(PreferenceManager.keyUserType);
    isUserAdmin.value = userType == 'Customer' ? false:true;

    //load product

    await dbManager.getProductData().then((value) {
      if(value.isNotEmpty) {_rxProductList.assignAll(value);}
      else {fetchProductData();}
    });
  }


  void fetchDepotData() async{
    var orgId = await preference.getInt(PreferenceManager.keyOrganizationId);
    var service = _repository.getAllDepot(depotId: orgId);
    callDataService(service, onSuccess: _handleDepoResponseSuccess);
  }

  void _handleDepoResponseSuccess(List<DepotModel> result) async {
    _rxDepotList.insert(0, DepotModel(name: "Select a Depo", id: null,address: ""));
    _rxDepotList.assignAll(result);
  }


  // product


  void fetchProductData() {
    var service = _repository.getAllProduct();
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  RxList<ProductModel> selectedProduct = <ProductModel>[].obs;
  final RxList<ProductModel> _rxProductList = RxList.empty();
  List<ProductModel> get productList => _rxProductList.toList();
  //final Repository _repository = Get.find(tag: (Repository).toString());

  // void loadInitialData() async{
  //   await dbManager.getProductData().then((value) {
  //     if(value.isNotEmpty) {_rxProductList.assignAll(value);}
  //     else {fetchProductData();}
  //   });
  // }
  //
  // void fetchProductData() {
  //   var service = _repository.getAllProduct();
  //   callDataService(service, onSuccess: _handleResponseSuccess);
  // }
  //
  void _handleResponseSuccess(List<ProductModel> result) async {
    for (var element in result) {
      _rxProductList.assignAll(result);
      dbManager.insertItems(tableProduct, element.toJson());
    }
  }

  // requisition list

  final RxList<ProductReq> productReqList = RxList.empty();

  var requisitionReq = RequisitionReqModel().obs;
  TextEditingController notedController = TextEditingController();
  final MainController mainController = Get.find();

  void creteRequisition() async {
    var orgID = await preference.getInt(PreferenceManager.keyOrganizationId);
    requisitionReq.value.customerId = orgID;
    requisitionReq.value.dipoId = selectedDepotZone.value.id;
    requisitionReq.value.note = notedController.text;
    print("product req list: ${productReqList.length}");
    productReqList.removeWhere((element) => element.baseQuantity == 0 && element.upperQuantity == 0);
    requisitionReq.value.items = productReqList;

    print("product requ list: ${productReqList.length}");

    if(productReqList.isNotEmpty) {
      crateRequisition(requisitionReq.value);
    }
  }

  void crateRequisition(RequisitionReqModel reqModel) {
    var service = _repository.requisitionReqData(reqModel);
    callDataService(service, onSuccess: _handleFinalResponseSuccess);
  }

  void _handleFinalResponseSuccess(BaseResponseModel result) async {
    DialogHelper.showSuccessDialog(successDialog(), function: (){
      Get.until((route)=>Get.currentRoute == Routes.MAIN);
      mainController.setBottomNavIndex(1);
    });

  }


  Widget successDialog(){
    return const SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.oil_barrel_outlined,size:50, color: AppColors.primary,),
          const SizedBox(height: 16),
          const Text("Your order has been\nPlaced successfully",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,
                  color: AppColors.accentPrimary)
          ),
        ],
      ),
    );
  }

}
