
class LoginRequest {
  String? phoneNo;
  String? password;


  LoginRequest(
      {
        this.phoneNo,
        this.password
      }
  );

  Map<String, dynamic> toJson() => {
        "phone_no": phoneNo,
        "password": password
      };
}

class LoginResponse {
  User? data;
  String? token;
  Organisation? organisation;

  LoginResponse({
    this.data,
    this.token,
    this.organisation,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    data: json["data"] == null ? null : User.fromJson(json["data"]),
    token: json["token"],
    organisation: json["organisation"] == null ? null : Organisation.fromJson(json["organisation"]),
  );

}

class User {
  int? id;
  String? name;
  String? bnName;
  String? designation;
  String? bnDesignation;
  String? email;
  String? phoneNo;
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
    avatar: json["avatar"],
    lastLogin: json["last_login"],
  );
}

class Organisation {
  int? id;
  String? name;
  String? bnName;
  String? shortName;
  String? type;
  String? category;
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

