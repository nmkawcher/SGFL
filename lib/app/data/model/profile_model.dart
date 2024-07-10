import 'package:dio/dio.dart';

class ProfileModel {
  int? id;
  String? name;
  String? bnName;
  String? designation;
  String? bnDesignation;
  String? email;
  String? phoneNo;
  String? avatar;
  MultipartFile? image;

  ProfileModel({
    this.id,
    this.name,
    this.bnName,
    this.designation,
    this.bnDesignation,
    this.email,
    this.phoneNo,
    this.avatar,
    this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    name: json["name"],
    bnName: json["bn_name"],
    designation: json["designation"],
    bnDesignation: json["bn_designation"],
    email: json["email"],
    phoneNo: json["phone_no"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bn_name": bnName,
    "designation": designation,
    "bn_designation": bnDesignation,
    "email": email,
    "phone_no": phoneNo,
    "avatar": avatar,
  };

  Map<String, dynamic> profileUpdateJson() => {
    "_method": "PUT", // This is a hidden field in the form, which is used to override the POST method.
    "name": name,
    "bn_name": bnName,
    "email": email,
    "avatar": image,
  };

}
