import 'dart:convert';

import 'package:get/get.dart';

List<UnassignedModel> unAssignModelFromJson(List str) => List<UnassignedModel>.from(str.map((x) => UnassignedModel.fromJson(x)));

String unAssignModelToJson(List<UnassignedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnassignedModel {
  int? id;
  String? orderId;
  String? product;
  dynamic contractor;
  dynamic lorry;
  String? challanNo;
  String? quantityLiter;
  String? perLiterPrice;
  String? perLiterVat;
  String? totalAmount;
  String? totalLorryBaseEq;
  String? quantityReceived;
  String? date;
  dynamic notes;
  String? status;
  bool? assignable;
  bool? editable;
  Order? order;
  RxBool isSelected;

  UnassignedModel({
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
    required this.isSelected
  });

  factory UnassignedModel.fromJson(Map<String, dynamic> json) => UnassignedModel(
    id: json["id"],
    orderId: json["order_id"],
    product: json["product"],
    contractor: json["contractor"],
    lorry: json["lorry"],
    challanNo: json["challan_no"],
    quantityLiter: json["quantity_liter"],
    perLiterPrice: json["per_liter_price"],
    perLiterVat: json["per_liter_vat"],
    totalAmount: json["total_amount"],
    totalLorryBaseEq: json["total_lorry_base_eq"],
    quantityReceived: json["quantity_received"],
    date: json["date"],
    notes: json["notes"],
    status: json["status"],
    assignable: json["assignable"],
    editable: json["editable"],
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    isSelected: false.obs
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product": product,
    "contractor": contractor,
    "lorry": lorry,
    "challan_no": challanNo,
    "quantity_liter": quantityLiter,
    "per_liter_price": perLiterPrice,
    "per_liter_vat": perLiterVat,
    "total_amount": totalAmount,
    "total_lorry_base_eq": totalLorryBaseEq,
    "quantity_received": quantityReceived,
    "date": date,
    "notes": notes,
    "status": status,
    "assignable": assignable,
    "editable": editable,
    "order": order?.toJson(),
  };
}

class Order {
  Customer? customer;
  Dipo? dipo;

  Order({
    this.customer,
    this.dipo,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    dipo: json["dipo"] == null ? null : Dipo.fromJson(json["dipo"]),
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

class AssignModel{
  int? itemId;
  int? contractorId;
  int? lorryId;
  int? driverId;

  AssignModel({
    this.itemId,
    this.contractorId,
    this.lorryId,
    this.driverId
  });

  Map<String, dynamic> toJson(){
   var map = <String, dynamic>{'item_id': itemId};
    if(contractorId != null){
      map['contractor_id'] = contractorId;
    }
    if(lorryId != null){
      map['lorry_id'] = lorryId;
    }
    if(driverId != null){
      map['driver_id'] = driverId;
    }
    return map;
  }
}