import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  List<Order>? data;
  Links? links;
  Meta? meta;

  OrderModel({
    this.data,
    this.links,
    this.meta,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    data: json["data"] == null ? [] : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Order {
  int? id;
  String? supplierId;
  String? supplier;
  String? customerId;
  String? customer;
  String? dipoId;
  String? dipo;
  String? orderNo;
  String? quantityLiter;
  String? quantityBbl;
  String? netAmount;
  String? vatAmount;
  String? totalAmount;
  String? totalLorryPhysically;
  String? totalLorryBaseEq;
  String? date;
  String? orderAt;
  dynamic approvedAt;
  dynamic canceledAt;
  String? note;
  String? status;
  bool? editable;
  List<Product>? orderItems;

  Order({
    this.id,
    this.supplierId,
    this.supplier,
    this.customerId,
    this.customer,
    this.dipoId,
    this.dipo,
    this.orderNo,
    this.quantityLiter,
    this.quantityBbl,
    this.netAmount,
    this.vatAmount,
    this.totalAmount,
    this.totalLorryPhysically,
    this.totalLorryBaseEq,
    this.date,
    this.orderAt,
    this.approvedAt,
    this.canceledAt,
    this.note,
    this.status,
    this.editable,
    this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    supplierId: json["supplier_id"],
    supplier: json["supplier"],
    customerId: json["customer_id"],
    customer: json["customer"],
    dipoId: json["dipo_id"],
    dipo: json["dipo"],
    orderNo: json["order_no"],
    quantityLiter: json["quantity_liter"],
    quantityBbl: json["quantity_bbl"],
    netAmount: json["net_amount"],
    vatAmount: json["vat_amount"],
    totalAmount: json["total_amount"],
    totalLorryPhysically: json["total_lorry_physically"],
    totalLorryBaseEq: json["total_lorry_base_eq"],
    date: json["date"],
    orderAt: json["order_at"],
    approvedAt: json["approved_at"],
    canceledAt: json["canceled_at"],
    note: json["note"],
    status: json["status"],
    editable: json["editable"],
    orderItems: json["orderItems"] == null ? [] : List<Product>.from(json["orderItems"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supplier_id": supplierId,
    "supplier": supplier,
    "customer_id": customerId,
    "customer": customer,
    "dipo_id": dipoId,
    "dipo": dipo,
    "order_no": orderNo,
    "quantity_liter": quantityLiter,
    "quantity_bbl": quantityBbl,
    "net_amount": netAmount,
    "vat_amount": vatAmount,
    "total_amount": totalAmount,
    "total_lorry_physically": totalLorryPhysically,
    "total_lorry_base_eq": totalLorryBaseEq,
    "date": date,
    "order_at": orderAt,
    "approved_at": approvedAt,
    "canceled_at": canceledAt,
    "note": note,
    "status": status,
    "editable": editable,
    "orderItems": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
  };
}

class Product {
  int? id;
  String? orderId;
  String? productId;
  String? product;
  String? productType;
  String? quantityLiter;
  String? quantityBbl;
  String? perLiterPrice;
  String? perLiterVat;
  String? netAmount;
  String? vatAmount;
  String? shippingCost;
  String? totalAmount;
  String? payment;
  String? totalLorryPhysically;
  String? totalLorryBaseEq;
  String? date;
  List<dynamic>? additional;
  List<ItemLorry>? itemLorries;

  Product({
    this.id,
    this.orderId,
    this.productId,
    this.product,
    this.productType,
    this.quantityLiter,
    this.quantityBbl,
    this.perLiterPrice,
    this.perLiterVat,
    this.netAmount,
    this.vatAmount,
    this.shippingCost,
    this.totalAmount,
    this.payment,
    this.totalLorryPhysically,
    this.totalLorryBaseEq,
    this.date,
    this.additional,
    this.itemLorries,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    product: json["product"],
    productType: json["product_type"],
    quantityLiter: json["quantity_liter"],
    quantityBbl: json["quantity_bbl"],
    perLiterPrice: json["per_liter_price"],
    perLiterVat: json["per_liter_vat"],
    netAmount: json["net_amount"],
    vatAmount: json["vat_amount"],
    shippingCost: json["shipping_cost"],
    totalAmount: json["total_amount"],
    payment: json["payment"],
    totalLorryPhysically: json["total_lorry_physically"],
    totalLorryBaseEq: json["total_lorry_base_eq"],
    date: json["date"],
    additional: json["additional"] == null ? [] : List<dynamic>.from(json["additional"]!.map((x) => x)),
    itemLorries: json["itemLorries"] == null ? [] : List<ItemLorry>.from(json["itemLorries"]!.map((x) => ItemLorry.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "product": product,
    "product_type": productType,
    "quantity_liter": quantityLiter,
    "quantity_bbl": quantityBbl,
    "per_liter_price": perLiterPrice,
    "per_liter_vat": perLiterVat,
    "net_amount": netAmount,
    "vat_amount": vatAmount,
    "shipping_cost": shippingCost,
    "total_amount": totalAmount,
    "payment": payment,
    "total_lorry_physically": totalLorryPhysically,
    "total_lorry_base_eq": totalLorryBaseEq,
    "date": date,
    "additional": additional == null ? [] : List<dynamic>.from(additional!.map((x) => x)),
    "itemLorries": itemLorries == null ? [] : List<dynamic>.from(itemLorries!.map((x) => x.toJson())),
  };
}

class ItemLorry {
  int? id;
  String? orderId;
  String? orderItemId;
  String? productId;
  String? product;
  String? contractorId;
  String? contractor;
  String? lorryId;
  String? lorry;
  String? challanNo;
  String? quantityLiter;
  String? perLiterPrice;
  String? perLiterVat;
  String? netAmount;
  String? vatAmount;
  String? totalAmount;
  String? totalLorryBaseEq;
  String? quantityReceived;
  String? shortage;
  String? allowableLoss;
  String? shortageCompensated;
  String? arrivedAt;
  String? shippedAt;
  String? deliveredAt;
  dynamic canceledAt;
  Notes? notes;
  bool? assignable;
  bool? editable;

  ItemLorry({
    this.id,
    this.orderId,
    this.orderItemId,
    this.productId,
    this.product,
    this.contractorId,
    this.contractor,
    this.lorryId,
    this.lorry,
    this.challanNo,
    this.quantityLiter,
    this.perLiterPrice,
    this.perLiterVat,
    this.netAmount,
    this.vatAmount,
    this.totalAmount,
    this.totalLorryBaseEq,
    this.quantityReceived,
    this.shortage,
    this.allowableLoss,
    this.shortageCompensated,
    this.arrivedAt,
    this.shippedAt,
    this.deliveredAt,
    this.canceledAt,
    this.notes,
    this.assignable,
    this.editable,
  });

  factory ItemLorry.fromJson(Map<String, dynamic> json) => ItemLorry(
    id: json["id"],
    orderId: json["order_id"],
    orderItemId: json["order_item_id"],
    productId: json["product_id"],
    product: json["product"],
    contractorId: json["contractor_id"],
    contractor: json["contractor"],
    lorryId: json["lorry_id"],
    lorry: json["lorry"],
    challanNo: json["challan_no"],
    quantityLiter: json["quantity_liter"],
    perLiterPrice: json["per_liter_price"],
    perLiterVat: json["per_liter_vat"],
    netAmount: json["net_amount"],
    vatAmount: json["vat_amount"],
    totalAmount: json["total_amount"],
    totalLorryBaseEq: json["total_lorry_base_eq"],
    quantityReceived: json["quantity_received"],
    shortage: json["shortage"],
    allowableLoss: json["allowable_loss"],
    shortageCompensated: json["shortage_compensated"],
    arrivedAt: json["arrived_at"],
    shippedAt: json["shipped_at"],
    deliveredAt: json["delivered_at"],
    canceledAt: json["canceled_at"],
    notes: json["notes"] == null ? null : Notes.fromJson(json["notes"]),
    assignable: json["assignable"],
    editable: json["editable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "order_item_id": orderItemId,
    "product_id": productId,
    "product": product,
    "contractor_id": contractorId,
    "contractor": contractor,
    "lorry_id": lorryId,
    "lorry": lorry,
    "challan_no": challanNo,
    "quantity_liter": quantityLiter,
    "per_liter_price": perLiterPrice,
    "per_liter_vat": perLiterVat,
    "net_amount": netAmount,
    "vat_amount": vatAmount,
    "total_amount": totalAmount,
    "total_lorry_base_eq": totalLorryBaseEq,
    "quantity_received": quantityReceived,
    "shortage": shortage,
    "allowable_loss": allowableLoss,
    "shortage_compensated": shortageCompensated,
    "arrived_at": arrivedAt,
    "shipped_at": shippedAt,
    "delivered_at": deliveredAt,
    "canceled_at": canceledAt,
    "notes": notes?.toJson(),
    "assignable": assignable,
    "editable": editable,
  };
}

class Notes {
  String? dnRemarks;

  Notes({
    this.dnRemarks,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    dnRemarks: json["dn_remarks"],
  );

  Map<String, dynamic> toJson() => {
    "dn_remarks": dnRemarks,
  };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
