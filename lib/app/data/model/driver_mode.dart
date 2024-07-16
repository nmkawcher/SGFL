
List<DriverModel> driverModelFromJson(List str) => List<DriverModel>.from(str.map((x) => DriverModel.fromJson(x)));

class DriverModel {
  int? id;
  String? userId;
  User? user;
  String? lorryId;
  String? contractorId;
  String? name;
  String? bnName;

  DriverModel({
    this.id,
    this.userId,
    this.user,
    this.lorryId,
    this.contractorId,
    this.name,
    this.bnName,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
    id: json["id"],
    userId: json["user_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    lorryId: json["lorry_id"],
    contractorId: json["contractor_id"],
    name: json["name"],
    bnName: json["bn_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "user": user?.toJson(),
    "lorry_id": lorryId,
    "contractor_id": contractorId,
    "name": name,
    "bn_name": bnName,
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? phoneNo;
  dynamic avatar;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNo: json["phone_no"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_no": phoneNo,
    "avatar": avatar,
  };
}
