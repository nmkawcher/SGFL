import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/home_model.dart';
import '../../../core/base/base_controller.dart';
import '../../../data/local/preference/preference_manager.dart';
import '../../../data/repository/repository.dart';

class CustomerHomeController extends BaseController {

  var orderStatus = ''.obs;
  var userName = ''.obs;
  var userPhoto = ''.obs;
  final RxList<Stat> _rxStatsList = RxList.empty();
  List<Stat> get statsList => _rxStatsList.toList();
  final RxList<LatestOrder> _rxOrderList = RxList.empty();
  List<LatestOrder> get orderList => _rxOrderList.toList();
  ValueNotifier<double> valueNotifier = ValueNotifier(0);
  final Repository _repository = Get.find(tag: (Repository).toString());

  void loadInitialData() async {
    var isAdmin = await preference.getString(PreferenceManager.keyUserType);
    userName.value = await preference.getString(PreferenceManager.keyUserName);
    userPhoto.value = await preference.getString(PreferenceManager.keyUserPhoto);
    print('isAdmin: $isAdmin, userName: ${userName.value}, userPhoto: ${userPhoto.value}');
    orderStatus.value = isAdmin == 'Contactor' ? "REQUEST":"REQUISITION";
  }

  void fetchDashBoardData() {
    var service = _repository.getDashBoardData();
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  void _handleResponseSuccess(HomeModel result) async {
    _rxStatsList.assignAll(result.stats!);
    _rxOrderList.assignAll(result.latestOrders!);
  }
}