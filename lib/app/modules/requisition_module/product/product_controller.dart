import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/local/db/sqlite_table.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repository/repository.dart';
import '/app/core/base/base_controller.dart';

class ProductController extends BaseController {

  RxList<ProductModel> selectedProduct = <ProductModel>[].obs;
  final RxList<ProductModel> _rxProductList = RxList.empty();
  List<ProductModel> get productList => _rxProductList.toList();
  final Repository _repository = Get.find(tag: (Repository).toString());

  void loadInitialData() async{
    await dbManager.getProductData().then((value) {
      if(value.isNotEmpty) {_rxProductList.assignAll(value);}
      else {fetchProductData();}
    });
  }

  void fetchProductData() {
    var service = _repository.getAllProduct();
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  void _handleResponseSuccess(List<ProductModel> result) async {
    for (var element in result) {
      _rxProductList.assignAll(result);
      dbManager.insertItems(tableProduct, element.toJson());
    }
  }

}
