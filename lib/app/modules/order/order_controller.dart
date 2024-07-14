import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/dialog_helper.dart';
import '../../core/values/app_colors.dart';
import '../../data/local/preference/preference_manager.dart';
import '../../data/model/baseResponse_model.dart';
import '../../data/model/contractor_model.dart';
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

  final RxList<LorryModel> _rxLorryList = RxList.empty();
  List<LorryModel> get lorryList => _rxLorryList.toList();

  List<Order> getOrderList(String status) => orderLists[status]!.toList();
  List<ContractorOrder> getContractorOrderList(String status) => contractorOrderLists[status]!.toList();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    loadInitialData();
  }

  void loadInitialData()async {
    var userType = await preference.getString(PreferenceManager.keyUserType);
    var orgId = await preference.getInt(PreferenceManager.keyOrganizationId);
    isContractor.value = userType == 'Contractor';
    title = isContractor.value ? "Request":"Requisition";

    fetchOrderData('pending');
    tabController.addListener(() {
      var status = tabs[tabController.index].text!.toLowerCase();
      requestStatus.value = status;
      fetchOrderData(status);
    });
    if(isContractor.isTrue){
      fetchLorryList(orgId);
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

  void fetchLorryList(int contractorId) {
    if (_rxLorryList.isEmpty) {
      var service = _repository.getLorryData(contractorId);
      callDataService(service, onSuccess: _handleLorryResponseSuccess);
    }
  }
  void _handleLorryResponseSuccess(List<LorryModel> result) {
    _rxLorryList.assignAll(result);
  }

  void saveLorryAssign(int itemId) {
    if (orderDetailsFormKey.currentState!.validate()) {
      orderDetailsFormKey.currentState!.save();
      RxList<assign.AssignModel> assignList = RxList.empty();
      assignList.add(assign.AssignModel(
          lorryId: selectedLorry.value,
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



}
