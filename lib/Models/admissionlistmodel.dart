// To parse this JSON data, do
//
//     final admissionListListModel = admissionListListModelFromMap(jsonString);

import 'dart:convert';

AdmissionListListModel admissionListListModelFromMap(String str) =>
    AdmissionListListModel.fromMap(json.decode(str));

String admissionListListModelToMap(AdmissionListListModel data) =>
    json.encode(data.toMap());

class AdmissionListListModel {
  AdmissionListListModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final dynamic status;
  final List<AdmissionListResponse> response;
  final dynamic code;

  factory AdmissionListListModel.fromMap(Map<String, dynamic> json) =>
      AdmissionListListModel(
        status: json["status"] == null ? null : json["status"],
        response: List<AdmissionListResponse>.from(
            json["response"].map((x) => AdmissionListResponse.fromMap(x))),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toMap())),
        "code": code == null ? null : code,
      };
}

class AdmissionListResponse {
  AdmissionListResponse({
    required this.id,
    required this.name,
    required this.collegeName,
    required this.courseName,
    required this.status,
    required this.firstYearFeeStatus,
    this.commission,
    required this.commissionSent,
  });

  final dynamic id;
  final dynamic name;
  final dynamic collegeName;
  final dynamic courseName;
  final dynamic status;
  final dynamic firstYearFeeStatus;
  final dynamic commission;
  final dynamic commissionSent;

  factory AdmissionListResponse.fromMap(Map<String, dynamic> json) =>
      AdmissionListResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        collegeName: json["college_name"] == null ? null : json["college_name"],
        courseName: json["course_name"] == null ? null : json["course_name"],
        status: json["status"] == null ? null : json["status"],
        firstYearFeeStatus: json["first_year_fee_status"] == null
            ? null
            : json["first_year_fee_status"],
        commission: json["commission"],
        commissionSent:
            json["commission_sent"] == null ? null : json["commission_sent"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "college_name": collegeName == null ? null : collegeName,
        "course_name": courseName == null ? null : courseName,
        "status": status == null ? null : status,
        "first_year_fee_status":
            firstYearFeeStatus == null ? null : firstYearFeeStatus,
        "commission": commission,
        "commission_sent": commissionSent == null ? null : commissionSent,
      };
}
