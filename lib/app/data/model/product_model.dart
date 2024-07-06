
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

List<ProductModel> productModelFromJson(List str) => List<ProductModel>.from(str.map((x) => ProductModel.fromJson(x)));

class ProductModel {
  int? id;
  String? name;
  String? bnName;
  String? shortName;
  String? logoText;
  String? type;
  String? priceBbl;
  String? priceLiter;
  String? vatLiter;
  RxBool isSelected;

  ProductModel({
    this.id,
    this.name,
    this.bnName,
    this.shortName,
    this.logoText,
    this.type,
    this.priceBbl,
    this.priceLiter,
    this.vatLiter,
    required this.isSelected
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    bnName: json["bn_name"],
    shortName: json["short_name"],
    logoText: json["logo_text"],
    type: json["type"],
    priceBbl: json["price_bbl"],
    priceLiter: json["price_liter"],
    vatLiter: json["vat_liter"],
    isSelected: false.obs
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bn_name": bnName,
    "short_name": shortName,
    "logo_text": logoText,
    "type": type,
    "price_bbl": priceBbl,
    "price_liter": priceLiter,
    "vat_liter": vatLiter
  };
}
