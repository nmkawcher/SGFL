import 'dart:convert';

List<LorryModel> lorryModelFromJson(List str) => List<LorryModel>.from(str.map((x) => LorryModel.fromJson(x)));

String lorryModelToJson(List<LorryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LorryModel {
  int? id;
  String? contractorId;
  String? regNo;
  String? bnRegNo;
  DateTime? regExpiredDate;
  DateTime? calLicenseExpiredDate;
  DateTime? explosiveLicenseExpiredDate;
  String? capacityLiter;

  LorryModel({
    this.id,
    this.contractorId,
    this.regNo,
    this.bnRegNo,
    this.regExpiredDate,
    this.calLicenseExpiredDate,
    this.explosiveLicenseExpiredDate,
    this.capacityLiter,
  });

  factory LorryModel.fromJson(Map<String, dynamic> json) => LorryModel(
    id: json["id"],
    contractorId: json["contractor_id"],
    regNo: json["reg_no"],
    bnRegNo: json["bn_reg_no"],
    regExpiredDate: json["reg_expired_date"] == null ? null : DateTime.parse(json["reg_expired_date"]),
    calLicenseExpiredDate: json["cal_license_expired_date"] == null ? null : DateTime.parse(json["cal_license_expired_date"]),
    explosiveLicenseExpiredDate: json["explosive_license_expired_date"] == null ? null : DateTime.parse(json["explosive_license_expired_date"]),
    capacityLiter: json["capacity_liter"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contractor_id": contractorId,
    "reg_no": regNo,
    "bn_reg_no": bnRegNo,
    "reg_expired_date": "${regExpiredDate!.year.toString().padLeft(4, '0')}-${regExpiredDate!.month.toString().padLeft(2, '0')}-${regExpiredDate!.day.toString().padLeft(2, '0')}",
    "cal_license_expired_date": "${calLicenseExpiredDate!.year.toString().padLeft(4, '0')}-${calLicenseExpiredDate!.month.toString().padLeft(2, '0')}-${calLicenseExpiredDate!.day.toString().padLeft(2, '0')}",
    "explosive_license_expired_date": "${explosiveLicenseExpiredDate!.year.toString().padLeft(4, '0')}-${explosiveLicenseExpiredDate!.month.toString().padLeft(2, '0')}-${explosiveLicenseExpiredDate!.day.toString().padLeft(2, '0')}",
    "capacity_liter": capacityLiter,
  };
}
