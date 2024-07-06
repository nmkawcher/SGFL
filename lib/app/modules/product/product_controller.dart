import 'package:get/get.dart';
import '../../data/repository/repository.dart';
import '/app/core/base/base_controller.dart';
import '../../data/model/product_model.dart';

class ProductController extends BaseController {

  RxList<ProductModel> selectedProduct = <ProductModel>[].obs;
  final RxList<ProductModel> _rxProductList = RxList.empty();
  List<ProductModel> get productList => _rxProductList.toList();

  final Repository _repository = Get.find(tag: (Repository).toString());

  void fetchDepotData() {
    var service = _repository.getAllProduct();
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  void _handleResponseSuccess(List<ProductModel> result) async {
    _rxProductList.addAll(result);
  }




}
