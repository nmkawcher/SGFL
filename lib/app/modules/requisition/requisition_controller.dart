import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/depot_model.dart';

import '../../data/model/product_model.dart';
import '/app/core/base/base_controller.dart';

class RequisitionController extends BaseController {

  RxInt selectedDepot = 0.obs;

  List<DepotModel> depotList =[
    DepotModel(depotId: 1, depotName: 'Padma Oil Company Limited', depotAddress: 'Road 16,SIRAJDOLLA ROAD, CHITTAGONG'),
    DepotModel(depotId: 2, depotName: 'Padma Oil Company Limited', depotAddress: 'Road 16,SIRAJDOLLA ROAD, CHITTAGONG'),
    DepotModel(depotId: 2, depotName: 'Padma Oil Company Limited', depotAddress: 'Road 16,SIRAJDOLLA ROAD, CHITTAGONG'),
    DepotModel(depotId: 2, depotName: 'Padma Oil Company Limited', depotAddress: 'Road 16,SIRAJDOLLA ROAD, CHITTAGONG'),
    DepotModel(depotId: 2, depotName: 'Padma Oil Company Limited', depotAddress: 'Road 16,SIRAJDOLLA ROAD, CHITTAGONG'),
    DepotModel(depotId: 2, depotName: 'Padma Oil Company Limited', depotAddress: 'Road 16,SIRAJDOLLA ROAD, CHITTAGONG'),
    DepotModel(depotId: 2, depotName: 'Padma Oil Company Limited', depotAddress: 'Road 16,SIRAJDOLLA ROAD, CHITTAGONG'),
  ].obs;

  List<ProductModel> productList =[
    ProductModel(productID: 1, productName: "Petrol", productUnit: "Liter", productPrice: 100.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 2, productName: "Diesel", productUnit: "Liter", productPrice: 90.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 3, productName: "Kerosene", productUnit: "Liter", productPrice: 80.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 4, productName: "Gas", productUnit: "Liter", productPrice: 70.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 5, productName: "Jet Oil", productUnit: "Liter", productPrice: 70.0, productQuantity: 0, isSelected: false.obs),
  ].obs;





}
