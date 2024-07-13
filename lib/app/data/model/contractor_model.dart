import 'dart:convert';

ContractorOrderModel orderModelFromJson(String str) => ContractorOrderModel.fromJson(json.decode(str));

String orderModelToJson(ContractorOrderModel data) => json.encode(data.toJson());

class ContractorOrderModel {
  List<ContractorOrder>? data;
  Links? links;
  Meta? meta;

  ContractorOrderModel({
    this.data,
    this.links,
    this.meta,
  });

  factory ContractorOrderModel.fromJson(Map<String, dynamic> json) => ContractorOrderModel(
    data: json["data"] == null ? [] : List<ContractorOrder>.from(json["data"]!.map((x) => ContractorOrder.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };
}

class ContractorOrder {
  int? id;
  String? orderId;
  String? product;
  Contractor? contractor;
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
  OrderItem? order;

  ContractorOrder({
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
    this.order,
  });

  factory ContractorOrder.fromJson(Map<String, dynamic> json) => ContractorOrder(
    id: json["id"],
    orderId: json["order_id"],
    product: json["product"],
    contractor: json["contractor"] == null ? null : Contractor.fromJson(json["contractor"]),
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
    order: json["order"] == null ? null : OrderItem.fromJson(json["order"]),
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
    "order": order?.toJson(),
  };
}

class Contractor {
  int? id;
  String? name;
  String? bnName;
  String? address;
  String? bnAddress;
  String? adminName;
  String? contactPhone;
  String? contactEmail;
  String? shortName;

  Contractor({
    this.id,
    this.name,
    this.bnName,
    this.address,
    this.bnAddress,
    this.adminName,
    this.contactPhone,
    this.contactEmail,
    this.shortName,
  });

  factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
    id: json["id"],
    name: json["name"],
    bnName: json["bn_name"],
    address: json["address"],
    bnAddress: json["bn_address"],
    adminName: json["admin_name"],
    contactPhone: json["contact_phone"],
    contactEmail: json["contact_email"],
    shortName: json["short_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bn_name": bnName,
    "address": address,
    "bn_address": bnAddress,
    "admin_name": adminName,
    "contact_phone": contactPhone,
    "contact_email": contactEmail,
    "short_name": shortName,
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
  Contractor? customer;
  Dipo? dipo;

  OrderItem({
    this.customer,
    this.dipo,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    customer: json["customer"] == null ? null : Contractor.fromJson(json["customer"]),
    dipo: json["dipo"] == null ? null : Dipo.fromJson(json["dipo"]),
  );

  Map<String, dynamic> toJson() => {
    "customer": customer?.toJson(),
    "dipo": dipo?.toJson(),
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
