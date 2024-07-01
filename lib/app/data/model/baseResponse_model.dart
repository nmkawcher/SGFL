class BaseResponseModel {
  String? status;
  int? statusCode;
  String? message;
  dynamic data;

  BaseResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) => BaseResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"],
  );

}
