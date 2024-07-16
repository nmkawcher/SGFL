import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/dialog_helper.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_btn.dart';
import '../../data/local/preference/preference_manager.dart';
import '../../data/model/baseResponse_model.dart';
import '../../data/model/contractor_model.dart';
import '../../data/model/driver_mode.dart';
import '../../data/model/lorry_model.dart';
import '../../data/model/unassign_model.dart' as assign;
import '../../routes/app_pages.dart';
import '/app/core/base/base_controller.dart';
import '../../data/model/order_model.dart';
import '../../data/repository/repository.dart';

class OrderController extends BaseController with GetSingleTickerProviderStateMixin {

  final isContractor = false.obs;
  var title = 'Requisition';
  var requestStatus = 'pending'.obs;
  RxInt selectedLorry = 0.obs;
  RxInt selectedDriver = 0.obs;
  RxInt selectedOrderID = 0.obs;

  late TabController tabController;
  final tabs = [
    const Tab(text: 'Pending'),
    const Tab(text: 'Processing'),
    const Tab(text: 'Completed'),
  ];

  final GlobalKey<FormState> orderDetailsFormKey = GlobalKey<FormState>();
  final Map<String, RxList<Order>> orderLists = {
    'pending': RxList.empty(),
    'processing': RxList.empty(),
    'completed': RxList.empty(),
  };
  final Map<String, RxList<ContractorOrder>> contractorOrderLists = {
    'pending': RxList.empty(),
    'processing': RxList.empty(),
    'completed': RxList.empty(),
  };

  final RxList<LorryModel> lorryList = RxList.empty();
  final RxList<DriverModel> driverList = RxList.empty();

  List<Order> getOrderList(String status) => orderLists[status]!.toList();
  List<ContractorOrder> getContractorOrderList(String status) => contractorOrderLists[status]!.toList();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    loadInitialData();
  }

  void loadInitialData()async{
    var userType = await preference.getString(PreferenceManager.keyUserType);
    isContractor.value = userType == 'Contractor';
    title = isContractor.value ? "Request":"Requisition";
    fetchOrderData('pending');
    tabController.addListener(() {
      var status = tabs[tabController.index].text!.toLowerCase();
      requestStatus.value = status;
      fetchOrderData(status);
    });
  }

  void contractorDataLoad()async{
    var orgId = await preference.getInt(PreferenceManager.keyOrganizationId);
    if(isContractor.isTrue){
      fetchLorryList(orgId, selectedOrderID.value);
      fetchDriverList(orgId, selectedOrderID.value);
    }
  }

  final Repository _repository = Get.find(tag: (Repository).toString());

  void fetchOrderData(String type) {
    var listToCheck = isContractor.value ? contractorOrderLists[type] : orderLists[type];
    if (listToCheck!.isEmpty) {
      var queryParam = {'type': type};
      var service = _repository.getOrderData(query: queryParam);
      callDataService(service, onSuccess: _handleResponseSuccess);
    }
  }
  void _handleResponseSuccess(dynamic result) async {
    if(isContractor.value){
      var order = ContractorOrderModel.fromJson(result);
      contractorOrderLists[requestStatus.value]?.assignAll(order.data!);
    }else{
      var order = OrderModel.fromJson(result);
      orderLists[requestStatus.value]?.assignAll(order.data!);
    }
  }

  void gotoOrderDetails(Order order)async {
    var result = await Get.toNamed(Routes.ORDERDetails, arguments: order);
    if(result == true){
      orderLists[requestStatus.value]!.clear();
      fetchOrderData(requestStatus.value);
    }
  }

  void fetchLorryList(int contractorId, int itemId) {
      var service = _repository.getLorryData(contractorId, itemId);
      callDataService(service, onSuccess: _handleLorryResponseSuccess);
  }
  void _handleLorryResponseSuccess(List<LorryModel> result) {
    lorryList.assignAll(result);
    callDialog();
  }

  void fetchDriverList(int contractorId, int itemId) {
    var service = _repository.getAllDriverData(contractorId, itemId);
    callDataService(service, onSuccess: _handleDriverResponseSuccess);
  }
  void _handleDriverResponseSuccess(List<DriverModel> result) {
     driverList.assignAll(result);
     callDialog();
  }

  void saveLorryAssign(int itemId) {
    if (orderDetailsFormKey.currentState!.validate()) {
      orderDetailsFormKey.currentState!.save();
      RxList<assign.AssignModel> assignList = RxList.empty();
      assignList.add(assign.AssignModel(
          lorryId: selectedLorry.value,
          driverId: selectedDriver.value,
          itemId: itemId
      ));
      assignContractor(assignList.toList());
    }
  }
  void assignContractor(List<assign.AssignModel> assignList) {
    var service = _repository.assignOrder(assignList);
    callDataService(service, onSuccess: _handleAssignSuccess);
  }
  void _handleAssignSuccess(BaseResponseModel result) async {
    DialogHelper.showSuccessDialog(successDialog(), function: (){
      Get.back();
      selectedLorry.value = 0;
      contractorOrderLists[requestStatus.value]!.clear();
      fetchOrderData(requestStatus.value);
    });
  }

  Widget successDialog(){
    return const SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.directions_bus,size:50, color: AppColors.primary,),
          SizedBox(height: 16),
          Text("Your Lorry has been\nAssigned",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,
                  color: AppColors.accentPrimary)
          ),
        ],
      ),
    );
  }
  void callDialog(){
    if(lorryList.isNotEmpty && driverList.isNotEmpty){
      DialogHelper.onDefaultButtonSheet(
          bottomSheetBar(selectedOrderID.value),
          dialogHeight: Get.height * 0.40
      );
    }
  }
  Widget bottomSheetBar(int itemId) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
      child: Form(
        key: orderDetailsFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lorry Assign', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.colorDark)),
            const SizedBox(height: 24),
            DropdownSearch<LorryModel>(
              popupProps: PopupProps.menu(
                constraints:  const BoxConstraints.tightFor(height:250),
                containerBuilder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: child,
                  );
                },
                menuProps: MenuProps(
                    clipBehavior: Clip.antiAlias,
                    elevation: 8,
                    borderRadius: BorderRadius.circular(16)
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: const TextStyle(fontSize: 14),
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  labelText: 'Lorry',
                  prefixIcon: const Icon(Icons.directions_bus_filled_rounded, color: AppColors.primary,),
                  labelStyle: const TextStyle(fontSize: 18),
                  contentPadding: const EdgeInsets.all(18),
                ),
              ),
              validator: (LorryModel? value) => value == null ?  appLocalization.requiredField : null,
              items: lorryList,
              itemAsString: (LorryModel lorry) => lorry.regNo!,
              onChanged: (value){selectedLorry.value = value!.id!;},
            ),
            const SizedBox(height: 8),
            DropdownSearch<DriverModel>(
              popupProps: PopupProps.menu(
                constraints:  const BoxConstraints.tightFor(height:250),
                containerBuilder: (context, child) {
                  return Container(padding: const EdgeInsets.all(16), child: child);
                },
                menuProps: MenuProps(
                    clipBehavior: Clip.antiAlias,
                    elevation: 8,
                    borderRadius: BorderRadius.circular(16)
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: const TextStyle(fontSize: 14),
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  labelText: 'Driver',
                  prefixIcon: const Icon(Icons.person, color: AppColors.primary,),
                  labelStyle: const TextStyle(fontSize: 18),
                  contentPadding: const EdgeInsets.all(18),
                ),
              ),
              validator: (DriverModel? value) => value == null ?  appLocalization.requiredField : null,
              items: driverList,
              itemAsString: (DriverModel driver) => driver.name!,
              onChanged: (value){selectedDriver.value = value!.id!;},
            ),
            const SizedBox(height: 32),
            DefaultAppBtn(title: 'Submit', onClick: (){saveLorryAssign(itemId);}),
          ],
        ),
      ),
    );
  }

}
