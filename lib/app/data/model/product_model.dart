import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ProductModel{

  int? productID;
  String? productName;
  String? productUnit;
  double? productPrice;
  int? productQuantity;
  RxBool isSelected = false.obs;


  ProductModel({
    this.productID = 0,
    this.productName = '',
    this.productUnit = '',
    this.productPrice = 0.0,
    this.productQuantity = 0,
    required this.isSelected
  });


 static final List<ProductModel> productList =[
    ProductModel(productID: 1, productName: "Petrol", productUnit: "Liter", productPrice: 100.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 2, productName: "Diesel", productUnit: "Liter", productPrice: 90.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 3, productName: "Kerosene", productUnit: "Liter", productPrice: 80.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 4, productName: "Gas", productUnit: "Liter", productPrice: 70.0, productQuantity: 0, isSelected: false.obs),
    ProductModel(productID: 5, productName: "Jet Oil", productUnit: "Liter", productPrice: 70.0, productQuantity: 0, isSelected: false.obs),
  ].obs;


}