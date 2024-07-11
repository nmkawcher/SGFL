class HomeModel {
  List<Stat>? stats;
  List<LatestOrder>? latestOrders;

  HomeModel({
    this.stats,
    this.latestOrders,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    stats: json["stats"] == null ? [] : List<Stat>.from(json["stats"]!.map((x) => Stat.fromJson(x))),
    latestOrders: json["latestOrders"] == null ? [] : List<LatestOrder>.from(json["latestOrders"]!.map((x) => LatestOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "stats": stats == null ? [] : List<dynamic>.from(stats!.map((x) => x.toJson())),
    "latestOrders": latestOrders == null ? [] : List<dynamic>.from(latestOrders!.map((x) => x.toJson())),
  };
}

class LatestOrder {
  int? id;
  String? orderId;
  String? orderItemId;
  String? productId;
  String? contractorId;
  String? lorryId;
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
  String? date;
  String? arrivedAt;
  String? shippedAt;
  String? deliveredAt;
  dynamic canceledAt;
  Notes? notes;
  String? status;
  bool? assignable;
  bool? editable;
  Order? order;

  LatestOrder({
    this.id,
    this.orderId,
    this.orderItemId,
    this.productId,
    this.contractorId,
    this.lorryId,
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
    this.date,
    this.arrivedAt,
    this.shippedAt,
    this.deliveredAt,
    this.canceledAt,
    this.notes,
    this.status,
    this.assignable,
    this.editable,
    this.order,
  });

  factory LatestOrder.fromJson(Map<String, dynamic> json) => LatestOrder(
    id: json["id"],
    orderId: json["order_id"],
    orderItemId: json["order_item_id"],
    productId: json["product_id"],
    contractorId: json["contractor_id"],
    lorryId: json["lorry_id"],
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
    date: json["date"],
    arrivedAt: json["arrived_at"],
    shippedAt: json["shipped_at"],
    deliveredAt: json["delivered_at"],
    canceledAt: json["canceled_at"],
    notes: json["notes"] == null ? null : Notes.fromJson(json["notes"]),
    status: json["status"],
    assignable: json["assignable"],
    editable: json["editable"],
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "order_item_id": orderItemId,
    "product_id": productId,
    "contractor_id": contractorId,
    "lorry_id": lorryId,
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
    "date": date,
    "arrived_at": arrivedAt,
    "shipped_at": shippedAt,
    "delivered_at": deliveredAt,
    "canceled_at": canceledAt,
    "notes": notes?.toJson(),
    "status": status,
    "assignable": assignable,
    "editable": editable,
    "order": order?.toJson(),
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

class Order {
  Customer? customer;
  Customer? dipo;

  Order({
    this.customer,
    this.dipo,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    dipo: json["dipo"] == null ? null : Customer.fromJson(json["dipo"]),
  );

  Map<String, dynamic> toJson() => {
    "customer": customer?.toJson(),
    "dipo": dipo?.toJson(),
  };
}

class Customer {
  int? id;
  String? name;
  String? bnName;
  String? shortName;
  String? postcode;
  String? address;
  String? bnAddress;

  Customer({
    this.id,
    this.name,
    this.bnName,
    this.shortName,
    this.postcode,
    this.address,
    this.bnAddress,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    bnName: json["bn_name"],
    shortName: json["short_name"],
    postcode: json["postcode"],
    address: json["address"],
    bnAddress: json["bn_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bn_name": bnName,
    "short_name": shortName,
    "postcode": postcode,
    "address": address,
    "bn_address": bnAddress,
  };
}

class Stat {
  String? label;
  dynamic value;

  Stat({
    this.label,
    this.value,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
