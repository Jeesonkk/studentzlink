// To parse this JSON data, do
//
//     final commissionModel = commissionModelFromMap(jsonString);

import 'dart:convert';

CommissionModel commissionModelFromMap(String str) =>
    CommissionModel.fromMap(json.decode(str));

String commissionModelToMap(CommissionModel data) => json.encode(data.toMap());

class CommissionModel {
  CommissionModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final String status;
  final List<CommissionResponse> response;
  final int code;

  factory CommissionModel.fromMap(Map<String, dynamic> json) => CommissionModel(
        status: json["status"] == null ? null : json["status"],
        response: List<CommissionResponse>.from(
            json["response"].map((x) => CommissionResponse.fromMap(x))),
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

class CommissionResponse {
  CommissionResponse({
    required this.id,
    required this.name,
    required this.applicationId,
    required this.commissionAmount,
    required this.collegeName,
    required this.date,
    required this.status,
    required this.paid,
  });

  final dynamic id;
  final dynamic name;
  final dynamic applicationId;
  final dynamic commissionAmount;
  final dynamic collegeName;
  final dynamic date;
  final dynamic status;
  final dynamic paid;

  factory CommissionResponse.fromMap(Map<String, dynamic> json) =>
      CommissionResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        applicationId:
            json["application_id"] == null ? null : json["application_id"],
        commissionAmount: json["commission_amount"] == null
            ? null
            : json["commission_amount"],
        collegeName: json["college_name"] == null ? null : json["college_name"],
        date: DateTime.parse(json["date"]),
        status: json["status"] == null ? null : json["status"],
        paid: json["paid"] == null ? null : json["paid"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "application_id": applicationId == null ? null : applicationId,
        "commission_amount": commissionAmount == null ? null : commissionAmount,
        "college_name": collegeName == null ? null : collegeName,
        "date": date == null ? null : date.toIso8601String(),
        "status": status == null ? null : status,
        "paid": paid == null ? null : paid,
      };
}
