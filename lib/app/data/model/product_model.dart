class ProductModel{

  String? productName;
  String? productUnit;
  double productPrice;
  int productQuantity;

  ProductModel({
    this.productName,
    this.productUnit,
    this.productPrice = 0.0,
    this.productQuantity = 0
  });


 static final List<ProductModel> productList =[
    ProductModel(productName: "Petrol", productUnit: "Litre", productPrice: 100.0, productQuantity: 0),
    ProductModel(productName: "Diesel", productUnit: "Litre", productPrice: 90.0, productQuantity: 0),
    ProductModel(productName: "Kerosene", productUnit: "Litre", productPrice: 80.0, productQuantity: 0),
    ProductModel(productName: "Octane", productUnit: "Litre", productPrice: 80.0, productQuantity: 0),
  ];


}