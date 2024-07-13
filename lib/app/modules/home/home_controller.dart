import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/home_model.dart';
import '../../core/base/base_controller.dart';
import '../../data/local/preference/preference_manager.dart';
import '../../data/repository/repository.dart';

class HomeController extends BaseController {

  var status = ''.obs;
  var userName = ''.obs;
  var userPhoto = ''.obs;
  final RxList<Stat> _rxStatsList = RxList.empty();
  List<Stat> get statsList => _rxStatsList.toList();
  final RxList<LatestOrder> _rxOrderList = RxList.empty();
  List<LatestOrder> get orderList => _rxOrderList.toList();
  ValueNotifier<double> valueNotifier = ValueNotifier(0);
  final Repository _repository = Get.find(tag: (Repository).toString());

  void loadInitialData() async {
    var userType = await preference.getString(PreferenceManager.keyUserType);
    status.value = userType == 'Contractor' ? "REQUEST":"REQUISITION";
    dbManager.getUserInfoData().then((value) {
      if(value != null){
        userName.value = value.name!;
        userPhoto.value = value.avatar!;
      }
    });
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