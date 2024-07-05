
List<DepotModel> depotModelFromJson(List str) => List<DepotModel>.from(str.map((x) => DepotModel.fromJson(x)));


class DepotModel {
  int? id;
  String? name;
  String? bnName;
  String? shortName;
  String? type;
  String? category;
  String? address;
  String? bnAddress;
  String? logo;
  List<DepotZone>? depotZone;

  DepotModel({
    this.id,
    this.name,
    this.bnName,
    this.shortName,
    this.type,
    this.category,
    this.address,
    this.bnAddress,
    this.logo,
    this.depotZone,
  });

  factory DepotModel.fromJson(Map<String, dynamic> json) => DepotModel(
    id: json["id"],
    name: json["name"],
    bnName: json["bn_name"],
    shortName: json["short_name"],
    type: json["type"],
    category: json["category"],
    address: json["address"],
    bnAddress: json["bn_address"],
    logo: json["logo"],
    depotZone: json["dipos"] == null ? [] : List<DepotZone>.from(json["dipos"]!.map((x) => DepotZone.fromJson(x))),
  );

}

class DepotZone {
  int? id;
  String? name;
  String? bnName;
  String? shortName;
  String? postcode;
  String? address;
  String? bnAddress;
  String? logo;

  DepotZone({
    this.id,
    this.name,
    this.bnName,
    this.shortName,
    this.postcode,
    this.address,
    this.bnAddress,
    this.logo,
  });

  factory DepotZone.fromJson(Map<String, dynamic> json) => DepotZone(
    id: json["id"],
    name: json["name"],
    bnName: json["bn_name"],
    shortName: json["short_name"],
    postcode: json["postcode"],
    address: json["address"],
    bnAddress: json["bn_address"],
    logo: json["logo"],
  );

}
