import 'package:get/get.dart';
import '/app/core/base/base_controller.dart';
import '../../data/model/product_model.dart';

class ProductController extends BaseController {

  RxList<ProductModel> selectedProduct = <ProductModel>[].obs;




  RxList<ProductModel> productList =[
    ProductModel(productID: 1, productName: "Petrol", productUnit: "Unit Price", productPrice: 100.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 2, productName: "Diesel", productUnit: "Unit Price", productPrice: 90.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 3, productName: "Kerosene", productUnit: "Unit Price", productPrice: 80.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 4, productName: "Gas", productUnit: "Unit Price", productPrice: 70.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 5, productName: "Jet Oil", productUnit: "Unit Price", productPrice: 70.0, productQuantity: 0, isSelected: false.obs),
  ].obs;

}
