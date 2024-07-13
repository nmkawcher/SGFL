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
  Customer? customer;
  Dipo? dipo;
  String? orderNo;
  String? quantityLiter;
  String? totalAmount;
  String? totalLorryPhysically;
  String? date;
  String? note;
  String? status;
  bool? editable;
  List<OrderItem>? orderItems;

  Order({
    this.id,
    this.customer,
    this.dipo,
    this.orderNo,
    this.quantityLiter,
    this.totalAmount,
    this.totalLorryPhysically,
    this.date,
    this.note,
    this.status,
    this.editable,
    this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    dipo: json["dipo"] == null ? null : Dipo.fromJson(json["dipo"]),
    orderNo: json["order_no"],
    quantityLiter: json["quantity_liter"],
    totalAmount: json["total_amount"],
    totalLorryPhysically: json["total_lorry_physically"],
    date: json["date"],
    note: json["note"],
    status: json["status"],
    editable: json["editable"],
    orderItems: json["orderItems"] == null ? [] : List<OrderItem>.from(json["orderItems"]!.map((x) => OrderItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer": customer?.toJson(),
    "dipo": dipo?.toJson(),
    "order_no": orderNo,
    "quantity_liter": quantityLiter,
    "total_amount": totalAmount,
    "total_lorry_physically": totalLorryPhysically,
    "date": date,
    "note": note,
    "status": status,
    "editable": editable,
    "orderItems": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
  };
}

class Customer {
  int? id;
  String? name;
  String? bnName;
  String? shortName;
  String? address;
  String? bnAddress;
  String? adminName;
  String? contactPhone;
  String? contactEmail;

  Customer({
    this.id,
    this.name,
    this.bnName,
    this.shortName,
    this.address,
    this.bnAddress,
    this.adminName,
    this.contactPhone,
    this.contactEmail,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    bnName: json["bn_name"],
    shortName: json["short_name"],
    address: json["address"],
    bnAddress: json["bn_address"],
    adminName: json["admin_name"],
    contactPhone: json["contact_phone"],
    contactEmail: json["contact_email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bn_name": bnName,
    "short_name": shortName,
    "address": address,
    "bn_address": bnAddress,
    "admin_name": adminName,
    "contact_phone": contactPhone,
    "contact_email": contactEmail,
  };
}

class Dipo {
  int? id;
  String? name;
  String? bnName;
  String? address;
  String? bnAddress;

  Dipo({
    this.id,
    this.name,
    this.bnName,
    this.address,
    this.bnAddress,
  });

  factory Dipo.fromJson(Map<String, dynamic> json) => Dipo(
    id: json["id"],
    name: json["name"],
    bnName: json["bn_name"],
    address: json["address"],
    bnAddress: json["bn_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bn_name": bnName,
    "address": address,
    "bn_address": bnAddress,
  };
}

class OrderItem {
  int? id;
  String? orderId;
  String? product;
  String? quantityLiter;
  String? perLiterPrice;
  String? totalAmount;
  String? baseQuantityLiter;
  String? upperQuantityLiter;
  String? date;
  List<dynamic>? additional;
  List<ItemLorry>? itemLorries;

  OrderItem({
    this.id,
    this.orderId,
    this.product,
    this.quantityLiter,
    this.perLiterPrice,
    this.totalAmount,
    this.baseQuantityLiter,
    this.upperQuantityLiter,
    this.date,
    this.additional,
    this.itemLorries,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    orderId: json["order_id"],
    product: json["product"],
    quantityLiter: json["quantity_liter"],
    perLiterPrice: json["per_liter_price"],
    totalAmount: json["total_amount"],
    baseQuantityLiter: json["base_quantity_liter"],
    upperQuantityLiter: json["upper_quantity_liter"],
    date: json["date"],
    additional: json["additional"] == null ? [] : List<dynamic>.from(json["additional"]!.map((x) => x)),
    itemLorries: json["itemLorries"] == null ? [] : List<ItemLorry>.from(json["itemLorries"]!.map((x) => ItemLorry.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product": product,
    "quantity_liter": quantityLiter,
    "per_liter_price": perLiterPrice,
    "total_amount": totalAmount,
    "base_quantity_liter": baseQuantityLiter,
    "upper_quantity_liter": upperQuantityLiter,
    "date": date,
    "additional": additional == null ? [] : List<dynamic>.from(additional!.map((x) => x)),
    "itemLorries": itemLorries == null ? [] : List<dynamic>.from(itemLorries!.map((x) => x.toJson())),
  };
}

class ItemLorry {
  int? id;
  String? orderId;
  String? product;
  Customer? contractor;
  Lorry? lorry;
  String? challanNo;
  String? quantityLiter;
  String? perLiterPrice;
  String? perLiterVat;
  String? totalAmount;
  String? totalLorryBaseEq;
  String? quantityReceived;
  String? date;
  Notes? notes;
  String? status;
  bool? assignable;
  bool? editable;

  ItemLorry({
    this.id,
    this.orderId,
    this.product,
    this.contractor,
    this.lorry,
    this.challanNo,
    this.quantityLiter,
    this.perLiterPrice,
    this.perLiterVat,
    this.totalAmount,
    this.totalLorryBaseEq,
    this.quantityReceived,
    this.date,
    this.notes,
    this.status,
    this.assignable,
    this.editable,
  });

  factory ItemLorry.fromJson(Map<String, dynamic> json) => ItemLorry(
    id: json["id"],
    orderId: json["order_id"],
    product: json["product"],
    contractor: json["contractor"] == null ? null : Customer.fromJson(json["contractor"]),
    lorry: json["lorry"] == null ? null : Lorry.fromJson(json["lorry"]),
    challanNo: json["challan_no"],
    quantityLiter: json["quantity_liter"],
    perLiterPrice: json["per_liter_price"],
    perLiterVat: json["per_liter_vat"],
    totalAmount: json["total_amount"],
    totalLorryBaseEq: json["total_lorry_base_eq"],
    quantityReceived: json["quantity_received"],
    date: json["date"],
    notes: json["notes"] == null ? null : Notes.fromJson(json["notes"]),
    status: json["status"],
    assignable: json["assignable"],
    editable: json["editable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product": product,
    "contractor": contractor?.toJson(),
    "lorry": lorry?.toJson(),
    "challan_no": challanNo,
    "quantity_liter": quantityLiter,
    "per_liter_price": perLiterPrice,
    "per_liter_vat": perLiterVat,
    "total_amount": totalAmount,
    "total_lorry_base_eq": totalLorryBaseEq,
    "quantity_received": quantityReceived,
    "date": date,
    "notes": notes?.toJson(),
    "status": status,
    "assignable": assignable,
    "editable": editable,
  };
}

class Lorry {
  int? id;
  String? regNo;
  String? capacityLiter;

  Lorry({
    this.id,
    this.regNo,
    this.capacityLiter,
  });

  factory Lorry.fromJson(Map<String, dynamic> json) => Lorry(
    id: json["id"],
    regNo: json["reg_no"],
    capacityLiter: json["capacity_liter"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reg_no": regNo,
    "capacity_liter": capacityLiter,
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
