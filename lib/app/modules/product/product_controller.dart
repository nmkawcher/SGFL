import 'package:get/get.dart';
import '/app/core/base/base_controller.dart';
import '../../data/model/product_model.dart';

class ProductController extends BaseController {

  RxList<ProductModel> selectedProduct = <ProductModel>[].obs;




  RxList<ProductModel> productList =[
    ProductModel(productID: 1, productName: "Petrol", productUnit: "Liter", productPrice: 100.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 2, productName: "Diesel", productUnit: "Liter", productPrice: 90.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 3, productName: "Kerosene", productUnit: "Liter", productPrice: 80.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 4, productName: "Gas", productUnit: "Liter", productPrice: 70.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 5, productName: "Jet Oil", productUnit: "Liter", productPrice: 70.0, productQuantity: 0, isSelected: false.obs),
  ].obs;

}
