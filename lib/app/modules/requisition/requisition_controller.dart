import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/depot_model.dart';

import '../../data/model/product_model.dart';
import '../../data/repository/repository.dart';
import '/app/core/base/base_controller.dart';

class RequisitionController extends BaseController {

  RxInt selectedDepot = 0.obs;

  final RxList<DepotModel> _rxDepotList = RxList.empty();
  List<DepotModel> get depotList => _rxDepotList.toList();

  final Repository _repository = Get.find(tag: (Repository).toString());




  List<ProductModel> productList =[
    ProductModel(productID: 1, productName: "Petrol", productUnit: "Liter", productPrice: 100.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 2, productName: "Diesel", productUnit: "Liter", productPrice: 90.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 3, productName: "Kerosene", productUnit: "Liter", productPrice: 80.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 4, productName: "Gas", productUnit: "Liter", productPrice: 70.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 5, productName: "Jet Oil", productUnit: "Liter", productPrice: 70.0, productQuantity: 0, isSelected: false.obs),
  ].obs;


  void fetchDepotData() {
    var service = _repository.getAllDepot(4);
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  void _handleResponseSuccess(List<DepotModel> result) async {
    _rxDepotList.addAll(result);
  }

}
