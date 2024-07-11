class RequisitionReqModel {
  int? supplierId;
  int? customerId;
  int? dipoId;
  String? note;
  List<ProductReq>? items;

  RequisitionReqModel({
    this.supplierId,
    this.customerId,
    this.dipoId,
    this.note,
    this.items,
  });

  Map<String, dynamic> toJson() => {
    "supplier_id": supplierId,
    "customer_id": customerId,
    "dipo_id": dipoId,
    "note": note,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };

}

class ProductReq {
  int? productId;
  int? baseQuantity;
  int? upperQuantity;

  ProductReq({
    this.productId,
    this.baseQuantity,
    this.upperQuantity,
  });

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "base_quantity": baseQuantity,
    "upper_quantity": upperQuantity,
  };
}
