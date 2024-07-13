
class LoginModel {
  User? data;
  String? token;
  Organisation? organisation;
  List<String>? orderStatus;
  String? phoneNo;
  String? password;

  LoginModel({
    this.data,
    this.token,
    this.organisation,
    this.orderStatus,
    this.phoneNo,
    this.password
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    data: json["data"] == null ? null : User.fromJson(json["data"]),
    token: json["token"],
    organisation: json["organisation"] == null ? null : Organisation.fromJson(json["organisation"]),
    orderStatus: json["orderStatus"] == null ? [] : List<String>.from(json["orderStatus"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "phone_no": phoneNo,
    "password": password
  };

}

class User {
  int? id;
  String? name;
  String? bnName;
  String? designation;
  String? bnDesignation;
  String? email;
  String? phoneNo;
  String? role;
  dynamic dipoId;
  String? avatar;
  dynamic lastLogin;

  User({
    this.id,
    this.name,
    this.bnName,
    this.designation,
    this.bnDesignation,
    this.email,
    this.phoneNo,
    this.role,
    this.dipoId,
    this.avatar,
    this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    bnName: json["bn_name"],
    designation: json["designation"],
    bnDesignation: json["bn_designation"],
    email: json["email"],
    phoneNo: json["phone_no"],
    role: json["role"],
    dipoId: json["dipo_id"],
    avatar: json["avatar"],
    lastLogin: json["last_login"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bn_name": bnName,
    "designation": designation,
    "bn_designation": bnDesignation,
    "email": email,
    "phone_no": phoneNo,
    "role": role,
    "dipo_id": dipoId,
    "avatar": avatar,
    "last_login": lastLogin,
  };

}

class Organisation {
  int? id;
  String? name;
  String? bnName;
  String? shortName;
  String? type;
  dynamic category;
  String? address;
  String? bnAddress;
  String? logo;

  Organisation({
    this.id,
    this.name,
    this.bnName,
    this.shortName,
    this.type,
    this.category,
    this.address,
    this.bnAddress,
    this.logo,
  });

  factory Organisation.fromJson(Map<String, dynamic> json) => Organisation(
    id: json["id"],
    name: json["name"],
    bnName: json["bn_name"],
    shortName: json["short_name"],
    type: json["type"],
    category: json["category"],
    address: json["address"],
    bnAddress: json["bn_address"],
    logo: json["logo"],
  );

}