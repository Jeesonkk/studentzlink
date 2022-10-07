// To parse this JSON data, do
//
//     final applicationListModel = applicationListModelFromMap(jsonString);

import 'dart:convert';

ApplicationListModel applicationListModelFromMap(String str) =>
    ApplicationListModel.fromMap(json.decode(str));

String applicationListModelToMap(ApplicationListModel data) =>
    json.encode(data.toMap());

class ApplicationListModel {
  ApplicationListModel({
    required this.status,
    required this.response,
    required this.code,
  });

  final dynamic status;
  final List<ApplicationListResponse> response;
  final dynamic code;

  factory ApplicationListModel.fromMap(Map<String, dynamic> json) =>
      ApplicationListModel(
        status: json["status"] == null ? null : json["status"],
        response: List<ApplicationListResponse>.from(
            json["response"].map((x) => ApplicationListResponse.fromMap(x))),
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

class ApplicationListResponse {
  ApplicationListResponse({
    required this.id,
    required this.applicationId,
    required this.name,
    required this.course,
    required this.collegeName,
    required this.status,
    required this.verify,
    required this.documentVerified,
    required this.applicationFee,
  });

  final dynamic id;
  final dynamic applicationId;
  final dynamic name;
  final dynamic course;
  final dynamic collegeName;
  final dynamic status;
  final dynamic verify;
  final dynamic documentVerified;
  final dynamic applicationFee;

  factory ApplicationListResponse.fromMap(Map<String, dynamic> json) =>
      ApplicationListResponse(
        id: json["id"] == null ? null : json["id"],
        applicationId:
            json["application_id"] == null ? null : json["application_id"],
        name: json["name"] == null ? null : json["name"],
        course: json["course"] == null ? null : json["course"],
        collegeName: json["college_name"] == null ? null : json["college_name"],
        status: json["status"] == null ? null : json["status"],
        verify: json["verify"] == null ? null : json["verify"],
        documentVerified: json["document_verified"] == null
            ? null
            : json["document_verified"],
        applicationFee:
            json["application_fee"] == null ? null : json["application_fee"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "application_id": applicationId == null ? null : applicationId,
        "name": name == null ? null : name,
        "course": course == null ? null : course,
        "college_name": collegeName == null ? null : collegeName,
        "status": status == null ? null : status,
        "verify": verify == null ? null : verify,
        "document_verified": documentVerified == null ? null : documentVerified,
        "application_fee": applicationFee == null ? null : applicationFee,
      };
}
